Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVDBSDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVDBSDy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 13:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVDBSDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 13:03:53 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:9166 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261710AbVDBSDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 13:03:51 -0500
Message-Id: <200504021804.j32I4XGd002721@dell.home>
To: linux-kernel@vger.kernel.org
Subject: PCI bridge devices questions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2718.1112465073.1@dell.home>
Date: Sat, 02 Apr 2005 13:04:33 -0500
From: "Marty Leisner" <leisner@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to write some code to insert a non-standard bridge
(it identifies itself as bridge-other, but it functions
as a pci-pci bridge).

I'm going to be using 2.4.2x and eventually 2.6.x for intel
and ppc...

In the pci_dev structure (for 2.4.29)
there's
(in include/linux/pci.h)

00355 #define DEVICE_COUNT_RESOURCE   12
00410         struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */

We also have:
00431 /*
00432  *  For PCI devices, the region numbers are assigned this way:
00433  *
00434  *      0-5     standard PCI regions
00435  *      6       expansion ROM
00436  *      7-10    bridges: address space assigned to buses behind the bridge
00437  */
00438 
00439 #define PCI_ROM_RESOURCE 6
00440 #define PCI_BRIDGE_RESOURCES 7
00441 #define PCI_NUM_RESOURCES 11

Now where my confusion sets in:
	1) PCI_NUM_RESOURCES + 1 == DEVICE_COUNT_RESOURCE 
Why?
	2) I understand the first 6 regions (standard) and the expansion rom) --
	   why 5 more?  
	3) I've only seen instances of 3 bus regions used -- IO, MEM prefetch,
		MEM nonprefetch -- are they order dependent?
		
	4) would it make more sense to have seperate arrays?  One of for the 
	device resources, one for the bridge resources?

Thanks...

Marty Leisner
leisner@rochester.rr.com
