Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVBOBCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVBOBCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVBOBBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:01:20 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:39840 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261540AbVBOA7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:59:06 -0500
Date: Tue, 15 Feb 2005 01:58:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, rmk+serial@arm.linux.org.uk
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Fix u32 vs. pm_message_t confusion in serials
Message-ID: <20050215005854.GJ5415@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes u32 vs. pm_message_t confusion in serials. Please apply,

								Pavel
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-mm/drivers/serial/8250.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/serial/8250.c	2005-02-15 01:04:10.000000000 +0100
@@ -2316,7 +2316,7 @@
 	return 0;
 }
 
-static int serial8250_suspend(struct device *dev, u32 state, u32 level)
+static int serial8250_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int i;
 
--- clean-mm/drivers/serial/8250_pci.c	2004-12-25 13:35:01.000000000 +0100
+++ linux-mm/drivers/serial/8250_pci.c	2005-02-15 01:04:10.000000000 +0100
@@ -1759,7 +1759,7 @@
 	}
 }
 
-static int pciserial_suspend_one(struct pci_dev *dev, u32 state)
+static int pciserial_suspend_one(struct pci_dev *dev, pm_message_t state)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
