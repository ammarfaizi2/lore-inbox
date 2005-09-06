Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbVIFBPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVIFBPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 21:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbVIFBPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 21:15:31 -0400
Received: from mail.tor.primus.ca ([216.254.136.21]:4248 "EHLO
	smtp-03.primus.ca") by vger.kernel.org with ESMTP id S965047AbVIFBPb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 21:15:31 -0400
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: linux-kernel@vger.kernel.org
Subject: Bit Truncation in drivers/pci/probe.c on amd64
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1380
Date: Mon, 5 Sep 2005 21:15:27 -0400
Cc: kernel-janitors@lists.osdl.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509052115.27300.ace@staticwave.ca>
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
Gabriel A. Devenyi
ace@staticwave.ca
