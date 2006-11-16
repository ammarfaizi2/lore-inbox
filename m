Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162270AbWKPE2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162270AbWKPE2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 23:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162272AbWKPE2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 23:28:25 -0500
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:45538 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1162270AbWKPE2Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 23:28:24 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Wed, 15 Nov 2006 20:25:01 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907209@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ALSA: hda-intel - Disable MSI support by default
Thread-Index: AccI+G+74GXGy7WIQ3ad7MeRPzzpxAAG1HgwAAeB11AAAR5gUA==
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Lu, Yinghai" <yinghai.lu@amd.com>,
       "Olivier Nicolas" <olivn@trollprod.org>,
       "Linus Torvalds" <torvalds@osdl.org>
cc: "Mws" <mws@twisted-brains.org>, "Jeff Garzik" <jeff@garzik.org>,
       "Krzysztof Halasa" <khc@pm.waw.pl>,
       "David Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
X-OriginalArrivalTime: 16 Nov 2006 04:25:02.0825 (UTC)
 FILETIME=[2F820590:01C70937]
X-WSS-ID: 694537941WC498782-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the root cause in hda_intel driver's self.

It gets io-apic irq initialized at first, and it will use
azx_acquire_irq to install handler after check if MSI can be enabled.
And when it try to enable the MSI, that will start the int in the chip.
Even handler for MSI is not installed.

YH




