Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUGOPtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUGOPtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 11:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUGOPtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 11:49:19 -0400
Received: from fmr06.intel.com ([134.134.136.7]:22405 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266221AbUGOPtF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 11:49:05 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH]2.6.7 MSI-X Update
Date: Thu, 15 Jul 2004 08:46:02 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502405B7A044@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]2.6.7 MSI-X Update
Thread-Index: AcRqElyqpjIWHr05QHyDm330GjRsEQAajY4g
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <ak@muc.de>, <akpm@osdl.org>, <greg@kroah.com>, <jgazik@pobox.com>,
       <linux-kernel@vger.kernel.org>, <zwane@linuxpower.ca>
X-OriginalArrivalTime: 15 Jul 2004 15:46:03.0896 (UTC) FILETIME=[D5D42780:01C46A82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 14, 2004, Roland Dreier wrote:  
>Long, welcome back.  I will review your patch as soon as I have a
>little free time.
Thanks!

>I think it's OK to keep track of which MSI/MSI-X vectors have ISRs
>attached and which don't.  However I don't think free_irq() should
>return a vector to the free pool (that might be used by other
>devices).  In other words it should be OK for a correct driver to do
>
>	pci_enable_msix(pdev...);
>	request_irq(msix_vector1);
>	free_irq(msix_vector1);
>	request_irq(msix_vector1);
>	free_irq(msix_vector1);
>	pci_disable_msix(pdev...);
>
>(obviously with some code in between operations).
>
>I think we agree on this and I will read your code to find out what
>you actually do but I just wanted to make my proposed interface clear.
Yes. With the updated patch, free_irq() "only" keeps track of which 
MSI/MSI-X vectors having ISRs attached and which don't. It will not
return a vector to the free pool.

Thanks,
Long
