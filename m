Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVFLAXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVFLAXR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 20:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVFLAXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 20:23:17 -0400
Received: from dvhart.com ([64.146.134.43]:50089 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261861AbVFLAXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 20:23:14 -0400
Date: Sat, 11 Jun 2005 17:23:18 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <675380000.1118535797@[10.10.2.4]>
In-Reply-To: <200506120947.13709.kernel@kolivas.org>
References: <20050607170853.3f81007a.akpm@osdl.org> <200506120820.05627.kernel@kolivas.org> <674540000.1118532454@[10.10.2.4]> <200506120947.13709.kernel@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Con Kolivas <kernel@kolivas.org> wrote (on Sunday, June 12, 2005 09:47:08 +1000):

> On Sun, 12 Jun 2005 09:27, Martin J. Bligh wrote:
>> >> not sure what the benefits of the patch are, 
> 
> I should have answered this. Since we moved to one runqueue per cpu with the 
> current scheduler, 'nice' levels basically fall apart on SMP. Balancing tends 
> to group together all the wrong tasks to have any meaningful 'nice' support 
> where often on a 2 cpu machine if we run 4 tasks, 2 nice 0 and 2 nice 19 we 
> end up with:
> 
> cpu 1: nice 19 + nice 19
> cpu 2: nice 0 + nice 0
> 
> which means each nice 19 task gets half a cpu and each nice 0 task gets half a 
> cpu which is lousy fairness. 
> 
> The smp nice patches should end up with
> cpu 1: nice 0 + nice 19
> cpu 2: nice 0 + nice 19
> 
> so that the nice 0 tasks get 95% of a cpu and nice 19 tasks get 5% of a cpu.
> 
> The patches should balance things as fairly as possible according to nice 
> levels across cpus. As you can see this is clearly a bug in behaviour and has 
> been a showstopper for many trying to move from 2.4.

Oh, right. that makes a lot of sense ... maybe just let it have an error
factor when migrating cross numa nodes (ie not be as strict)? Not sure 
that's really the problem, as I doubt anything in my test is actually 
niced anyway (assuming you're meaning static prio, not dynamic). In that
case, your changes should have no effect, right (from explanation, not
looking at the code ;-))

M.

