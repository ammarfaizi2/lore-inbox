Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWAUVJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWAUVJH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWAUVJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:09:07 -0500
Received: from xenotime.net ([66.160.160.81]:40382 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932348AbWAUVJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:09:06 -0500
Date: Sat, 21 Jan 2006 13:09:10 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Shaun Savage <savages@tvlinux.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: CBD Compressed Block Device, New embedded block device
Message-Id: <20060121130910.5877388c.rdunlap@xenotime.net>
In-Reply-To: <43D3467C.7010803@tvlinux.org>
References: <43D3467C.7010803@tvlinux.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2006 00:46:52 -0800 Shaun Savage wrote:

> HI
> 
> Here is a patch for 2.6.14.5 of CBD
> CBD is a compressed block device that is designed to shrink the file 
> system size to 1/3 the original size.  CBD is a block device on a file 
> system so, it also allows for in-field upgrade of file system.  If 
> necessary is also allows for secure booting, with a GRUB patch.
> 
> Reply to email please.

No need to send an entire .config file with it.

In Kconfig help, use "compressed".

I need more help on the BLK_CBD_DEVICE option.
What does it do?

Please fix the indentation after
+#ifndef CBD_PARTITION
in cbd_int.c

Try to limit lines to < 80 characters each.

Use spaces around operators (=, <, >, <=, >=, etc).

Use space after "if", "for", and "while".

Has some funky indenting (use tabs instead of spaces).

Don't use typedefs.
Don't use typedef struct S { ... } S_t;

struct partition_info &
struct cbd_part_hdr seem to expect that ushort, uint,
etc., have fixed sizes, but they can actually vary by
architecture, so you should use known fixed sizes
anywhere that field & struct sizes matter.

Use ALIGN() from kernel.h instead of your own align() macro.

Lots of trailing whitespace.  Don't do that:
Warning: trailing whitespace in lines 41,58,102,104,106,137,198,234 of include/linux/cbd.h
Warning: trailing whitespace in lines 348,355 of drivers/block/Kconfig
Warning: trailing whitespace in lines 32,72,138,158 of drivers/block/cbd_int.c
Warning: trailing whitespace in lines 7,50,95,162,240,318,428,516,613,657,658,669,704,747,797,808,813,817,827,872 of drivers/block/cbd_main.c

Has about 25 gcc warnings when I build it.

---
~Randy
