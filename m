Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271223AbTHLXYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271224AbTHLXYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 19:24:22 -0400
Received: from [202.20.92.128] ([202.20.92.128]:14992 "EHLO quattro.co.nz")
	by vger.kernel.org with ESMTP id S271223AbTHLXYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 19:24:21 -0400
Message-ID: <012f01c36128$dfaaba80$0401a8c0@SIMON>
From: "Simon Garner" <sgarner@expio.co.nz>
To: "Andi Kleen" <ak@colin2.muc.de>
Cc: <linux-kernel@vger.kernel.org>
References: <gC1o.2gU.5@gated-at.bofh.it> <m3k79t7ykk.fsf@averell.firstfloor.org> <028101c35aea$d2753690$0401a8c0@SIMON> <20030805134241.GA63394@colin2.muc.de> <003e01c35f91$08227b40$0401a8c0@SIMON> <20030810225625.GA41619@colin2.muc.de>
Subject: Re: MSI K8D-Master - GART error 3
Date: Wed, 13 Aug 2003 11:22:38 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 11, 2003 10:56 AM [GMT+1200=NZT],
Andi Kleen <ak@colin2.muc.de> wrote:

> On Mon, Aug 11, 2003 at 10:43:57AM +1200, Simon Garner wrote:
>> These suggest it's just reporting ECC corrections. Why would it do
>> this
>
> Yep. You have faulty DIMMs, consider replacing them.
>

Well I found that a little hard to stomach (since there's four DIMMs -
surely they couldn't all be faulty - and I had already been through a
whole other complete set with the same results, when the supplier sent
the wrong speed modules), but now that I knew the errors were
memory-related I did some more experimenting.

(Here is the memory population chart from the motherboard manual to help
make sense of this:
http://www.expio.co.nz/~sgarner/terra/msi9131memorypop.gif)

First I found that if I disabled ECC in the BIOS then the system
wouldn't even POST. But if I rearranged the modules so that they were in
single channel operation (using only three DIMMs in slots 2,4,6) then
the system would boot and I got no errors in SuSE (even after reenabling
ECC).

Then I tried using a different memory population layout, using all four
DIMMs as dual channel w/ ECC in slots 3,4,5,6 where I had been using
1,2,5,6. The system booted and again I got no errors in SuSE.

"That's strange," thought I, so I tried putting the memory back as it
was, in slots 1,2,5,6, with ECC enabled. Booted the system and still no
errors in SuSE.

So I'm not sure what I did exactly but the system is now running fine
and the ECC errors are gone. I'm still using the same DIMMs - the only
thing that may have changed is the DIMMs may be arranged differently
among the slots. I have tried swapping them around though and I still
can't get the ECC errors back. But that's fine because I didn't
particularly want the errors anyway! :)

-Simon

PS: Under the Northbridge/ECC configuration in the BIOS, the motherboard
has options for DRAM, L2 and L1 cache "BG Scrub" which are selected as
times from 40ns through to some microseconds. There are also options for
"DRAM Scrub REDIRECT" and "ECC Chip Kill". The motherboard manual offers
no advice as to the preferred values for these settings or what they do.
Can anyone suggest good values for these? I currently have them
disabled.

