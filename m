Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUEFN1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUEFN1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUEFN0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:26:03 -0400
Received: from fmr99.intel.com ([192.55.52.32]:43240 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262170AbUEFNXe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:23:34 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [2.6.6 PATCH] Exposing EFI memory map
Date: Thu, 6 May 2004 06:23:27 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F012F28FC@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.6 PATCH] Exposing EFI memory map
Thread-Index: AcQzaYHg3FywoUPdRzqwiKSySMuf+AAAvmNg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Matt Domsch" <Matt_Domsch@dell.com>, "Sourav Sen" <souravs@india.hp.com>
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 May 2004 13:23:28.0374 (UTC) FILETIME=[516C9960:01C4336D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>2) Can the memory map output ever be larger than PAGE_SIZE (lower
>limit is 4KB on x86)?  If not, what guarantees that?  If so, you need
>your own read mechanism rather than the generic sysfs one.

The output format of the sprintf() gives 58 characters per entry, which
with a 4k page allows for 70 entries before the page overflows, which
feels borderline for ccNUMA machines.  On ia64 the pagesize is usually
16k, which would allow 282 entries.  I think this will fail on a 128
node SGI sn2 (because there are 4 memory banks per node => min 512
entries
in the memory map).

-Tony
