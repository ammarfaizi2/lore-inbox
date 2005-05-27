Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVE0KFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVE0KFq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 06:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVE0KFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 06:05:46 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:34177 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262398AbVE0KF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 06:05:29 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 27 May 2005 12:03:52 +0200
To: schilling@fokus.fraunhofer.de, 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <4296F088.nail3L121R2F5@burner>
References: <4847F-8q-23@gated-at.bofh.it>
 <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org>
 <4295005F.nail2KW319F89@burner>
 <Pine.LNX.4.58.0505260205390.19389@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0505260205390.19389@be1.lrz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@gmx.de> wrote:

> [...]
> > If you don't call cdrecord as root, you will not be able to lock in memory
> > and to raise priority in order to prevent buffer underuns.
>
> My problem is the speed of the network or the fragmentation of my HD, RT
> privileges won't do the magic needed here[tm]. In fact, even a kernel
> compile while doesn't harm. On a reasonably busy system, I would probably
> have to reconsider.

If you have fragmentation problems, do you use the wrong filesystem type?
I never had any similar problem on a ufs type filesystem.

With network speed, you should set up a sufficiently designed infrastructure.
If you like to write a CD in 32x, you need 5.6 MB/s which easily goes over
a 100 MB/s network connection.


> > In addition (with 
> > Linux-2.6.8.1 or newer) you will not be able to send some of the important
> > SCSI commands mainly related to newer CD or DVD drives. As a result, cdrecord
> > cannot write DVDs or ultra speed CD-RWs or cannot do other things....
>
> If I need them, I'll notice and I can ask for them to be added.-) Your
> patch will just hide this need, but that's what your otherusers will need.

There are many other commands needed by cdrecord.
The initiator of the good/bad SCSI op code table hack claimed to have checked
cdrecord for a list of used commands. If you check the current table, you may
easily find that this cannot be true.


> Maybe the failed command should be stored and printed after burning the 
> CD, so new comands will get added quickly?

Please try to check the cdrecord source in order to understand the background.


> You'll want to grant raw disk access for some databases, which will run as
> a unprivileged user. These databases should not be able to kill HDDs.

A database may kill a hdd in many other ways. It is higly improbable that
a trustworthy database includes the knowwledge to set up a firmware to the
drive that us accepted by the drive but does not work. The same applies for
your kernel. You need to trust your database the same way as you need to trust 
your kernel.


> > The good/bad SCSI commands table that is currently used is a really bad and
> > ugly (incorrect) hack and much worse than my proposal.
>
> Your proposal has it's limitations, see above.

It has less limitations that the good/bad SCSI commands table has, see above.

> > > The fix is wrong: You're asuming root is capable of everything. This
> > > doesn't need to be true (missing CAP_SYS_RAWIO) and you'll run into a
> > > loop in that case.
> > 
> > If you are really true, then there is a design problem in Linux.
>
> No, it's a feature, see man 3 cap_get_proc.

If Linux is designed in a way that needs applications like cdrecord to be 
changed in order to include support for a Linux proprietary new security
mechanism, then the new mechanism should be rethought.


> > BTW: If Linux starts introducing fine grained rights manamement like on Solaris, why 
> > does it miss the apropriate management tools at user level?
>
> Washing dishes is faster than drying them :)

If you go into a restaurant, they wash the dishes before they serve them to you,
but they wait until they did dry before they get them out of the kitchen :-)

It is a matter of style of the kitchen personal whether to serve wet
dishes or not. 

So for the Linux equivalent: don't force users tu use interfaces that are not
yet ready for the public.


> > On Solaris, I could run cdrecord rootless if I use pfksh as my shell and if
> > the roles database would include cdrecord with its needed privilleges and me
> > as a member of the cdwriters role.
>
> There was some discusssion on LKML about non-root access to RT privileges. 
> Maybe there is something in the queue.

So it makes sense for the Linux to have a look at the Solaris implementation.
The database is much simpler to manage than what is present for Linux.

BTW: it would also make sense to implement the new holey file interface 
I designed together with the Solaris kernel crew for star.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
