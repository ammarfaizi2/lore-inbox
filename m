Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVICBxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVICBxW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 21:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVICBxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 21:53:22 -0400
Received: from mail.tor.primus.ca ([216.254.136.21]:15490 "EHLO
	smtp-01.primus.ca") by vger.kernel.org with ESMTP id S1751355AbVICBxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 21:53:21 -0400
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: linux-kernel@vger.kernel.org
Subject: Bit Truncation in drivers/pci/probe.c on amd64
Date: Fri, 2 Sep 2005 21:53:09 -0400
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509022153.10171.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the current git repository, on my amd64 machine I get the following warning on compile
drivers/pci/probe.c: In function `pci_read_bases':
drivers/pci/probe.c:166: warning: large integer implicitly truncated to unsigned type
drivers/pci/probe.c:216: warning: large integer implicitly truncated to unsigned type

I've tracked this down to pci_size, and two #define's in include/linux/pci.h

#define  PCI_BASE_ADDRESS_MEM_MASK	(~0x0fUL)
#define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)

pci_size expects 3 u32 arguments,but from what I can tell, on 64 bit arch's the two above 
defines expand to 64bit values, and are truncated when being passed.

I'm not sure how to go about fixing this, if pci_size should accept a u64 or if the defines should
be changed. Is this bug dangerous? What should be done to fix it?

-- 
Gabriel Devenyi
ace@staticwave.ca
