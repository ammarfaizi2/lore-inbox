Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUBTTnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUBTTmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:42:19 -0500
Received: from fmr06.intel.com ([134.134.136.7]:26573 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261368AbUBTTbV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:31:21 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH]2.6.3-rc2 MSI Support for IA64
Date: Fri, 20 Feb 2004 11:31:07 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024040580FE@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]2.6.3-rc2 MSI Support for IA64
Thread-Index: AcP34t/E5zccjMf3S4OqTa1goS7agQAAPU8A
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: =?iso-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: "Andreas Schwab" <schwab@suse.de>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
X-OriginalArrivalTime: 20 Feb 2004 19:31:08.0082 (UTC) FILETIME=[16A3E920:01C3F7E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friday, Feb. 20, 2004 10:58 AM, Mika Penttilä wrote:

>ia64 already has a function ia64_alloc_vector(void) in 
>arch/ia64/kernel/irq_ia64, why the doubling?

+#ifndef CONFIG_PCI_USE_VECTOR
 int
 ia64_alloc_vector (void)
 {
@@ -67,6 +68,7 @@
 		panic("ia64_alloc_vector: out of interrupt vectors!");
 	return next_vector++;
 }
+#endif

#ifndef CONFIG_PCI_USE_VECTOR is added in arch/ia64/kernel/irq_ia64.c
as above to avoid the double definement of ia64_alloc_vector(void).
Setting CONFIG_PCI_USE_VECTOR to 'Y' by enabling MSI support will
use function ia64_alloc_vector(void) defined in drivers/pci/msi.c.
The main reason behind it is to keep track of the number of vectors
already assigned during the runtime. Keeping track of already assigned
vectors is required in MSI implementation.

Thanks,
Long 

