Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbTIPXjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 19:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbTIPXjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 19:39:17 -0400
Received: from fmr06.intel.com ([134.134.136.7]:5274 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262554AbTIPXjM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 19:39:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: Options for handling  buggy PCI/PCI-X hardware when MSI is enabled
Date: Tue, 16 Sep 2003 14:26:23 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AF60@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Options for handling  buggy PCI/PCI-X hardware when MSI is enabled
Thread-Index: AcN8mS2NgZiyy9FfTl+Np1Q3gJR3Qw==
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 16 Sep 2003 21:26:23.0948 (UTC) FILETIME=[2DF690C0:01C37C99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The other day, Long (Tom) posted:

   During testing we have found many currently shipping 
   PCI/PCI-X MSI-capable devices have silicon bugs specific to 
   MSI support. Most of these will cause system failures when 
   MSI is enabled. To filter out MSI buggy hardware requires the 
   kernel to detect and disable the MSI support on specific hardware. 

So far we've got two options based on the input from the community
(Jeff, Zwane, etc., thanks) to deal with this problem:
(1)  the blacklist approach
(2)  the new API (enable_msi, for example) approach

We would like to solicit more input to close this, to finalize the
solution.

Thanks,
Jun
======
"Blacklist" approach using PCI_quirks.c
---------------------------------------
Pros
   - Places the burden to fix broken HW on the HW owners
   - Consistent with the current MSI patch (enable all by default)
   - A simple fix and minimum patch size (Patch already exists)
Cons
   - Core kernel impact (larger image size)
   - Added entries will require a kernel rebuild (core kernel code
change)

New API approach (enable_msi, for example)
-------------------------------------------
Pros
   - Only working devices will be enabled via modification of the device

     driver. 
   - Minimum impact (image size increase very small)
Cons
   - All devices desiring MSI support will be required to modify
associated   
     device drivers 
   - Validation burden - known good devices not know until the driver is

     modified and device tested
   - The burden for MSI support is on devices that work and not those
that 
     are broken 


