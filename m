Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVLUApu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVLUApu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 19:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVLUApu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 19:45:50 -0500
Received: from mx1.suse.de ([195.135.220.2]:6867 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932222AbVLUApt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 19:45:49 -0500
From: Neil Brown <neilb@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Date: Wed, 21 Dec 2005 11:45:29 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17320.42409.336998.928150@cse.unsw.edu.au>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - 2.6.15-rc5-mm3] Allow sysfs attribute files to be pollable.
In-Reply-To: message from Jesper Juhl on Wednesday December 21
References: <17320.36949.269788.520946@cse.unsw.edu.au>
	<9a8748490512201528u316abfc0h4e33c4e027039d5f@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday December 21, jesper.juhl@gmail.com wrote:
> On 12/21/05, Neil Brown <neilb@suse.de> wrote:
> >
> > I suggested an early of this patch some time ago to see if it was an
> > acceptable approach and got zero feedback, which presumably means it
> > is perfect:-)
> >
> > I've now reviewed it, fixed up the bits I didn't like, and tested it.
> > It works and I am happy with in.
> >
> > So: I would like to submit it for inclusion in a future kernel.
> >
> > Comments, or acks, please :-)
> >
> [snip]
> > +/* Sysfs attribute files are pollable.  The idea is that you read
> > + * the content and then you use 'poll' or 'select' to wait for
> > + * the content to change.  When the content changes (assuming the
> > + * manager for the kobject supports notification), poll will
> > + * return POLLERR|POLLPRI, and select will return the fd whether
> > + * it is waiting for read, write, or exceptions.
> > + * Once poll/select indicates that the value has changed, you
> > + * need to close and re-open the file, as simply seeking and reading
> > + * again will not get new data, or reset the state of 'poll'.
> 
> What if the value changes again between me closing and re-opening the file?

You miss an intermediate event I guess.

If you have a stream of events where you absolutely want to see every
one of them, then you want something like a character-device (or one
of several other alternative).
That is not what this is for.

However very often you don't need to see every single event.  You just
need to know when state has changed so you can respond to the new
state. 
That is what this patch is for.

Does that answer your question?

Thanks,
NeilBrown
