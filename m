Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbVLBXnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbVLBXnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 18:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbVLBXnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 18:43:37 -0500
Received: from serv01.siteground.net ([70.85.91.68]:32142 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751047AbVLBXng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 18:43:36 -0500
Date: Fri, 2 Dec 2005 15:43:30 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, shai@scalex86.org
Subject: Re: [discuss] Re: [patch 1/3] x86_64: Node local PDA -- early cpu_to_node
Message-ID: <20051202234330.GA7426@localhost.localdomain>
References: <20051202081028.GA5312@localhost.localdomain> <20051202114349.GL997@wotan.suse.de> <20051202225156.GC3727@localhost.localdomain> <20051202230206.GF9766@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202230206.GF9766@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 12:02:06AM +0100, Andi Kleen wrote:
> On Fri, Dec 02, 2005 at 02:51:56PM -0800, Ravikiran G Thirumalai wrote:
> > On Fri, Dec 02, 2005 at 12:43:49PM +0100, Andi Kleen wrote:
> > > And are you sure it will work with k8topology.c. Doesn't look like
> > > that to me.
> > 
> > I don't have a K8 box yet :(, so I cannot confirm either ways.  
> > But I thought newer opterons need to use  ACPI_NUMA instead...
> 
> k8topology still needs to work - e.g. for LinuxBios and users which use
> acpi=off and as a fallback for broken SRAT tables. You can't break it right now.
>

I don't think this breaks K8 per-se, because x86_cpu_to_apicid[] is setup if
acpi is compiled in and k8topology sets up apicid_to_node[] at
k8_scan_nodes. That said, I don't know for sure as I don't have a K8 yet. If
someone can test this patch on a opteron, compiled with
ACPI_NUMA as well as K8, (but which falls back to K8 at boot), 
it will be helpful.
 
> > 
> > Even if K8 detection is used, cpu_pda will have memory allocated from node0
> > which is not different from the current state.  So this patch helps Opterons
> > and EM64t boxes which use ACPI_NUMA, right?  Also the newer opteron boxes
> > and em64t NUMA boxes can now get node local memory for static per-cpu areas.
> 
> Hmm good point. However i would prefer if there was no performance regression
> between the two options. However i guess it can be kept like this now.
> Just make sure to comment it well.

Sure.

Thanks,
Kiran
