Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUC3WRy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUC3WRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:17:54 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:41723 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S261433AbUC3WR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:17:28 -0500
From: Andrew Theurer <habanero@us.ibm.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>, "Ingo Molnar" <mingo@elte.hu>,
       <piggin@cyberone.com.au>
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Date: Tue, 30 Mar 2004 16:15:50 -0600
User-Agent: KMail/1.5
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <kernel@kolivas.org>,
       <rusty@rustcorp.com.au>, <ricklind@us.ibm.com>, <anton@samba.org>,
       <lse-tech@lists.sourceforge.net>, <mbligh@aracnet.com>,
       "Andi Kleen" <ak@suse.de>
References: <7F740D512C7C1046AB53446D3720017301226482@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D3720017301226482@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403301615.50983.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any idea what the context switch rate was on the large wh runs?  Any 
sched_yield type locking can put a lot of demand on the scheduler, and with a 
lower balance frequency it can make the problem worse, one side affect being 
idle time.  Do you have increased idle time with the lower throughput?

Also, what JVM are you using?

On Tuesday 30 March 2004 15:40, Nakajima, Jun wrote:
> The problem we observed was that the performance was lower with a large
> number of threads (># of CPUs, such as 2x) with SPECjbb. With fewer
> threads, the sched-domain scheduler performed slightly better. What we
> found was that the sched-domain changes balance_interval (between
> min_interaval and max_interval) reflecting success/failure of load
> balancing, whereas the base scheduler does not. That value determines
> how often we do inter and intra node baloancing, and we see the same
> performance if we use the same hard code value as the base scheduler
> does.
>
> Nick,
> That algorithm sounds reasonable to me, but how did you pick up
> min_interval and max_interval, especially for NUMA?
>
> Jun
>
> >-----Original Message-----
>
> From: lse-tech-admin@lists.sourceforge.net [mailto:lse-tech-
>
> >admin@lists.sourceforge.net] On Behalf Of Nakajima, Jun
> >Sent: Thursday, March 25, 2004 7:15 AM
> >To: Andi Kleen; Ingo Molnar
> >Cc: piggin@cyberone.com.au; linux-kernel@vger.kernel.org;
>
> akpm@osdl.org;
>
> >kernel@kolivas.org; rusty@rustcorp.com.au; ricklind@us.ibm.com;
> >anton@samba.org; lse-tech@lists.sourceforge.net; mbligh@aracnet.com
> >Subject: RE: [Lse-tech] [patch] sched-domain cleanups,
>
> sched-2.6.5-rc2-mm2-
>
> >A3
> >
> >We have found some performance regressions (e.g. SPECjbb) with the
> >scheduler on a large IA-64 NUMA machine, and we are debugging it. On
>
> SMP
>
> >machines, we haven't seen performance regressions.
> >
> >Jun
> >
> >>-----Original Message-----
> >>From: Andi Kleen [mailto:ak@suse.de]
> >>Sent: Wednesday, March 24, 2004 8:56 PM
> >>To: Ingo Molnar
> >>Cc: piggin@cyberone.com.au; linux-kernel@vger.kernel.org;
> >
> >akpm@osdl.org;
> >
> >>kernel@kolivas.org; rusty@rustcorp.com.au; Nakajima, Jun;
> >>ricklind@us.ibm.com; anton@samba.org; lse-tech@lists.sourceforge.net;
> >>mbligh@aracnet.com
> >>Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
> >
> >sched-2.6.5-rc2-mm2-
> >
> >>A3
> >>
> >>On Thu, 25 Mar 2004 09:28:09 +0100
> >>
> >>Ingo Molnar <mingo@elte.hu> wrote:
> >>> i've reviewed the sched-domains balancing patches for upstream
> >
> >inclusion
> >
> >>> and they look mostly fine.
> >>
> >>The main problem it has is that it performs quite badly on Opteron
>
> NUMA
>
> >>e.g. in the OpenMP STREAM test (much worse than the normal scheduler)
> >>
> >>-Andi
> >
> >-------------------------------------------------------
> >This SF.Net email is sponsored by: IBM Linux Tutorials
> >Free Linux tutorial presented by Daniel Robbins, President and CEO of
> >GenToo technologies. Learn everything from fundamentals to system
> >administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=ick
> >_______________________________________________
> >Lse-tech mailing list
> >Lse-tech@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/lse-tech
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=Click
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

