Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVILLoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVILLoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVILLoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:44:10 -0400
Received: from magic.adaptec.com ([216.52.22.17]:1766 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750755AbVILLoJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:44:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [1/3] Add 4GB DMA32 zone
Date: Mon, 12 Sep 2005 07:44:08 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F01919BC3@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [1/3] Add 4GB DMA32 zone
Thread-Index: AcW3hzAHLkwJVp/xRMyliTpKmG/DkQABcU+g
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Andi Kleen" <ak@suse.de>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
>> Adaptec AACRAID is one offender
> 4GB limit is really common and the oddballs like 
>these have to use the same workarounds (custom bounce buffer in low
GFP_DMA 
>memory) they always did on machines with enough memory.

The 2GB limit is to deal with allocation of hardware command frames
(FIB) and thus only during initialization, all the adapters deliver DMA
to the full address range at 'run time' and the driver does open the
limit up at that point. The reason for this strangeness is the inability
of the Firmware to work around the Intel ATU when doing memcpy, where
the DMA engine had no such limits.

> Also the aacraid is not really an big issue on x86-64
Oh really? I have throngs (a technical term) of customers that would
bear witness otherwise.
> because afaik nobody shipped EM64T or AMD64 machines with these
beasts.
Patently false. The cards with the 2GB limits (2200S) are popular
sellers in the channel, the replacement (2230S) w/o the limit is ramping
though ...

>[Proof of it: the current sources don't seem to handle it, so it cannot
be that bad ;-]

The current sources do handle it, took nearly a year for the patches to
propagate from the scsi-list. Meanwhile I deliver a driver to all the
customers that experienced problems, while I waited ...

Sincerely -- Mark Salyzyn

