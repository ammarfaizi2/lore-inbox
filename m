Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbRIDTda>; Tue, 4 Sep 2001 15:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268133AbRIDTdU>; Tue, 4 Sep 2001 15:33:20 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:11750 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268145AbRIDTdH>; Tue, 4 Sep 2001 15:33:07 -0400
Message-Id: <5.1.0.14.2.20010904202449.00b1c040@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 04 Sep 2001 20:33:15 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: help!! tons of Z processes in 2.4.x (x > 3)
Cc: linux4u@wanadoo.es (Pau Aliagas), linux-kernel@vger.kernel.org (lkml),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <E15eLmy-0004Ki-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.33.0109042049500.2038-100000@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:23 04/09/2001, Alan Cox wrote:
> > Since 2.4.6-ac[45] until 2.4.9-ac7 I keep on getting processes in Z
> > state, mainly identd (spawned from an identd daemon), galeon (the gnome
> > browser) and mysqld.
>
>Sounds like user mode problems to me. Z is a zombie - its waiting for its
>parent to wake up and collect its exit code. Look at their ppid see what
>the parent is and is doing
>
> > An strace to the process ends immediately with the following message:
> > # strace -p 3697
> > attach: ptrace(PTRACE_ATTACH, ...): Operation not permitted
> > It doesn't matter wheater I'm root or not.
>
>Yep - it doesnt really exist except as a process slot
>
> > If I run the redhat-7.1 kernel (kernel-2.4.3-12) this doesn=A1't happen, =
> > so
> > I deduce it has something to do with recent changes.
> >
> > I'm surprised that I'm the only one with this problem.
>
>So far you are

I am seeing zombies as well. This coincided with me installing SuSE 7.2 on 
my Athlon so I thought it to be user space...

I have only really noticed this with cron processes. A random example, ps 
ax says:

9862 ? Z 0:00 [cron <defunct>]

Looking at ppid we find the parent process /usr/sbin/cron which is in S state.

Seems to be harmless though, as the zombies just disappear after a little 
while so I never bothered reporting to anyone.

Just my 2p.

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

