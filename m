Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUENSrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUENSrD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUENSrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:47:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:21221 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262062AbUENSq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:46:56 -0400
Date: Fri, 14 May 2004 11:38:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Henrik.Seidel@gmx.de
Subject: sysfs warning + spinlock BUG in typhoon radio
Message-Id: <20040514113804.1964105f.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.6:


Calling initcall 0xc10bc558: typhoon_init+0x0/0x12a()
Typhoon Radio Card driver v0.1
CLASS: registering class device: ID = 'radio2'
class_hotplug - name = radio2
videodev: "Typhoon Radio" has no release callback. Please fix your driver for proper sysfs support, see http://lwn.net/Articles/36850/
radio-typhoon: port 0x316.
radio-typhoon: mute frequency is 87500 kHz.
eip: c0b946cc
------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:120!
invalid operand: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c0b94894>]    Not tainted
EFLAGS: 00010096   (2.6.6) 
EIP is at __down+0x1c8/0x1d6
eax: 0000000e   ebx: 00000000   ecx: c0d8c658   edx: 00000001
esi: c0e09258   edi: 00000296   ebp: c25aff5c   esp: c25aff14
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c25ae000 task=f7f9da60)
Stack: c0bf2aa9 c0b946cc c0e09260 f7f9da60 c0124522 00012cf9 00012cf9 00000000 
       f7f9da60 c011ee6a 00000000 00000000 00012cf9 c25aff74 c0124ac4 00000000 
       c0e09258 c0e09240 c25aff70 c0b94ab7 c0e09258 00000001 00000000 c25aff8c 
Call Trace:
 [<c0b946cc>] __down+0x0/0x1d6
 [<c0124522>] call_console_drivers+0x72/0x138
 [<c011ee6a>] default_wake_function+0x0/0x10
 [<c0124ac4>] release_console_sem+0x152/0x18a
 [<c0b94ab7>] __down_failed+0xb/0x14
 [<c05b7434>] .text.lock.radio_typhoon+0x5/0x29
 [<c05b70b0>] typhoon_mute+0x22/0x40
 [<c10bc61f>] typhoon_init+0xc7/0x12a
 [<c10908e2>] do_initcalls+0x2a/0xb8
 [<c10bc558>] typhoon_init+0x0/0x12a
 [<c0100394>] init+0x60/0x1c8
 [<c0100334>] init+0x0/0x1c8
 [<c01042b1>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 78 00 42 be be c0 e9 82 fe ff ff 90 55 b8 00 e0 ff ff 
 <0>Kernel panic: Attempted to kill init!


--
~Randy
