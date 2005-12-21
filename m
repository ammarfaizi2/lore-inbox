Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVLUIqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVLUIqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 03:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVLUIqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 03:46:40 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:36439 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932320AbVLUIqj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 03:46:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YYJFGWmmdjJOuBPA3LVUGoBpz85tG8KFlc3tFwU0JPEEC3R79Gxkn6CCmuaa7DtAt+xwkx9uPntxqlH589UFO3DsXFJ0qq9PBKVmMiQlxYjRS+Pc6XH93VJNdiqP/Xw4AgLnBzGTlGgSfWNr0ClkiKAgNZ9mUCLaN9wQbUqrEvU=
Message-ID: <9a8748490512210046i5e3b8e91t408c2f3ca389e650@mail.gmail.com>
Date: Wed, 21 Dec 2005 09:46:38 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH - 2.6.15-rc5-mm3] Allow sysfs attribute files to be pollable.
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <17320.42409.336998.928150@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17320.36949.269788.520946@cse.unsw.edu.au>
	 <9a8748490512201528u316abfc0h4e33c4e027039d5f@mail.gmail.com>
	 <17320.42409.336998.928150@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, Neil Brown <neilb@suse.de> wrote:
> On Wednesday December 21, jesper.juhl@gmail.com wrote:
> > On 12/21/05, Neil Brown <neilb@suse.de> wrote:
> > >
> > > I suggested an early of this patch some time ago to see if it was an
> > > acceptable approach and got zero feedback, which presumably means it
> > > is perfect:-)
> > >
> > > I've now reviewed it, fixed up the bits I didn't like, and tested it.
> > > It works and I am happy with in.
> > >
> > > So: I would like to submit it for inclusion in a future kernel.
> > >
> > > Comments, or acks, please :-)
> > >
> > [snip]
> > > +/* Sysfs attribute files are pollable.  The idea is that you read
> > > + * the content and then you use 'poll' or 'select' to wait for
> > > + * the content to change.  When the content changes (assuming the
> > > + * manager for the kobject supports notification), poll will
> > > + * return POLLERR|POLLPRI, and select will return the fd whether
> > > + * it is waiting for read, write, or exceptions.
> > > + * Once poll/select indicates that the value has changed, you
> > > + * need to close and re-open the file, as simply seeking and reading
> > > + * again will not get new data, or reset the state of 'poll'.
> >
> > What if the value changes again between me closing and re-opening the file?
>
> You miss an intermediate event I guess.
>
> If you have a stream of events where you absolutely want to see every
> one of them, then you want something like a character-device (or one
> of several other alternative).
> That is not what this is for.
>
> However very often you don't need to see every single event.  You just
> need to know when state has changed so you can respond to the new
> state.
> That is what this patch is for.
>
> Does that answer your question?
>
Yes it does. Thanks.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
