Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUHWUUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUHWUUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUHWUTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:19:38 -0400
Received: from fmr06.intel.com ([134.134.136.7]:64467 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267433AbUHWTJx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:09:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] [broken?] Add MSI support to e1000
Date: Mon, 23 Aug 2004 12:09:36 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240619D9DA@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [broken?] Add MSI support to e1000
Thread-Index: AcSJNwRs4zo5B7KzQDSgaCSsNmW6aAACdFMg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>
Cc: "cramerj" <cramerj@intel.com>, "Ronciak, John" <john.ronciak@intel.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>,
       <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 23 Aug 2004 19:09:39.0930 (UTC) FILETIME=[BD4343A0:01C48944]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 23, 2004 Roland Dreier wrote: 
>    Tom> I do not see anything wrong with the patch and the kernel MSI
>    Tom> support because it works for a short time. Ganesh may provide
>    Tom> an answer on the MSI support in e1000 hardware.
>
>Based on the e1000 documentation I have, the only thing required for
>the e1000 to use MSI is to set the MSI enable bit in the PCI header.
>Of course there may be some e1000 erratum involving MSI but I have not
>been able to find any indication that this is the case.
>
>It seems possible that there could be some problem in the core Linux
>interrupt code even though some interrupts work -- for example there
>could be a race condition triggered when a second interrupt is
>delivered while handling the first interrupt.  However I couldn't find
>any such bug, although I am not at all an expert about low-level
>interrupt handling/APIC programming.

MSI is an edge trigger, which requires the synchronization handshake 
between the hardware device and its software device driver. For the 
MSI-X capability structure, the kernel handles the synchronization 
by masking and unmasking the MSI maskbits. For the MSI capability 
structure, the MSI maskbits is optional. If the e1000 hardware does not
support the MSI maskbits in its MSI capability structure, I guess it 
could be a race condition in e1000 hardware, which results an 
unpredictable behavior.

Thanks,
Long

