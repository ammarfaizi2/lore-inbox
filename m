Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUCBSWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 13:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUCBSWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 13:22:34 -0500
Received: from fmr09.intel.com ([192.52.57.35]:10990 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261729AbUCBSWd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 13:22:33 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Network error with Intel E1000 Adapter on update 2.4.25 ==> 2.6.3
Date: Tue, 2 Mar 2004 10:22:19 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDEC9@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Network error with Intel E1000 Adapter on update 2.4.25 ==> 2.6.3
Thread-Index: AcP9LGy9DCYDtwk0RnOTuLLUfxW6jQCky7RgABbgo8AAGdr8oA==
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Martin Bene" <martin.bene@icomedias.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Mar 2004 18:22:19.0949 (UTC) FILETIME=[4CA00DD0:01C40083]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> experimenting with the driver source shows that the interrupt 
> displayed by ifconfig seems to depend on netdev->irq being 
> set; this was removed during the netdev->irq ==> 
> adapter->pdev->irq change. adding the following line corrects 
> ifconfig display:

Caching pdev->irq in netdev->irq is problematic because pdev->irq can
change after registering for MSI interrupts, for example.  netdev->irq
is vestigial from the days of manual irq assignment.

Bottom line is you'll not see the irq with ifconfig, but it'll be there
in /proc and lspci.

-scott
