Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268962AbTGJMQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbTGJMQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:16:42 -0400
Received: from users.linvision.com ([62.58.92.114]:18349 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S268962AbTGJMQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:16:35 -0400
Date: Thu, 10 Jul 2003 14:31:12 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Changes to mem.c ... 
Message-ID: <20030710143112.A16714@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I haven't been paying much attention, but someone changed the 
mmap_kmem function in drivers/char/mem.c (it used to be equivalent
to mmap_mem). 

I used to be able to use the "chipmunk" tool (www.bitwizard.nl/chipmunk)
to examine and control memory mapped devices

cave chipmunk/chipmunk-1.5# lspci -vs 00:0f.0
00:0f.0 Communication controller: Specialix Research Ltd. PCI_9050 (rev 01)
        Subsystem: Unknown device 11cb:0100
        Flags: medium devsel, IRQ 16
        Memory at da011000 (32-bit, non-prefetchable)
        I/O ports at c800
        Memory at da000000 (32-bit, non-prefetchable)

cave chipmunk/chipmunk-1.5# setenv HW_BASE 0xda000000
cave chipmunk/chipmunk-1.5# chipmunk
Autoloading init.mac.
This is Chipmunk version 1.4.1 .
This is THE init file.... running on linux
making a 1Mb aperture at 0xda000000

>  dump 0
40196000  00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00    ................
40196010  00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00    ................
40196020  00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00    ................
40196030  00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00    ................
40196040  00 00 b2 03 e2 28 00 10   2e 0d 0a 72 74 69 6e 67    .....(.....rting
40196050  20 73 79 73 74 65 6d 20   6c 6f 67 20 64 61 65 6d    .system.log.daem
40196060  6f 6e 3a 20 73 79 73 6c   6f 67 64 0a 2e 32 37 20    on:.syslogd..27.
> bye bye.
cave chipmunk/chipmunk-1.5# 


but on 2.4.21: No such luck.... It seems there is a new codepath for 
mmapping "kmem", which interferes with chipmunk mmapping the memory 
mapped IO space of the card. 

Why was this added? How does X still work?

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* I didn't say it was your fault. I said I was going to blame it on you. *
