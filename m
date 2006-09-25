Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWIYMPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWIYMPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWIYMPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:15:30 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:4847 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750848AbWIYMPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:15:30 -0400
Date: Mon, 25 Sep 2006 14:15:27 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: unsigned long flags; (was Re: 2.6.18-mm1)
Message-ID: <20060925141527.1906f81a@cad-250-152.norway.atmel.com>
In-Reply-To: <b6fcc0a0609240647v2df20521m9ee4f4af9785a23c@mail.gmail.com>
References: <b6fcc0a0609240647v2df20521m9ee4f4af9785a23c@mail.gmail.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 17:47:41 +0400
"Alexey Dobriyan" <adobriyan@gmail.com> wrote:

> avr32 does unsigned int flags in show_dtlb_entry() and tlb_show()

Thanks. Andrew, please consider merging the patch below together with
the rest of the AVR32 stuff.

---
From: Haavard Skinnemoen <hskinnemoen@atmel.com>

AVR32: Use unsigned long flags for saving interrupt state

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mm/tlb.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc7-mm1/arch/avr32/mm/tlb.c
===================================================================
--- linux-2.6.18-rc7-mm1.orig/arch/avr32/mm/tlb.c	2006-09-25 14:04:22.000000000 +0200
+++ linux-2.6.18-rc7-mm1/arch/avr32/mm/tlb.c	2006-09-25 14:09:22.000000000 +0200
@@ -15,7 +15,8 @@
 
 void show_dtlb_entry(unsigned int index)
 {
-	unsigned int tlbehi, tlbehi_save, tlbelo, mmucr, mmucr_save, flags;
+	unsigned int tlbehi, tlbehi_save, tlbelo, mmucr, mmucr_save;
+	unsigned long flags;
 
 	local_irq_save(flags);
 	mmucr_save = sysreg_read(MMUCR);
@@ -305,7 +306,8 @@ static void tlb_stop(struct seq_file *tl
 
 static int tlb_show(struct seq_file *tlb, void *v)
 {
-	unsigned int tlbehi, tlbehi_save, tlbelo, mmucr, mmucr_save, flags;
+	unsigned int tlbehi, tlbehi_save, tlbelo, mmucr, mmucr_save;
+	unsigned long flags;
 	unsigned long *index = v;
 
 	if (*index == 0)
