Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUBECJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 21:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUBECJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 21:09:35 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:24229 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263424AbUBECIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 21:08:30 -0500
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: Reserved page flaging of 2.4 kernel memory changed recently?
Date: Thu, 5 Feb 2004 10:07:35 +0800
User-Agent: KMail/1.5.4
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402050941.34155.mhf@linuxmail.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The question is related to saving the kernel with swsusp.

Looking at 2.4.24 x86 kernel page flags, kernel memory is flaged reserved 
the same way as video, BIOS pages.

Is this a recent change since using the aa vm and should it be like that?

If so, should hardware related reserved pages i.e video, BIOS be flaged
PG_nosave upon init?

What about iomemory?

Michael

Note: (Flags & 0x4000) == PG_reserved

# crash vmlinux
crash 3.7-5.2
Copyright (C) 2002, 2003  Red Hat, Inc.
Copyright (C) 1998-2003  Hewlett-Packard Co
Copyright (C) 1999, 2002  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.

GNU gdb Red Hat Linux (5.3post-0.20021129.36rh)
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i686-pc-linux-gnu"...

6c 14
WARNING: net_init: unknown device type for net device      KERNEL: vmlinux
    DUMPFILE: /dev/mem
        CPUS: 1
        DATE: Thu Feb  5 09:36:36 2004
      UPTIME: 00:57:01
LOAD AVERAGE: 0.08, 0.02, 0.01
       TASKS: 76
    NODENAME: mhfl4
     RELEASE: 2.4.24-mhf169
     VERSION: #2 Sat Jan 31 16:03:07 HKT 2004
     MACHINE: i686  (2399 Mhz)
      MEMORY: 496 MB
         PID: 1872
     COMMAND: "crash"
        TASK: cec66000
         CPU: 0
       STATE: TASK_RUNNING (ACTIVE)

crash> kmem -p
  PAGE    PHYSICAL   MAPPING    INDEX CNT FLAGS
c100001c         0         0         0  0 4000
c1000048      1000         0         0  0 4000
c1000074      2000         0         0  0 4000
c10000a0      3000         0         0  0 4000
c10000cc      4000         0         0  0 0
c10000f8      5000         0         0  0 0
c1000124      6000         0         0  0 0
c1000150      7000         0         0  0 0
c100017c      8000         0         0  0 0
c10001a8      9000         0         0  0 0
c10001d4      a000         0         0  0 0
c1000200      b000         0         0  0 0
[]
c1001b70     9f000         0         0  0 4000
c1001b9c     a0000         0         0  0 4000
c1001bc8     a1000         0         0  0 4000
c1001bf4     a2000         0         0  0 4000
c1001c20     a3000         0         0  0 4000
c1001c4c     a4000         0         0  0 4000
c1001c78     a5000         0         0  0 4000
c1001ca4     a6000         0         0  0 4000
c1001cd0     a7000         0         0  0 4000
c1001cfc     a8000         0         0  0 4000
c1001d28     a9000         0         0  0 4000
c1001d54     aa000         0         0  0 4000
c1001d80     ab000         0         0  0 4000
c1001dac     ac000         0         0  0 4000
c1001dd8     ad000         0         0  0 4000
c1001e04     ae000         0         0  0 4000
[]
c1002b98     fd000         0         0  0 4000
c1002bc4     fe000         0         0  0 4000
c1002bf0     ff000         0         0  0 4000
c1002c1c    100000         0         0  0 4000
c1002c48    101000         0         0  0 4000
c1002c74    102000         0         0  0 4000
c1002ca0    103000         0         0  0 4000
c1002ccc    104000         0         0 1425 4000
c1002cf8    105000         0         0  0 4000
c1002d24    106000         0         0  0 4000
c1002d50    107000         0         0  0 4000
c1002d7c    108000         0         0  0 4000
c1002da8    109000         0         0  0 4000
[]
c100b2b0    40f000         0         0  0 4000
c100b2dc    410000         0         0  0 4000
c100b308    411000         0         0  0 4000
c100b334    412000         0         0  0 0
c100b360    413000         0         0  0 0
c100b38c    414000         0         0  0 0
c100b3b8    415000         0         0  0 0
c100b3e4    416000         0         0  0 0
c100b410    417000         0         0  0 0
c100b43c    418000         0         0  0 0
c100b468    419000         0         0  0 0
c100b494    41a000         0         0  0 0
c100b4c0    41b000         0         0  0 0
c100b4ec    41c000         0         0  0 0
c100b518    41d000         0         0  0 0
c100b544    41e000         0         0  0 0
c100b570    41f000         0         0  0 0
c100b59c    420000         0         0  0 0
c100b5c8    421000         0         0  0 0
c100b5f4    422000         0         0  0 0
c100b620    423000         0         0  0 0
c100b64c    424000         0         0  0 0
c100b678    425000         0         0  0 0
c100b6a4    426000         0         0  0 0
c100b6d0    427000         0         0  0 0
c100b6fc    428000         0         0  0 0
c100b728    429000         0         0  0 0
c100b754    42a000         0         0  0 0
c100b780    42b000         0         0  0 0
c100b7ac    42c000         0         0  0 0
c100b7d8    42d000         0         0  0 0
c100b804    42e000         0         0  0 0
c100b830    42f000         0         0  0 0
c100b85c    430000         0         0  0 4000
c100b888    431000         0         0  0 4000
c100b8b4    432000         0         0  0 4000
c100b8e0    433000         0         0  0 4000
c100b90c    434000         0         0  0 4000
c100b938    435000         0         0  0 4000
c100b964    436000         0         0  0 4000
c100b990    437000         0         0  0 4000
c100b9bc    438000         0         0  0 4000
c100b9e8    439000         0         0  0 4000
c100ba14    43a000         0         0  0 4000
[]
c100c6a0    483000         0         0  0 4000
c100c6cc    484000         0         0  0 4000
c100c6f8    485000         0         0  0 4000
c100c724    486000         0         0  0 4000
c100c750    487000         0         0  0 4000
c100c77c    488000         0         0  0 4000
c100c7a8    489000         0         0  0 0
c100c7d4    48a000         0         0  0 0
c100c800    48b000         0         0  0 0
c100c82c    48c000         0         0  0 0
c100c858    48d000         0         0  0 4000
c100c884    48e000         0         0  0 0
c100c8b0    48f000         0         0  0 0
c100c8dc    490000         0         0  0 0
c100c908    491000         0         0  0 0
c100c934    492000         0         0  0 0
c100c960    493000         0         0  0 0
c100c98c    494000         0         0  0 0
c100c9b8    495000         0         0  0 0
c100c9e4    496000         0         0  0 0
c100ca10    497000         0         0  0 0
c100ca3c    498000         0         0  0 0
c100ca68    499000         0         0  0 0
c100ca94    49a000         0         0  0 0
c100cac0    49b000         0         0  0 0




