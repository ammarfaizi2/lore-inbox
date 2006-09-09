Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWIIRTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWIIRTM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 13:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWIIRTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 13:19:12 -0400
Received: from cinke.fazekas.hu ([195.199.244.225]:14469 "EHLO
	cinke.fazekas.hu") by vger.kernel.org with ESMTP id S1751331AbWIIRTK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 13:19:10 -0400
Date: Sat, 9 Sep 2006 19:19:03 +0200 (CEST)
From: Marton Balint <cus@fazekas.hu>
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
Subject: Driver_data is probably zero in serverworks IDE driver
Message-ID: <Pine.LNX.4.61.0609091840170.30278@cinke.fazekas.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a ServerWorks CSB6 IDE controller, and with kernel 2.6.18-rc6 it is 
detected as OSB4. I think this happens because the driver_data in the 
pci_device_id table is zero for every device that uses the ServerWorks 
driver.

Please take a look at commit f201f5046ddaeeccb036bdf6848549bf5cb51bb1.
This commit introduced the usage of the PCI_DEVICE macro, but this macro 
does not set class and class_mask so I think now we set .class instead of 
.driver_data. The drivers that are also affected by this commit may 
have similar problems.

Marton
