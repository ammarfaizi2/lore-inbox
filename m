Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270624AbTHJSom (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 14:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270622AbTHJSom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 14:44:42 -0400
Received: from hades.mk.cvut.cz ([147.32.96.3]:37032 "EHLO hades.mk.cvut.cz")
	by vger.kernel.org with ESMTP id S270627AbTHJSoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 14:44:39 -0400
Message-ID: <3F369296.10709@kmlinux.fjfi.cvut.cz>
Date: Sun, 10 Aug 2003 20:44:38 +0200
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030808
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hpt366 kernel panic on EPoX 8K9A3+ fix (?)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please cc:]

Hello,

with the 2.6.0-test3 kernel, hpt366 still does nothing else than kernel 
panic on my machine. However, I found that with my EPoX 8K9A3+, the 0x78 
(frequency) register of HPT374 has values in the interval of 0x9B..0x9E, 
although the FSB is set to 133MHz and PCI should be at 33. Then, in 
init_hpt37x, the execution usually goes thru the "freq < 0xb0" branch, 
which doesn't do the pci_set_drvdata stuff. Later, the frequency 
detection loop fails because hpt374 internal PLL isn't supported. 
However, changing the respective branch to

         } else if (freq < 0xb0) {
                 pll = F_LOW_PCI_40;
                 if (hpt_minimum_revision(dev,8)) {
                         pci_set_drvdata(dev, (void *) 		 
thirty_three_base_hpt374);
                         printk("HPT37X: using 33MHz PCI clock\n");
                 }
	} ...

made the driver work, although I didn't have time to test it (just 
mounted the disk and copied a few files).

Regards,
-- 
Jindrich Makovicka

