Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVI3Rc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVI3Rc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVI3Rc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:32:57 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:60428 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751221AbVI3Rc5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:32:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <433D71A0.1040104@compro.net>
References: <433D71A0.1040104@compro.net>
X-OriginalArrivalTime: 30 Sep 2005 17:32:54.0311 (UTC) FILETIME=[FD515B70:01C5C5E4]
Content-class: urn:content-classes:message
Subject: Re: Opterons and setting the pci bus master bit
Date: Fri, 30 Sep 2005 13:32:53 -0400
Message-ID: <Pine.LNX.4.61.0509301318370.31041@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Opterons and setting the pci bus master bit
Thread-Index: AcXF5P1yx1mrzv6fQWqDa3Ou0H29Hg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Mark Hounschell" <markh@compro.net>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Sep 2005, Mark Hounschell wrote:

> Problem, I have a number of dual processor Opterons that do not work
> with pci expansion chassis'. The reason that they do not work is because
> none of the cards discovered in the chassis get the pci bus master bit
> set in their command register. If I manually set this bit in our cards
> everything is fine. When we connect the same chassis to an Intel P4 box
> everything is fine. It looks like it is the kernel that sets this bit
> because we have never set it in any of our drivers, yet on the intel
> boxes it gets set. Why would this bit not be set when the chassis is
> connected to an Opteron. We are running 32-bit mode BTW. I am using a
> 2.6.11.9 kernel. Is this a motherboard problem or could this be a kernel
> problem?
>
> Thanks
> Mark

The PCI Busmaster bit should (read must) be set by the driver to enble
bus-mastering after the dma mask is set.

   Commands are (in order):

    pci_set_dma_mask(dev, 0xffffffffULL);    // 32 bit DMA only
    pci_set_drvdata(dev, NULL);              // Harmless if unused
    pci_set_power_state(dev, 0);             // Turn it ON
    pci_set_master(dev);                     // Make bus-master
    pci_set_mwi(dev);	// Check return, different code
    pci_write_config_dword(dev, PCI_COMMAND, PCI_CONFIG_YOU_DEFINE);

   Typical bus-master PCI_CONFIG_YOU_DEFINE is:
     (PCI_COMMAND_MEMORY|PCI_COMMAND_MASTER|PCI_COMMAND_SERR)



Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
