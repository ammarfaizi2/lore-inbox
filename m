Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUC3Vmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbUC3Vmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:42:49 -0500
Received: from fmr05.intel.com ([134.134.136.6]:8126 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S261369AbUC3VmF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:42:05 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Date: Tue, 30 Mar 2004 13:40:23 -0800
Message-ID: <7F740D512C7C1046AB53446D3720017301226482@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Thread-Index: AcQSRuLJRmOAInKpT2GffMxlCepNxAAM6y/gAQgP0yA=
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>, <piggin@cyberone.com.au>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <kernel@kolivas.org>,
       <rusty@rustcorp.com.au>, <ricklind@us.ibm.com>, <anton@samba.org>,
       <lse-tech@lists.sourceforge.net>, <mbligh@aracnet.com>,
       "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 30 Mar 2004 21:40:24.0326 (UTC) FILETIME=[9BD51260:01C4169F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem we observed was that the performance was lower with a large
number of threads (># of CPUs, such as 2x) with SPECjbb. With fewer
threads, the sched-domain scheduler performed slightly better. What we
found was that the sched-domain changes balance_interval (between
min_interaval and max_interval) reflecting success/failure of load
balancing, whereas the base scheduler does not. That value determines
how often we do inter and intra node baloancing, and we see the same
performance if we use the same hard code value as the base scheduler
does. 

Nick,
That algorithm sounds reasonable to me, but how did you pick up
min_interval and max_interval, especially for NUMA? 

Jun

>-----Original Message-----
>From: lse-tech-admin@lists.sourceforge.net [mailto:lse-tech-
>admin@lists.sourceforge.net] On Behalf Of Nakajima, Jun
>Sent: Thursday, March 25, 2004 7:15 AM
>To: Andi Kleen; Ingo Molnar
>Cc: piggin@cyberone.com.au; linux-kernel@vger.kernel.org;
akpm@osdl.org;
>kernel@kolivas.org; rusty@rustcorp.com.au; ricklind@us.ibm.com;
>anton@samba.org; lse-tech@lists.sourceforge.net; mbligh@aracnet.com
>Subject: RE: [Lse-tech] [patch] sched-domain cleanups,
sched-2.6.5-rc2-mm2-
>A3
>
>We have found some performance regressions (e.g. SPECjbb) with the
>scheduler on a large IA-64 NUMA machine, and we are debugging it. On
SMP
>machines, we haven't seen performance regressions.
>
>Jun
>
>>-----Original Message-----
>>From: Andi Kleen [mailto:ak@suse.de]
>>Sent: Wednesday, March 24, 2004 8:56 PM
>>To: Ingo Molnar
>>Cc: piggin@cyberone.com.au; linux-kernel@vger.kernel.org;
>akpm@osdl.org;
>>kernel@kolivas.org; rusty@rustcorp.com.au; Nakajima, Jun;
>>ricklind@us.ibm.com; anton@samba.org; lse-tech@lists.sourceforge.net;
>>mbligh@aracnet.com
>>Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
>sched-2.6.5-rc2-mm2-
>>A3
>>
>>On Thu, 25 Mar 2004 09:28:09 +0100
>>Ingo Molnar <mingo@elte.hu> wrote:
>>
>>> i've reviewed the sched-domains balancing patches for upstream
>inclusion
>>> and they look mostly fine.
>>
>>The main problem it has is that it performs quite badly on Opteron
NUMA
>>e.g. in the OpenMP STREAM test (much worse than the normal scheduler)
>>
>>-Andi
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: IBM Linux Tutorials
>Free Linux tutorial presented by Daniel Robbins, President and CEO of
>GenToo technologies. Learn everything from fundamentals to system
>administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=ick
>_______________________________________________
>Lse-tech mailing list
>Lse-tech@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/lse-tech
