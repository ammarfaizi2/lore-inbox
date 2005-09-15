Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVIOKaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVIOKaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 06:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVIOKaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 06:30:00 -0400
Received: from ip57.73.1311O-CUD12K-02.ish.de ([62.143.73.57]:36554 "EHLO
	metzlerbros.de") by vger.kernel.org with ESMTP id S932485AbVIOK37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 06:29:59 -0400
From: Ralph Metzler <rjkm@metzlerbros.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17193.19739.213773.593444@localhost.localdomain>
Date: Thu, 15 Sep 2005 12:29:47 +0200
To: Manu Abraham <manu@linuxtv.org>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI driver
In-Reply-To: <4329362A.1030201@linuxtv.org>
References: <4327EE94.2040405@kromtek.com>
	<200509150843.33849@bilbo.math.uni-mannheim.de>
	<4329269E.1060003@linuxtv.org>
	<200509151018.20322@bilbo.math.uni-mannheim.de>
	<4329362A.1030201@linuxtv.org>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manu,

Manu Abraham writes:
 > [  102.261264] mantis_pci_probe: Got a device
 > [  102.262852] mantis_pci_probe: We got an IRQ
 > [  102.264392] mantis_pci_probe: We finally enabled the device
 > [  102.266020] Mantis Rev 1, irq: 23, latency: 32
 > [  102.266118]          memory: 0xefeff000, mmio: f9218000
 > [  102.269162] Trying to free free IRQ23
 > [  110.297341] mantis_pci_remove: Removing -->Mantis irq: 23,         
 > latency: 32
 > [  110.297344]  memory: 0xefeff000, mmio: 0xf9218000
 > [  110.301326] Trying to free free IRQ23
 > [  110.303445] Trying to free nonexistent resource <efeff000-efefffff>


I think you should call pci_enable_device() before request_irq, etc. 
AFAIK, the pci_enable_device() can change resources like IRQ.
That's probably what causes these errors. Just print out the irq 
number before and after pci_enable_device() to check if that's the 
problem.


Ralph
