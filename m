Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbRBXTSk>; Sat, 24 Feb 2001 14:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129569AbRBXTSa>; Sat, 24 Feb 2001 14:18:30 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:38553 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129568AbRBXTSL>;
	Sat, 24 Feb 2001 14:18:11 -0500
Message-Id: <m14WkCm-000Ob6C@amadeus.home.nl>
Date: Sat, 24 Feb 2001 20:18:08 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: swansma@yahoo.com (Mark Swanson)
Subject: Re: 242-ac3 loop bug
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <20010224173234.14673.qmail@web1301.mail.yahoo.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010224173234.14673.qmail@web1301.mail.yahoo.com> you wrote:
> First, good job on the loop device. It's rock stable for me - except
> when I try to load the blowfish module which oops the kernel and
> crashes the loop device:-) No problem, I just use another cipher.

> The bug I'm reporting is that when a loop device is in use the load of
> the machine stays at 1.00 even though nothing is happening. If I umount
> the loop filesystem the load goes down to 0.00.

>> ps -aux | grep loop
> 1674 tty1     DW<   0:00 [loop0]

This is probably easy to fix in the driver, right now it waits for
events in UNINTERRUPTIBLE state, while it should wait in INTERRUPTIBLE
state. The fix isn't as trivial as removing 2 letters though, I'll send Alan
a real patch on monday.

Greetings,
   Arjan van de Ven
