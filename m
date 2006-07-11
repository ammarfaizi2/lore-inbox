Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWGKCQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWGKCQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 22:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWGKCQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 22:16:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:51854 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965077AbWGKCQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 22:16:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M0oHvsdT5b3qGY658lY1qEQnVDgRvRMhh8BM0ITrDVoaKUY6eXNfN3VZviVwRqEQtBz23a8carutsaoFgMmlvFySOGLWRIt3vsBmJhQTOWvvjTcOJ9MokApFCTpPGIkoP6P3v3ZwLfy+dqsbIjq89NsnF9PGdZT5eonRjPSxuGM=
Message-ID: <9e4733910607101916y4638c097ie26ae63a9949bc3e@mail.gmail.com>
Date: Mon, 10 Jul 2006 22:16:55 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>, "Jon Smirl" <jonsmirl@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: tty's use of file_list_lock and file_move
In-Reply-To: <20060711012904.GD30332@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>
	 <20060711012904.GD30332@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Jul 10, 2006 at 07:49:31PM -0400, Jon Smirl wrote:
> > How about the use of lock/unlock_kernel(). Is there some hidden global
> > synchronization going on? Every time lock/unlock_kernel() is used
> > there is a tty_struct available. My first thought would be to turn
> > this into a per tty spinlock. Looking at where it is used it looks
> > like it was added to protect all of the VFS calls. I see no obvious
> > coordination with other ttys that isn't handled by other locks.
>
> No, it was just a case of not being worth it to get rid of the BKL for
> the tty subsystem, since opening and closing tty's isn't exactly a
> common event.  Switching it to use a per-tty spinlock makes sense if
> we're going to rototill the code, but to be honest it's probably not
> going to make a noticeable difference on any benchmark and most
> workloads.

I'm not looking for performance gains, I'm looking more to isolate the
tty code down to a minimal set of interactions with the rest of the
kernel. RIght now it is all intertwined.

-- 
Jon Smirl
jonsmirl@gmail.com
