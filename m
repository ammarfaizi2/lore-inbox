Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264088AbRFETgQ>; Tue, 5 Jun 2001 15:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264089AbRFETgH>; Tue, 5 Jun 2001 15:36:07 -0400
Received: from line93.ba.psg.sk ([195.80.179.93]:28288 "HELO ivan.doma")
	by vger.kernel.org with SMTP id <S264088AbRFETf6>;
	Tue, 5 Jun 2001 15:35:58 -0400
Date: Tue, 5 Jun 2001 21:36:09 +0200
From: Ivan Vadovic <pivo@pobox.sk>
To: "W. Michael Petullo" <mike@flyn.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PID of init != 1 when initrd with pivot_root
Message-ID: <20010605213608.A14147@ivan.doma>
In-Reply-To: <20010601040627.A1335@ivan.doma> <20010602220219.A1091@ivan.doma> <20010605175618.A2884@dragon.flyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010605175618.A2884@dragon.flyn.org>; from mike@flyn.org on Tue, Jun 05, 2001 at 05:56:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > But the problem still remains. How do I make my /sbin/init run with PID 1 
> > using initial ramdisk under the new root change mechanism? I don't want to 
> > use the old change_root mechanism...
> 
> I had the same problem when doing some development for mkCDrec.
> This project uses busybox, whose init does not run if its PID != 1.
> I asked the busybox folks same question you did and never got a response.
> 
> As a kludge, and after looking at the busybox source code, I renamed init
> to linuxrc.  In this case the program is functionally equivalent to init,
> except that it does not do the PID == 1 check.
> 
> An excerpt from my real linuxrc:
> 
> echo Pivot_root: my PID is $$
> # exec /usr/sbin/chroot . /sbin/init < dev/console > dev/console 2>&1
> # Okay, try this:
> exec /usr/sbin/chroot . /sbin/linuxrc < /dev/console > /dev/console 2>&1
> 
> /sbin/linuxrc is actually init, renamed.
> 

I fugured it out. The Documentation/initrd.txt says to use root=/dev/rd/0 with
devfs. Well, that's wrong. You should use root=/dev/ram0 even with devfs no
matter what the documentation says. And my linuxrc finaly runs with PID == 1.

Ivan Vadovic
