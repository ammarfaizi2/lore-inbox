Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265609AbUBPOEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbUBPNyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:54:24 -0500
Received: from pr-117-210.ains.net.au ([202.147.117.210]:7364 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S265607AbUBPNvt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:51:49 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Cross Compiling 
In-reply-to: Your message of "Sun, 15 Feb 2004 18:38:36 BST."
             <20040215173835.GA22567@MAIL.13thfloor.at> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Feb 2004 00:51:27 +1100
Message-ID: <5233.1076939487@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004 18:38:36 +0100, 
Herbert Poetzl <herbert@13thfloor.at> wrote:
>On Sun, Feb 15, 2004 at 12:16:10PM +0100, Geert Uytterhoeven wrote:
>> One related question: anyone who knows how to run a cross-depmod, 
>> so I can find missing symbol exports without running depmod 
>> on the target?
>
>../modutils-2.4.26/configure --target=m68k-linux
>
>seems to do something, so it might even work ...
>
>depmod: ELF file /lib/.../kernel/crypto/aes.o not for this architecture
>depmod: ELF file /lib/.../kernel/crypto/blowfish.o not for this architecture

modutils <= 2.4 was never designed to run in cross compile mode.  The
modules.dep file created at compile time is a courtesy file, in an
attempt to avoid warning messages (no modules.dep) on the very first
boot of a new kernel version.  Once the kernel has been booted, it ahs
its own modules.dep.

Making it run on the target system but handle cross compiled modules
pulls in all the problems associated with build and target having
different word sizes, different endianess and different object
information.  modutils 2.4 is now in stable mode, it is only taking bug
fixes.  A complete rewrite to handle cross compile is not a bug fix.

Bottom line: when building cross compile use make ... DEPMOD=/bin/true
to avoid using the local depmod.

