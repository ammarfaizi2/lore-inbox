Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbVI3Q0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbVI3Q0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbVI3Q0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:26:17 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.86]:43966 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S1030357AbVI3Q0Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:26:16 -0400
Content-class: urn:content-classes:message
Subject: Net: e1000 driver: TX Hang message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 30 Sep 2005 18:21:24 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <C086BA41F8EFC942B7BBBCF09CC95D210E7634@svr.msc-africa.co.za>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Net: e1000 driver: TX Hang message
Thread-Index: AcXF2wBRZ2emSS9CSDeIwBY5wB2I9w==
From: "Gerrit Visser" <g.visser@msc-africa.co.za>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a DELL precision 670 that has an Intel Gigabit Ethernet onboard
NIC (82545GM chipset). It receives packets but keeps on giving "Tx hang"
messages and doesn't send any packets.

Both standard Redhat WS4 (kernel 2.6.9) and kernel 2.6.13.2 did the
same.

To fix it, I've changed the following in the file e1000_hw.c:

    case E1000_DEV_ID_82545GM_COPPER:
    case E1000_DEV_ID_82545GM_FIBER:
    case E1000_DEV_ID_82545GM_SERDES:
        hw->mac_type = e1000_82545_rev_3;
        break;

to

    case E1000_DEV_ID_82545GM_COPPER:
    case E1000_DEV_ID_82545GM_FIBER:
    case E1000_DEV_ID_82545GM_SERDES:
        hw->mac_type = e1000_82545;
        break;

(ie. removed the "_rev_3")

I'm not certain whether it's necessary to change this for copper, fiber
and serdes. Mine is a copper (pci id 1026).

This worked for the Linux e1000 driver from Intel's website, but exactly
the same piece of code is in the 2.6.13.2 kernel's e1000 driver.

Best regards,
Gerrit


