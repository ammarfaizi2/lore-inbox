Return-Path: <linux-kernel-owner+w=401wt.eu-S1751314AbXAQEhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbXAQEhJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 23:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbXAQEhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 23:37:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40640 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751314AbXAQEhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 23:37:06 -0500
Date: Tue, 16 Jan 2007 20:36:22 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: clameter@sgi.com, akpm@osdl.org, menage@google.com,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, dgc@sgi.com
Subject: Re: [RFC 5/8] Make writeout during reclaim cpuset aware
Message-Id: <20070116203622.7f1b4e87.pj@sgi.com>
In-Reply-To: <200701171528.16854.ak@suse.de>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	<200701170907.14670.ak@suse.de>
	<20070116202056.075c4c03.pj@sgi.com>
	<200701171528.16854.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With a per node dirty limit ...

What would this mean?

Lets say we have a simple machine with 4 nodes, cpusets disabled.

Lets say all tasks are allowed to use all nodes, no set_mempolicy
either.

If a task happens to fill up 80% of one node with dirty pages, but
we have no dirty pages yet on other nodes, and we have a dirty ratio
of 40%, then do we throttle that task's writes?

I am surprised you are asking for this, Andi.  I would have thought
that on no-cpuset systems, the system wide throttling served your
needs fine.  If not, then I can only guess that is because NUMA
mempolicy constraints on allowed nodes are causing the same dirty page
problems as cpuset constrained systems -- is that your concern?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
