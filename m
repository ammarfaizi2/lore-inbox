Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbSL3VsJ>; Mon, 30 Dec 2002 16:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbSL3VsJ>; Mon, 30 Dec 2002 16:48:09 -0500
Received: from host194.steeleye.com ([66.206.164.34]:44039 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265506AbSL3VsI>; Mon, 30 Dec 2002 16:48:08 -0500
Message-Id: <200212302156.gBULuRS04298@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       james.bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rename CONFIG_VOYAGER to CONFIG_X86_VOYAGER 
In-Reply-To: Message from Christoph Hellwig <hch@lst.de> 
   of "Mon, 30 Dec 2002 22:44:56 +0100." <20021230224456.A20753@lst.de> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-7401461440"
Date: Mon, 30 Dec 2002 15:56:27 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-7401461440
Content-Type: text/plain; charset=us-ascii

Actually this one won't link because of an unmodified CONFIG_VOYAGER in 
hw_irq.h

However, I think this #if needs modifying according to the attached patch, 
anyway.  I think it's obviously correct, but can someone with an APIC based 
SMP system test this, please.

James


--==_Exmh_-7401461440
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== include/asm-i386/hw_irq.h 1.16 vs edited =====
--- 1.16/include/asm-i386/hw_irq.h	Sat Dec 28 11:12:01 2002
+++ edited/include/asm-i386/hw_irq.h	Mon Dec 30 15:50:21 2002
@@ -131,7 +131,7 @@
 
 #endif /* CONFIG_PROFILING */
  
-#if defined(CONFIG_SMP) && !defined(CONFIG_VOYAGER) /*more of this file should probably be ifdefed SMP */
+#ifdef CONFIG_X86_IO_APIC /*more of this file should probably be ifdefed SMP */
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {
 	if (IO_APIC_IRQ(i))
 		send_IPI_self(IO_APIC_VECTOR(i));

--==_Exmh_-7401461440--


