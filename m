Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293238AbSCJVKq>; Sun, 10 Mar 2002 16:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293243AbSCJVKh>; Sun, 10 Mar 2002 16:10:37 -0500
Received: from cpe.atm0-0-0-209183.0x3ef29767.boanxx7.customer.tele.dk ([62.242.151.103]:18126
	"HELO mail.hswn.dk") by vger.kernel.org with SMTP
	id <S293238AbSCJVK1>; Sun, 10 Mar 2002 16:10:27 -0500
Date: Sun, 10 Mar 2002 22:10:24 +0100
From: =?iso-8859-1?Q?Henrik_St=F8rner?= <henrik@hswn.dk>
To: linux-kernel@vger.kernel.org
Subject: initrd problem, and a small 2.5.6 ALSA sound no-compile
Message-ID: <20020310221024.A1647@hswn.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first attempt at booting a 2.5.x kernel.

First, sound/core/rtctimer.c doesn't compile because there is no
"err" variable defined in the rtctimer_open() routine. Adding a
simple "int err;" fixes that. The OSS drivers also do not compile;
something about "bus_to_virt" being obsolete in several files.

Is initrd broken in 2.5.x ? It seems so here, at least. I use LVM
on my root-fs, so I need the LVM initrd for the vgscan/vgchange
commands (no modules - I have it all compiled in) and this works
fine in 2.4.18.

With 2.5.6, the behaviour is different.

* If I use my normal "root=<LVM device>" in lilo, it panics claiming
  it cannot mount the root fs
* If I use "root=/dev/ram0" in lilo, the ramdisk is loaded and the
  commands in /linuxrc are executed, but then the system just 
  drops to a shell - it seems it does not do the normal swicth to
  the real root-fs and execs init from there.

So, back to 2.4.18 for now ... 
-- 
Henrik Storner <henrik@hswn.dk> 

