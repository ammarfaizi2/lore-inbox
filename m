Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbTAGRQP>; Tue, 7 Jan 2003 12:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbTAGRQP>; Tue, 7 Jan 2003 12:16:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10909 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267466AbTAGRQL>;
	Tue, 7 Jan 2003 12:16:11 -0500
Date: Tue, 7 Jan 2003 09:21:29 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Michal Sojka <sojka@planetarium.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Insmod failed
In-Reply-To: <3E1B0985.6050100@planetarium.cz>
Message-ID: <Pine.LNX.4.33L2.0301070919010.2498-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| Hi,

On Tue, 7 Jan 2003, Michal Sojka wrote:

| I'am porting driver for my USB 2.0 device to 2.5 and when I try insmod
| my module I get the following:
|
| Error inserting '/lib/modules/2.5.54/misc/usb-emise.o': -1 Invalid
| module format

>From lkml archives:
Add a -DKBUILD_MODNAME="yourname" compile option to one of the files,
the new loader requires a module name section. It should be only set
once for each module.

In addition make sure you're using the new style module_init/module_exit
macros instead of init_module/cleanup_module.

| I compile my module separate of kernel tree with Makefile similar to
| that in Linux Device Drivers book (Rubini, Corbet). What is the right
| way to compile standalone modules?

>From lkml archives:
Try to folllow this reciept [recipe] posted by Kai G.
-------------
Well, you can do

cd my_module
echo "obj-m := my_module.o" > Makefile
vi my_module.c
make -C <path/to/kernel/src> SUBDIRS=$PWD modules

That's not too bad (and basically works for 2.4 as well)
---------------

| module-init-tools version 0.9.7, kenrel 2.5.52,54
|
| objdump -h /lib/modules/2.5.54/misc/usb-emise.o
|
| /lib/modules/2.5.54/misc/usb-emise.o:     file format elf32-i386
|
| Sections:
| Idx Name          Size      VMA       LMA       File off  Algn
|    0 .text         00001b94  00000000  00000000  00000034  2**2
|                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|    1 .data         000001c0  00000000  00000000  00001be0  2**5
|                    CONTENTS, ALLOC, LOAD, RELOC, DATA
|    2 .bss          00000000  00000000  00000000  00001da0  2**2
|                    ALLOC
|    3 .note         00000014  00000000  00000000  00001da0  2**0
|                    CONTENTS, READONLY
|    4 .stab         00007bd8  00000000  00000000  00001db4  2**2
|                    CONTENTS, RELOC, READONLY, DEBUGGING
|    5 .stabstr      0001893f  00000000  00000000  0000998c  2**0
|                    CONTENTS, READONLY, DEBUGGING
|    6 .rodata.str1.32 00000aa0  00000000  00000000  000222e0  2**5
|                    CONTENTS, ALLOC, LOAD, READONLY, DATA
|    7 .rodata.str1.1 00000129  00000000  00000000  00022d80  2**0
|                    CONTENTS, ALLOC, LOAD, READONLY, DATA
|    8 __obsparm     00000080  00000000  00000000  00022ec0  2**5
|                    CONTENTS, ALLOC, LOAD, DATA
|    9 .rodata       00000004  00000000  00000000  00022f40  2**2
|                    CONTENTS, ALLOC, LOAD, READONLY, DATA
|   10 .init.text    000000c8  00000000  00000000  00022f44  2**2
|                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|   11 .exit.text    00000098  00000000  00000000  0002300c  2**2
|                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|   12 .comment      00000037  00000000  00000000  000230a4  2**0
|                    CONTENTS, READONLY

See a pattern here?  :)
-- 
~Randy

