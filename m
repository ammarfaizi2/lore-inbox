Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277562AbRJET1s>; Fri, 5 Oct 2001 15:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277561AbRJET1k>; Fri, 5 Oct 2001 15:27:40 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:13561 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S277562AbRJET1O>; Fri, 5 Oct 2001 15:27:14 -0400
Date: Fri, 5 Oct 2001 14:27:43 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200110051927.OAA36321@tomcat.admin.navo.hpc.mil>
To: tyler@captainjack.com, "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x, smp, eepro100
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Hello everyone,
> 
> I've been having major troubles with a machine here.  Here's my setup:
> 
> OS: Slackware 8.0
> Kernel: 2.4.5_nosmp, 2.4.5, and 2.4.10
> NIC: eepro100
> 
> Anyway, installed Slackware with the default scsi kernel.  Everything worked
> fine.  I re-compiled 2.4.5 to enable smp support.  After re-compiling
> everything is stable until a few hundred megs gets uploaded to the box.
> After a few hundred megs get upped to the box (through ftp), eth0 just dies.
> The same thing happened in 2.4.9 and now also happens in 2.4.10.  There's
> some odd messages coming from dmesg:
> eth0:        8   0000a022.
> eth0:        9   0000a020.
> eth0:        10 0000a020.
> eth0:        11 0000a020.
> eth0:        12 0000a022.
> eth0:        13 0000a022.
> eth0:        14 0000a020.
> eth0:        15 0000a020.
> eth0:        16 0000a020.
> eth0:        17 00000001.
> eth0:        18 00000001.
> 
> I have no idea why this is happening.  My ethernet card uses the eepro100
> module.  When I re-compile the kernel, I use the default config file for
> slackware (so it should be like the default Slackware scsi kernel).  The
> only thing I do is add SMP support.
> 
> Any ideas anyone?

Is the eepro a loadable module? I'll almost bet that it is.

You are most likely using the UP version of the module.

This can happen because the kernel parameters modified will build everything
properly, BUT, you have to remember that the default name in the build
is UP rather than SMP.

What I do is:

1. change the EXTRAVERSION in the makefile to "-SMP"
2. build/install the kernel (don't boot yet)
3. build/install modules.

When the EXTRAVERSION different than the default, a new module directory
gets created (/lib/modules/2.2.19-SMP) to hold the new modules.

This also allows me to boot uniprocessor if something happens. Otherwise
you suddenly have a mix of some uniprocessor modules and SMP modules. If
the kernel is 2.2.19 (like mine), you will get network failures in SMP.
If you build the network modules, you now get network failures in UP.

If I'm going to be working in both, then I'll first copy the UP distribution
(cp -rp 2.2.19 2.2.19-SMP), and then change the Makefile in the SMP tree.

Keeps things separate, and works.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
