Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTJUJXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 05:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbTJUJXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 05:23:47 -0400
Received: from hades.mk.cvut.cz ([147.32.96.3]:47771 "EHLO hades.mk.cvut.cz")
	by vger.kernel.org with ESMTP id S262655AbTJUJXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 05:23:46 -0400
Message-ID: <3F94FB1B.9000803@kmlinux.fjfi.cvut.cz>
Date: Tue, 21 Oct 2003 11:23:39 +0200
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Tomi.Orava@ncircle.nullnet.fi, linux-kernel@vger.kernel.org
Subject: Re: HighPoint 374
Content-Type: multipart/mixed;
 boundary="------------050800050909040907060308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050800050909040907060308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

With my EPoX 8K9A3+, I had to hack the kernel to get the HPT374 running 
at all, as it reported slightly higher PCI clock than 33MHz, although 
the machine wasn't overclocked, but it seems to run fine. The current 
driver supports only 33MHz clock, which is probably the reason HPT374 
isn't even initialized in some cases.

-- 
Jindrich Makovicka

--------------050800050909040907060308
Content-Type: text/plain;
 name="hpt366.c.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hpt366.c.patch2"

--- hpt366.c.orig	2003-08-26 15:08:59.000000000 +0200
+++ hpt366.c	2003-08-26 15:09:46.000000000 +0200
@@ -808,6 +808,8 @@
 		printk("HPT37X: using 33MHz PCI clock\n");
 	} else if (freq < 0xb0) {
 		pll = F_LOW_PCI_40;
+		if (hpt_minimum_revision(dev,8))
+			pci_set_drvdata(dev, (void *) thirty_three_base_hpt374);
 	} else if (freq < 0xc8) {
 		pll = F_LOW_PCI_50;
 		if (hpt_minimum_revision(dev,8))

--------------050800050909040907060308--

