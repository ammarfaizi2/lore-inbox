Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267455AbUHPG0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267455AbUHPG0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 02:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267458AbUHPG0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 02:26:04 -0400
Received: from gprs214-198.eurotel.cz ([160.218.214.198]:4741 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267455AbUHPGZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 02:25:50 -0400
Date: Mon, 16 Aug 2004 08:25:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, mochel@digitalimplant.org,
       benh@kernel.crashing.org, david-b@pacbell.net
Subject: Re: [patch] enums to clear suspend-state confusion
Message-ID: <20040816062523.GB30338@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz> <20040815175949.19d03e7f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815175949.19d03e7f.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +enum pci_state {
> >  +	D0 = 0,
> >  +	D1 = 1,
> >  +	D2 = 2,
> 
> These symbols are too generic.  They don't appear to currently clash with
> anything else, but they could.

Actually jffs is using macros called D1, D2 and D3. Ouch. This one
should fix it.
									Pavel

--- linux-forakpm/include/linux/pci.h	2004-08-15 19:35:41.000000000 +0200
+++ linux/include/linux/pci.h	2004-08-16 08:15:59.000000000 +0200
@@ -1023,23 +1023,23 @@
 #define PCIPCI_ALIMAGIK		32
 
 enum pci_state {
-	D0 = 0,
-	D1 = 1,
-	D2 = 2,
-	D3hot = 3,
-	D3cold = 4
+	PCI_D0 = 0,
+	PCI_D1 = 1,
+	PCI_D2 = 2,
+	PCI_D3hot = 3,
+	PCI_D3cold = 4
 };
 
 static inline enum pci_state to_pci_state(suspend_state_t state)
 {
 	if (SUSPEND_EQ(state, PM_SUSPEND_ON))
-		return D0;
+		return PCI_D0;
 	if (SUSPEND_EQ(state, PM_SUSPEND_STANDBY))
-		return D1;
+		return PCI_D1;
 	if (SUSPEND_EQ(state, PM_SUSPEND_MEM))
-		return D3hot;
+		return PCI_D3hot;
 	if (SUSPEND_EQ(state, PM_SUSPEND_DISK))
-		return D3cold;
+		return PCI_D3cold;
 	BUG();
 }
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
