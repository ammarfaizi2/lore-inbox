Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbTHGRlM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269661AbTHGRlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:41:12 -0400
Received: from fmr05.intel.com ([134.134.136.6]:43740 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270003AbTHGRlH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:41:07 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Loading Pentium III microcode under Linux - catch 22!
Date: Thu, 7 Aug 2003 10:40:57 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AE75@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Loading Pentium III microcode under Linux - catch 22!
Thread-Index: AcNc/3Jiz1TGLVL9QJ2fDBjecGW3RwAB/igg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Tigran Aivazian" <tigran@veritas.com>
Cc: "Chris Rankin" <rankincj@yahoo.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Aug 2003 17:40:58.0502 (UTC) FILETIME=[0FA54A60:01C35D0B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One issue with doing it in lilo or grub is that we need to apply
microcode update to each (physical) CPU. So we need to change the
current driver structure if we want to move it to the boot loader. So
one of the other ways is:
1. Boot loader copies update to memory
2. Kernel applies update soon after it brings the processors (including
BP, and APs) online in init_intel() or something like that. 

We don't need IPI or even the microcode update driver if we do this. But
I think putting it in initrd should be sufficient.

Thanks,
Jun

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Thursday, August 07, 2003 8:55 AM
> To: Tigran Aivazian
> Cc: Chris Rankin; Linux Kernel Mailing List
> Subject: Re: Loading Pentium III microcode under Linux - catch 22!
> 
> On Iau, 2003-08-07 at 16:57, Tigran Aivazian wrote:
> > I could implement this, but if you tell me that this is not allowed
> > because of the GPL issues (microcode data chunks are copyrighted by
> Intel)
> > then obviously I won't waste time writing the code to do this.
> 
> Thats something we are moving away from, so that we can load firmware
> from the initrd. Another interesting place to tackle it might be in
lilo
> or grub ?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
