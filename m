Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286358AbSAEXPs>; Sat, 5 Jan 2002 18:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286365AbSAEXP3>; Sat, 5 Jan 2002 18:15:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59654 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286358AbSAEXPS>; Sat, 5 Jan 2002 18:15:18 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Non-Linux users of the Linux/i386 boot protocol
Date: 5 Jan 2002 15:15:13 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a181e1$tk2$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The message is directed to authors of applications of the Linux/i386
boot protocol other than the Linux kernel proper, such as memtest86.
If you don't fall in that category, you probably don't need to worry
too much about this...

I would like to make a "retroactive change" to the Linux/i386 boot
protocol.  As far as I can determine, this change is valid for all
preexisting Linux/i386 and Linux/x86-64 kernels, however, I am not
sure about other users of the boot protocol (other than ones authored
by me, of course.)

In particular, the proposed change is the following:

if the boot protocol version is 2.00 (0x0200) or higher, the header
byte at offset 0x201 indicates the length of the header starting from
byte 0x202.  In other words, if this byte is 0x2e, the first byte
beyond the header is 0x230.  Since bytes 0x200 and 0x201 *always*
contains a 2-byte jump, the only uncertainty about this is the
following:

DO THERE EXIST ANY SOFTWARE OUT THERE WHICH JUMP TO ANYTHING BUT THE
FIRST BYTE IMMEDIATELY FOLLOWING THE HEADER?

If no such software exist, the value in this byte can be used by the
bootloader to determine the length of the valid header.  Although this
information is somewhat redundant with the boot protocol version
number, it may help simplify the boot loaders by making this
particular piece of information available in an already decoded form.

For example, the boot loader can have a pre-constructed buffer with
default values, and simply copy the valid parts of the header from the
kernel image buffer, leaving any not-present values at their defaults.
This, of course, doesn't solve *all* possible boot protocol version
dependencies (such as the presence of input fields, e.g. cmd_line_ptr
added in 2.02) but, of the currently existing version-dependent
fields, at least the presence or nonprecense of the heap_end_ptr and
initrd_addr_max fields could be handled via this mechanism.

For boot protocol < 2.00 (HdrS not present, or version < 0x0200) I
fully expect that this invariant will not hold true, of course.

	-hpa



-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
