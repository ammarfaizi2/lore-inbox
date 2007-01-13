Return-Path: <linux-kernel-owner+w=401wt.eu-S1161187AbXAMBAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbXAMBAz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 20:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbXAMBAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 20:00:55 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:49218 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161187AbXAMBAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 20:00:55 -0500
Date: Fri, 12 Jan 2007 17:00:39 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>, a.p.zijlstra@chello.nl
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
Message-ID: <20070113010039.GA8465@localhost.localdomain>
References: <20070112160104.GA5766@localhost.localdomain> <Pine.LNX.4.64.0701121137430.2306@schroedinger.engr.sgi.com> <20070112214021.GA4300@localhost.localdomain> <Pine.LNX.4.64.0701121341320.3087@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701121341320.3087@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 01:45:43PM -0800, Christoph Lameter wrote:
> On Fri, 12 Jan 2007, Ravikiran G Thirumalai wrote:
> 
> Moreover mostatomic operations are to remote memory which is also 
> increasing the problem by making the atomic ops take longer. Typically 
> mature NUMA system have implemented hardware provisions that can deal with 
> such high degrees of contention. If this is simply a SMP system that was
> turned into a NUMA box then this is a new hardware scenario for the 
> engineers.

This is using HT as all AMD systems do, but this is one of the 8
socket systems.  

I ran the same test on a 2 node Tyan AMD box, and did not notice the
atrocious spin times. It would be interesting to see how a 4 socket HT box
would fare. Unfortunately, I do not have access to one. If someone has access
to such a box, I can provide the test case and instrumentation patches.

It could very well be the hardware limitation in this case, which means, all
the more reason to enable interrupts with spin locks while spinning. But is
lru_lock an issue is another question.

Thanks,
Kiran
 
