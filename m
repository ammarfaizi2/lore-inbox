Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVJXPSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVJXPSa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVJXPSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:18:30 -0400
Received: from magic.adaptec.com ([216.52.22.17]:50637 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751088AbVJXPS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:18:29 -0400
Message-ID: <435CFB3E.7040902@adaptec.com>
Date: Mon, 24 Oct 2005 11:18:22 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Panov <sipan@sipan.org>
CC: Christoph Hellwig <hch@infradead.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally	attached
 PHYs)
References: <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com>	 <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com>	 <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com>	 <43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de>	 <20051022105815.GB3027@infradead.org>	 <1129994910.6286.21.camel@sipan.sipan.org>	 <20051022171943.GA7546@infradead.org> <1130002704.8775.12.camel@sipan.sipan.org>
In-Reply-To: <1130002704.8775.12.camel@sipan.sipan.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2005 15:18:27.0182 (UTC) FILETIME=[2ED928E0:01C5D8AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/05 13:38, Sergey Panov wrote:
>   I just was trying to point out that Luben's transport "layers" in
> place of transport "modules-appendages" simplifies that
> migration/evolution.

True. "modules-appendages" just makes everything messy.  There is
so much SPI in the host template... Take for example recovery,
or as Linux SCSI calls it Error Handling (EH).

EH in Linux SCSI is SPI.  This is a fact, and anyone can look at the
code to convince themselves.

In order to properly get rid ourselves of HCIL, recovery should
be offloaded to the transport _layer_ which communicates with
the transport/interconnect to get things going, as shown in the SAS
Transport Stack at the link in my signature, USB* or SBP subsystems.

* I've been asking Alan to properly implement USB recovery
in the USB Storage subsystem...  Maybe one day...

That is, the layer above knows nothing of the layer below, but
each layer provides well defined functionality, and they all
work in tandem.  This is exactly what allows for quick growth
and rich future (of a design).

In such a design, SCSI Core would be very small and the task
paths would be very straightforward as shown in the SAS Transport
Stack in the link in my signature, USB or SBP subsystems.

BTW, "modules-appendages" very truly describes the current state
of Linux SCSI and this can be seen from, for example the scsi host
structure, where those "modules-appendages" are "hooked".

	Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
