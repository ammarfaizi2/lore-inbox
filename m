Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030611AbWBHUg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030611AbWBHUg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030613AbWBHUg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:36:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:16567 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030612AbWBHUg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:36:58 -0500
Date: Wed, 8 Feb 2006 12:36:51 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
In-Reply-To: <20060208122227.3379643e.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0602081228260.4335@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
 <Pine.LNX.4.62.0602081037240.3590@schroedinger.engr.sgi.com>
 <20060208105714.15bb4bb2.pj@sgi.com> <200602082005.12657.ak@suse.de>
 <20060208122227.3379643e.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Paul Jackson wrote:

> The new logic would be -- only kill tasks that are constrained to
> the same or a subset of the same nodes as the current task.

If a task has restricted its memory allocation to one node and does 
excessive allocations then that process needs to die not other processes 
that are harmlessly running on the node and that may not be allocating 
memory at the time.

> At the same time, a typical bootcpuset would have oom killer behaviour
> resembling what people have become accustomed to.

People are accustomed of having random processes killed? <shudder>

> If we are going to neuter or eliminate the oom killer, it seems like
> we should do it across the board, not just on numa boxes using
> some form of memory constraint (mempolicy or cpuset).

We are terminating processes perform restricted allocations. Restricted 
allocations are only possible on NUMA boxes so the phrase "numa boxes 
using some form of memory constraint" is a tautology. OOM killing makes 
sense for global allocations if the system is really tight on memory and 
survival is the main goal even if he have to cannibalize processes. 
However, cannibalism is still a taboo.

