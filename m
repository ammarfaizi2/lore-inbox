Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbTIVF70 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 01:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbTIVF70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 01:59:26 -0400
Received: from fmr09.intel.com ([192.52.57.35]:2506 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262995AbTIVF7Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 01:59:24 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.x] additional kernel event notifications
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Sun, 21 Sep 2003 22:59:21 -0700
Message-ID: <7F740D512C7C1046AB53446D372001730606B9@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.x] additional kernel event notifications
Thread-Index: AcN/GzjfCIoxgMLnSmuYZEmcjqIZ+wBsg80A
From: "Villacis, Juan" <juan.villacis@intel.com>
To: "Andi Kleen" <ak@muc.de>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Sep 2003 05:59:21.0919 (UTC) FILETIME=[AB20FCF0:01C380CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Andi Kleen" <ak@muc.de> writes:
> Can you explain why profiling dynamically generated code needs kernel
> support? The kernel should not know anything about this.

In some cases, a profiler can figure out information regarding
Dynamically Generate Code (DGC) with help from the generator of the
code, but in other cases it cannot.

In the case of Java jitted code, our userspace tools obtain sufficient
information through JVMPI, when it is implemented by the JVM.  However,
for DGC which does not have such userspace support, it is important to
be able to spot and accurately attribute samples to DGC.  The 4
additional profiling hooks we proposed can be used for such purposes.

> The original oprofile patch also added similar hooks, but they were
> not merged. Instead the "dcookies" mechanism was added to assign
samples 
> to specific executables. Why can't you use the same mechanism? 

If the generator of DGC frees memory used for DGC that subsequently gets
a loaded image (or reuses memory that may have once had an executable
image), you can mis-attribute samples so that instead of attributing the
samples to the DGC, you will attribute the samples to an image. The
dcookie mechanism will indicate information about an image, but doesn't
help prevent mis-attribution of samples if DGC is intermixed with images
that are loaded/unloaded in the same memory region.

-juan

