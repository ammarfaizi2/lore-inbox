Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUITEWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUITEWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 00:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUITEWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 00:22:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:13507 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265973AbUITEWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 00:22:19 -0400
Date: Sun, 19 Sep 2004 21:19:37 -0700
From: Greg KH <greg@kroah.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
Message-ID: <20040920041937.GC5344@kroah.com>
References: <414C9003.9070707@softhome.net> <20040918213023.GB1901@kroah.com> <414CCD88.30001@softhome.net> <20040919004115.GB18309@kroah.com> <414D40CD.8060202@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414D40CD.8060202@softhome.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 10:18:21AM +0200, Ihar 'Philips' Filipau wrote:
> Greg KH wrote:
> >
> >>P.P.S. Another day, I hope, you will understand that right system need 
> >>to provide people with two opposite ways of doing things. Sometimes it 
> >>is advantage to be event-based and asynchronous, sometimes it is very 
> >>convient to be dumb & synchronous.
> >
> >My point is we _can not_ be dumb and synchronous in this situation.  It
> >just will not work with busses that have devices that can come and go as
> >the system is running.  It is pretty much impossible to correctly do
> >what you are proposing.  Just think about the different situations that
> >we have to handle properly.
> >
> 
>   Example? Your "we can not" sounds like "we not capable enough to 
> implement."

Ok, you've found me out.  I'm too dumb to solve this problem, sorry.
So please send me your patch to implement this and we will take it from
there.

>    I thought that discovery deterministic process. What I'm missing?

Hahaha, no way is it "deterministic"...

>    For now, You haven't gave any example besides "slow USB hub" - but 
> this is rather example which supports me: you are not going to put 
> /variable/ delays into init scripts? aren't you?

Not at all.  Again, for the last time, use /etc/dev.d to handle such
issues.  That will work if the device is found during system init time
(when the init scripts are running) or later when the system has been
running for 42 days and a new device is plugged in.

>    Here we definitely need to hide asynchronousity of process - 
> handling this volatility in user space will never work reliably.
> 
> P.S. You do not need to reply, it seems like case of init scripts is not 
> interesting for you.

It is very interesting for me.  Hence my /sbin/hotplug and udev and
/etc/dev.d development effort to solve real problems that users have
reported needing solved.

> What is for me about 90% of work I usually do 
> preparing new system. Number-wise, most of devices attached to system, 
> initialized by init scripts - and you just dumbly avoid answering that. 

I must be missing some work that I need to do to my systems when I
prepare a new one.  For some reason I don't spend any time, other than
deciding on where to mount a specific device that might possibly be
plugged in some time in the future.

> You have to modprobe/insmod harddrive & filesystem to be able run your 
> udev, after all.

Sure, that's what initramfs/initrd is for.  See the Gentoo and SuSE boot
processes for examples of how to add udev and modprobe together to get a
working system for a huge range of different platforms.

> Think about it. And people have had problems with discovery - one of
> the patches for usb-storage root fs is adding a delay and retries for
> root fs mounting. Moving problem around is easier than solving it,
> that's true.

Yes, the usb-storage root issue is a problem.  Delaying for it is one
simple solution, I don't really have another one at the moment as I
haven't spent any time trying to get it to work (much to some people's
grumblings at me, but I don't have a box with a BIOS that can boot from
a USB device...)  

After root is mounted is the real issue, which /etc/dev.d solves.

Good luck,

greg k-h
