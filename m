Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpHYZlOSr+3BSTo+wOm1P4z1XJQ==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 13:17:11 +0000
Message-ID: <01d601c415a4$7619aaf0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:42:37 +0100
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
From: "Andi Kleen" <ak@muc.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@smtp.paston.co.uk>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: [PATCH] Remove Intel check in i386 HPET code
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:38.0046 (UTC) FILETIME=[7684EFE0:01C415A4]


The i386 HPET time setup code would explicitely check for the Intel
vendor ID. That is bogus because other chipset vendors (like AMD) 
are implementing HPET too. 

Remove this check.

-Andi

diff -u linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c~ linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c
--- linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c~	2004-01-04 14:10:59.000000000 +0100
+++ linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c	2004-01-04 14:10:59.000000000 +0100
@@ -91,10 +91,6 @@
 	    !(id & HPET_ID_LEGSUP))
 		return -1;
 
-	if (((id & HPET_ID_VENDOR) >> HPET_ID_VENDOR_SHIFT) !=
-				HPET_ID_VENDOR_8086)
-		return -1;
-
 	hpet_period = hpet_readl(HPET_PERIOD);
 	if ((hpet_period < HPET_MIN_PERIOD) || (hpet_period > HPET_MAX_PERIOD))
 		return -1;
