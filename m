Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289005AbSAIXUh>; Wed, 9 Jan 2002 18:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289068AbSAIXU0>; Wed, 9 Jan 2002 18:20:26 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13459 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289005AbSAIXUQ>;
	Wed, 9 Jan 2002 18:20:16 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201092320.g09NK1224012@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 9 Jan 2002 15:20:01 -0800 (PST)
Cc: pbadari@us.ibm.com (Badari Pulavarty), linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <E16OReG-0002Zi-00@the-village.bc.nu> from "Alan Cox" at Jan 09, 2002 09:56:44 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Here is a 2.4.17 patch for doing PAGE_SIZE IO on raw devices. Instead 
> > of doing 512 byte buffer heads, the patch does 4K buffer heads. This
> > patch significantly reduced CPU overhead and increased IO throughput
> > in our database benchmark runs. (CPU went from 45% busy to 6% busy).
> 
> Does that work out when the application is still doing 512 byte raw I/O.
> Its fine to fall back to the current performance but at least one very
> large competing database would get quite irate if the fallback made
> 512 byte mode slower or nonfunctional ?
> 

It works as usual for 512 byte IO (few checks in the code).  I have not 
seen any slowness for < 4K IO. Infact, I can change the patch to try 
raw vary only for iosize > PAGE_SIZE.

I tested with 2 large competing databases, both of them seem to benifit 
significantly from this patch. I tested with 4 different Fiber & SCSI
adaptors, they all seem to work fine. (only on i386).

But unfortunately, if the hardware have special alignment restrictions
(as you mentioned), this patch does not work. I don't know if it makes
sense to make this configurable and expect customer/user to enable this
feature if they know about their hardware/driver alignment restrictions.

Thanks,
Badari
