Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263881AbRFDWK5>; Mon, 4 Jun 2001 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263918AbRFDWKr>; Mon, 4 Jun 2001 18:10:47 -0400
Received: from pc7.prs.nunet.net ([199.249.167.77]:26885 "HELO
	pc7.prs.nunet.net") by vger.kernel.org with SMTP id <S263881AbRFDWKc>;
	Mon, 4 Jun 2001 18:10:32 -0400
Message-ID: <20010604221030.27042.qmail@pc7.prs.nunet.net>
From: "Rico Tudor" <rico-linux-kernel@patrec.com>
Subject: Re: IO-APIC, beaten with stick, routes USB
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 4 Jun 101 17:10:30 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B1BBDCF.B8F49B11@mandrakesoft.com> from "Jeff Garzik" at Jun 4, 1 12:56:47 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any chance you can try Alan Cox's patch against 2.4.5?  It has a number
> of IO-APIC fixes.
> 

patch-2.4.5-ac7.bz2 behaves the same as 2.4.4.  Whatever is happening in
IO-APIC setup, USB interrupts actually arrive on IRQ 12.  I can include
the usual pile of config info and boot messages, but they look the same
as previous l-k postings.

Since IRQ 12 is a popular destination for USB, the following patch may
work for people with this problem:

--- usb-ohci.c	Sun May  6 08:42:51 2001
+++ usb-ohci.c.rico	Mon Jun  4 20:49:56 2001
@@ -2524,3 +2524,3 @@
 
-	return hc_found_ohci (dev, dev->irq, mem_base, id);
+	return hc_found_ohci (dev, 12, mem_base, id);
 } 

If 12 fails, they can look for the stray interrupt in /proc/stat.
