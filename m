Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUEKSIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUEKSIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 14:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUEKSIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 14:08:38 -0400
Received: from dsl-64-30-195-78.lcinet.net ([64.30.195.78]:41645 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S262960AbUEKSIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 14:08:13 -0400
Message-ID: <033501c43782$d9dc8300$d100a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Kernel" <linux-kernel@vger.kernel.org>
Subject: Building Kernel with IDE as Modules
Date: Tue, 11 May 2004 11:07:40 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, I know it shouldn't be done! But the reason I'm doing this is
because I maintain the mkinitrd script for the LFS system. This happens with
all 2.6.x up to 2.6.6. Comments and suggestions are welcome.

I noticed the following issues:

On the help for <M> ATA/ATAPI/MFM/RLL support it says the modules name is
ide, I think it no longer exists.

On the help for <M>   Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support is
ide-mod, I 'm assume the correct name is ide-core

My script worked perfect under 2.4.x, but trying to upgrade it to 2.6.x has
been a challenge in the IDE section

So in theory I should be able to my script load ide-core, ide-disk, then
ide-generic (or the specific chipset driver). When I do I start seeing some
interesting problems. Everything boots up find until another module is
loaded, in my case the tulip driver. I get the following dump

May 10 23:04:13 linux Unable to handle kernel paging request at virtual
address e3920e98

May 10 23:04:13 linux printing eip:

May 10 23:04:13 linux c01a2d27

May 10 23:04:13 linux *pde = 015bc067

May 10 23:04:13 linux *pte = 00000000

May 10 23:04:13 linux Oops: 0002 [#1]

May 10 23:04:13 linux PREEMPT

May 10 23:04:13 linux CPU:    0

May 10 23:04:13 linux EIP:    0060:[<c01a2d27>]    Not tainted

May 10 23:04:13 linux EFLAGS: 00010292   (2.6.6-lfs-3)

May 10 23:04:13 linux EIP is at kobject_add+0x77/0x110

May 10 23:04:13 linux eax: c02b2ee0   ebx: e38eaffc   ecx: e3920e98   edx:
e38eb018

May 10 23:04:13 linux esi: ffffffea   edi: c02b2ee8   ebp: e38eafe4   esp:
decf3f1c

May 10 23:04:13 linux ds: 007b   es: 007b   ss: 0068

May 10 23:04:13 linux Process modprobe (pid: 499, threadinfo=decf2000
task=df782090)

May 10 23:04:13 linux Stack: c02b2ee8 e38eaffc e38eaffc ffffffea 00000000
c01a2de8 e38eaffc e38eaffc

May 10 23:04:13 linux c02b2e80 e38eaffc c02b2e80 c01d333a e38eaffc e38e6eda
e38eafc0 00000000

May 10 23:04:13 linux e38eb058 c0283f9c c01d37bf e38eafe4 00000400 e38e6f71
decf3f9c e38ddf74

May 10 23:04:13 linux Call Trace:

May 10 23:04:13 linux [<c01a2de8>] kobject_register+0x28/0x70

May 10 23:04:13 linux [<c01d333a>] bus_add_driver+0x4a/0xc0

May 10 23:04:13 linux [<c01d37bf>] driver_register+0x2f/0x40

May 10 23:04:13 linux [<c01aa8ec>] pci_register_driver+0x5c/0x90

May 10 23:04:13 linux [<e3844038>] tulip_init+0x38/0x46 [tulip]

May 10 23:04:13 linux [<c012cd3f>] sys_init_module+0x11f/0x250

May 10 23:04:13 linux [<c0105ab9>] sysenter_past_esp+0x52/0x71

May 10 23:04:13 linux

May 10 23:04:13 linux Code: 89 11 89 4a 04 8b 43 28 8b 30 8d 4e 48 89 c8 ba
ff ff 00 00





----
Jim Gifford
maillist@jg555.com

