Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWEHX2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWEHX2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 19:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWEHX2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 19:28:14 -0400
Received: from mga03.intel.com ([143.182.124.21]:33547 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750703AbWEHX2N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 19:28:13 -0400
X-IronPort-AV: i="4.05,103,1146466800"; 
   d="scan'208"; a="33404009:sNHT320664379"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 2/3] swiotlb: create __alloc_bootmem_low_nopanic and add support in SWIOTLB
Date: Mon, 8 May 2006 16:28:07 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0670355D@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/3] swiotlb: create __alloc_bootmem_low_nopanic and add support in SWIOTLB
Thread-Index: AcZyW3g8SoRN+F5sSj6f3qcNJfjgGAAle4HA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jon Mason" <jdmason@us.ibm.com>, "Muli Ben-Yehuda" <muli@il.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <ak@suse.de>, <linux-ia64@vger.kernel.org>,
       <mulix@mulix.org>
X-OriginalArrivalTime: 08 May 2006 23:28:08.0474 (UTC) FILETIME=[106D87A0:01C672F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon,

Trailing white space added by part2 and part3 annoys "git" (29
total places between the two parts).

Generic builds (based on arch/ia64/defconfig or arch/ia64/configs/gensparse_defconfig)
throws out 3 warnings, one each from arch/ia64/hp/zx1/hpzx1_machvec.c,
arch/ia64/hp/zx1/hpzx1_swiotlb_machvec.c and arch/ia64/sn/kernel/machvec.c

include/asm/machvec_init.h:32: warning: initialization from incompatible pointer type

The problems is "platform_dma_init" which can be defined as
"machvec_noop()" which returns "void", not "int" at required
by your change to the ia64_mv_dma_init type.

On the plus side it does boot on ia64 Intel Tiger ... but more of
the fancier bits of this code are used by the zx1 and zx1_swiotlb
versions which I didn't get time to test today.

-Tony
