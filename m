Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTFALBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 07:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTFALBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 07:01:25 -0400
Received: from node-c-38a9.a2000.nl ([62.194.56.169]:20352 "EHLO
	wsprwl.xs4all.nl") by vger.kernel.org with ESMTP id S263183AbTFALBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 07:01:23 -0400
Message-ID: <3ED9E025.1060801@xs4all.nl>
Date: Sun, 01 Jun 2003 13:14:45 +0200
From: Ruud Linders <rkmp@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial port numbering (ttyS..) wrong for 2.5.61+
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since I tried the 2.5 kernel versions somewhere in the 2.5.6x range, I
see rather odd port naming for the extra 4 serial ports on a PCI-card.

The first two are numered as ttyS14, ttyS15 while the last two are
ttyS2 and ttyS3 !
I tried to find where these numbers are coming from but couldn't really
find an obvious place in the various drivers/char/* or drivers/serial/*
files.

Note that the ttyS14 port actually works so this seems only a bug in
the numbering.

Regards,
Ruud Linders


Kernel version 2.5.70
---------------------
dmesg:
======
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS14 at I/O 0xbc00 (irq = 21) is a 16550A     <<<<<<  14 ????
ttyS15 at I/O 0xbc08 (irq = 21) is a 16550A     <<<<<<
ttyS2 at I/O 0xbc10 (irq = 21) is a 16550A
ttyS3 at I/O 0xbc18 (irq = 21) is a 16550A

4-port PCI serial controller:
=============================
# lspci -d 10b5:1077 -v
02:0b.0 Serial controller: PLX Technology, Inc. VScom 400 4 port serial 
adaptor
(rev 02) (prog-if 00 [8250])
         Subsystem: PLX Technology, Inc. VScom 400 4 port serial adaptor
         Flags: medium devsel, IRQ 21
         Memory at de004000 (32-bit, non-prefetchable) [size=128]
         I/O ports at b800 [size=128]
         I/O ports at bc00 [size=32]
         I/O ports at c000 [size=8]
         Expansion ROM at <unassigned> [disabled] [size=2K]



