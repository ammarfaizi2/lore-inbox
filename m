Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSDRQ7l>; Thu, 18 Apr 2002 12:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314398AbSDRQ7k>; Thu, 18 Apr 2002 12:59:40 -0400
Received: from web11801.mail.yahoo.com ([216.136.172.155]:4387 "HELO
	web11801.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292130AbSDRQ7j>; Thu, 18 Apr 2002 12:59:39 -0400
Message-ID: <20020418165939.22502.qmail@web11801.mail.yahoo.com>
Date: Thu, 18 Apr 2002 18:59:39 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: [PATCH] x86 boot enhancements, Clean up the 32bit entry points 6/11
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Seems that previous message did not go through, rewrite.

 I am sorry I did not check enough your patch.
 You are speaking of: arch/i386/boot/compressed/head.S
 I am speaking of:    arch/i386/kernel/head.S

 Gujin skip completely arch/i386/boot/compressed/* and really
 boots the file '$$tmppiggy.gz' line 44 of file:
arch/i386/boot/compressed/Makefile

 So you can do whatever you want with the "first" 32 bits entry point,
 I am just concerned by the "second" kernel 32 bits entry point, in
 arch/i386/kernel/head.S

 I still have a problem to detect the size of your decompressor, and that
 is my use of the "lss" instruction.
 This "lss SYMBOL_NAME(stack_start),%esp" gives an access to the symbol
 'stack_start', so it is quite easy to find back the GZIP signature
 of the initial '$$tmppiggy.gz' in what I call my "compatibility" mode,
 i.e. booting the legacy vmlinuz files - and skipping all of the real mode
 code and the decompressor code.

 This "lss" line has not always been at the same offset, but is around
 since maybe even the 0.01 kernel, it is quite easy to find it from its
 hexadecimal form. (function vmlinuz_header_treat() in vmlinuz.c of
 Gujin).

 The loaded high/loaded low stuff is just to know if I have to remove
 0x100000 or 0x1000 from this symbol to have the number of bytes
 to skip on the file.
 By the way, the bit in the kernel header is set by the bootloader to say
 where it has loaded the kernel, not by the compiler/linker chain.

 So is it possible to write somewhere how much code to skip or the offset
 of the kernel GZIP signature?
 Something like:
  jmp next
  lss SYMBOL_NAME(stack_start),%esp
next:
 Would make me really happy, but is dirty.
 Changing the 'tmppiggy.lnk' in the Makefile can be done, but the value
 (to know the length of the decompressor code) has to be _before_ the code
 itself in the raw file.
 Else whatever signature at whatever fixed address with the code+rodata
 size following would make me happy.

  Sorry again for the confusion,
  Etienne.

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
