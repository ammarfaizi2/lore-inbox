Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSHQSsg>; Sat, 17 Aug 2002 14:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSHQSsg>; Sat, 17 Aug 2002 14:48:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57494 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318128AbSHQSsf>;
	Sat, 17 Aug 2002 14:48:35 -0400
Date: Sat, 17 Aug 2002 20:53:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Gabriel Paubert <paubert@iram.es>,
       James Bottomley <James.Bottomley@HansenPartnership.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch
In-Reply-To: <Pine.LNX.4.44.0208171134070.3169-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208172051280.17227-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oh, setup.S. nasty indeed. (yet) untested patch attached, booting into the
new kernel shortly.

	Ingo

--- linux/arch/i386/boot/setup.S.orig2	Sat Aug 17 20:53:41 2002
+++ linux/arch/i386/boot/setup.S	Sat Aug 17 20:54:40 2002
@@ -1029,8 +1029,7 @@
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
 gdt_48:
-	.word	0x8000				# gdt limit=2048,
-						#  256 GDT entries
+	.word	GDT_ENTRY_KERNEL_CS*8 + 16 - 1	# gdt limit
 
 	.word	0, 0				# gdt base (filled in later)
 

