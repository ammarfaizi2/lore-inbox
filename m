Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266466AbUGPAPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUGPAPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 20:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266472AbUGPAPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 20:15:55 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:8590 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266466AbUGPAPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 20:15:54 -0400
Date: Thu, 15 Jul 2004 17:14:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, John Hawkes <hawkes@sgi.com>
Subject: Re: [PATCH] reduce inter-node balancing frequency
Message-ID: <46970000.1089936880@flay>
In-Reply-To: <200407151829.20069.jbarnes@engr.sgi.com>
References: <200407151829.20069.jbarnes@engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nick, we've had this patch floating around for awhile now and I'm wondering 
> what you think.  It's needed to boot systems with lots (e.g. 256) nodes, but 
> could probably be done another way.  Do you think we should create a 
> scheduler domain for every 64 nodes or something?  

I think that'd make a lot of sense ...

> Any other NUMA folks have thoughts about these values?

Yeah, change them in arch specific code, not in the global stuff ;-)
But seeing as they're dependant (for you) on machine size, as well as
arch type, you probably need to do something cleverer in arch_init_sched_domain

But the big bugaboo is arch-specific vs general ... we need to break 
opteron vs i386 vs ia64 out from each other ... they all need different
coefficients.

If you were going to be really fancy, we could do it in common code off
the topology stuff ... but for now, I think it's easier to just set 'em
per arch ...

M.


