Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318749AbSIEWkb>; Thu, 5 Sep 2002 18:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318750AbSIEWkb>; Thu, 5 Sep 2002 18:40:31 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24537 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318749AbSIEWka>;
	Thu, 5 Sep 2002 18:40:30 -0400
Message-ID: <1031265878.3d77de5627864@imap.linux.ibm.com>
Date: Thu,  5 Sep 2002 18:44:38 -0400
From: mannthey@us.ibm.com
To: gone@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre5 not booting on numa-q with CONFIG_MULTIQUAD
References: <200209052221.g85MLAQ04867@w-gaughen.beaverton.ibm.com>
In-Reply-To: <200209052221.g85MLAQ04867@w-gaughen.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.47.18.119
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Patricia Gaughen <gone@us.ibm.com>:

> 
> Hi,
> 
> 2.4.20pre4 booted fine for me, but 2.4.20pre5 is not booting on the numa-q 
> boxes when I turn on CONFIG_MULTIQUAD.  I've included the messages that I see

Hello Pat,
  I am not familiar with this are of the code either but I found a while loop
if some recent pci changes that seemed backwards.  The following patch should
allow you to boot.


diff -urN linux-2.4.19/drivers/pci/pci.c linux-2.4.20-pre5/drivers/pci/pci.c
--- linux-2.4.20-pre5/drivers/pci/pci.c      Sat Sep  7 06:29:04 2002
+++ linux-2.4.20-pre5-test/drivers/pci/pci.c Sat Sep  7 06:10:26 2002
@@ -586,7 +586,7 @@
                i + 1, /* PCI BAR # */
                pci_resource_len(pdev, i), pci_resource_start(pdev, i),
                pdev->slot_name);
-       while(--i <= 0)
+       while(--i >= 0)
                pci_release_region(pdev, i);

        return -EBUSY;

Keith


