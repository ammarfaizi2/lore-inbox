Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWECUtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWECUtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWECUtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:49:23 -0400
Received: from mga03.intel.com ([143.182.124.21]:58996 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751056AbWECUtW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:49:22 -0400
X-IronPort-AV: i="4.05,85,1146466800"; 
   d="scan'208"; a="31171282:sNHT2291882761"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Wed, 3 May 2006 13:49:12 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392DCAE35C@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZu74/dZ+QIdUJMQYuImXmYtlzGOQAAeudA
From: "Gross, Mark" <mark.gross@intel.com>
To: "Tim Small" <tim@buttersideup.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 03 May 2006 20:49:17.0972 (UTC) FILETIME=[0BBD9540:01C66EF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Tim Small [mailto:tim@buttersideup.com]
>Sent: Wednesday, May 03, 2006 1:25 PM
>To: Alan Cox
>Cc: Ong, Soo Keong; Gross, Mark; bluesmoke-devel@lists.sourceforge.net;
>LKML; Carbonari, Steven; Wang, Zhenyu Z
>Subject: Re: Problems with EDAC coexisting with BIOS
>
>Alan Cox wrote:
>
>>On Llu, 2006-04-24 at 22:15 +0800, Ong, Soo Keong wrote:
>>
>>
>>>To me, periodical is not a good design for error handling, it wastes
>>>transaction bandwidth that should be used for other more productive
>>>purposes.
>>>
>>>
>>
>>The periodical choice is mostly down to the brain damaged choice of
NMI
>>as the viable alternative, which is as good as 'not usable'
>>
>>
>Hi,
>
>As I believe that the majority of the bluesmoke/EDAC developers are
>(were) operating under the assumption that it would be possible to do
>something with NMI-signalled errors, I was wondering what the problems
>with using NMI-signalled ECC errors were?

Soo Keong or Steve, can you answer this one?

>
>Are there some systems states in which an incoming NMI throws a spanner
>in to the works in an unrecoverable way?  If this is the case, is it so
>on all x86/x86-64 systems, or just a subset, and is there no way to
>implement some sort of top half / bottom half style NMI handler
>cleanly?  As I am certainly not an x86 architecture expert, I would
>appreciate any input from the resident gurus ;o).

I don't think NMI's are so much the problem as those blasted SMI's.  And
SMI's are not for sharing :(

These problems are BIOS specific, Your Mileage Will Vary from one bios
to the next.

>
>Quickly returning to the original problem - I know this isn't a proper
>API by any stretch of the imagination, and would require changes to
>existing BIOSs, but the EDAC module could reprogram the chipset
>error-signalling registers, so that an ECC error no longer triggers an
>SMI.  The BIOS SMI handler could then read the signalling registers,
and
>leave the ECC registers well alone if ECC errors are not set to
generate
>an SMI.

It's not the SMI from ECC events that are the problem.  It's the BIOS
assuming no one else would want to use those registers on Dev0:Fun1, and
the fact that you still end up with a race between the OS and the BIOS
SMI to handle the events.

>
>Cheers,
>
>Tim.
