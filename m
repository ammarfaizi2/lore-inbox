Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbTI1PD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbTI1PD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 11:03:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40718 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262708AbTI1PDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 11:03:18 -0400
Date: Sun, 28 Sep 2003 16:03:14 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: CONFIG_I8042
Message-ID: <20030928160314.A1428@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Vojtech Pavlik <vojtech@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can we turn this option off on non-x86 and without selecting
CONFIG_EMBEDDED?  It seems that as the configuration files stand,
it is impossible to deselect this option:

config SERIO_I8042
        tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
        default y
        select SERIO

It seems that in menuconfig, it isn't possible to change this option
either:

  x x            --- Serial i/o support                                    x x
  x x            --- i8042 PC Keyboard controller                          x x
  x x            <M> Serial port line discipline                           x x

Maybe "!X86" doesn't mean "not X86 architectures" when it isn't
defined?

This means that all architectures which do not support 8042 get
8042 support forced in them.  In my case, this is the result:

Unable to handle kernel NULL pointer dereference at virtual address 00000064
pgd = c0204000
[00000064] *pgd=00000000
Internal error: Oops: c0207005 [#1]
CPU: 0
PC is at i8042_flush+0x20/0x58
LR is at i8042_controller_init+0x14/0x168
pc : [<c0330fc8>]    lr : [<c02159cc>]    Not tainted
sp : c01e1f84  ip : 00000064  fp : c01e1f90
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : c021bee4  r6 : 00000000  r5 : c021bec0  r4 : c01e0000
r3 : a0000093  r2 : 0000000c  r1 : a0000013  r0 : 00000000
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C020717F  Table: C020717F  DAC: 0000001D
Process swapper (pid: 1, stack limit = 0xc01e00ec)
Stack: (0xc01e1f84 to 0xc01e2000)
1f80:          c01e1fa8 c01e1f94 c02159cc c0330fb4 00000000 c01e0000 c01e1fc4 
1fa0: c01e1fac c021606c c02159c4 c01e0000 c021bec0 00000000 c01e1fe4 c01e1fc8 
1fc0: c0208774 c0216024 00000000 00000000 00000000 00000000 c01e1ff4 c01e1fe8 
1fe0: c021c0a0 c0208738 00000000 c01e1ff8 c023ae48 c021c084 5a5a5a5a 5a5a5a5a 
Backtrace: 
[<c0330fa8>] (i8042_flush+0x0/0x58) from [<c02159cc>] (i8042_controller_init+0x14/0x168)
[<c02159b8>] (i8042_controller_init+0x0/0x168) from [<c021606c>] (i8042_init+0x54/0x1ac)
[<c0216018>] (i8042_init+0x0/0x1ac) from [<c0208774>] (do_initcalls+0x48/0xb8)
[<c020872c>] (do_initcalls+0x0/0xb8) from [<c021c0a0>] (init+0x28/0xc8)
[<c021c078>] (init+0x0/0xc8) from [<c023ae48>] (do_exit+0x0/0x398)
Code: e10f1000 e3813080 e121f003 e3a0c064 (e5dc3000) 
0>Kernel panic: Attempted to kill init!

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
