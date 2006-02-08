Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbWBHSmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbWBHSmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWBHSmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:42:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53197 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030445AbWBHSmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:42:31 -0500
Date: Wed, 8 Feb 2006 10:42:19 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
In-Reply-To: <20060208103323.7ba3709e.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0602081037240.3590@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
 <20060208103323.7ba3709e.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Paul Jackson wrote:

> What your patch is doing affectively disables the oom_killer for
> big numa systems, rather than having it operate within the set
> of tasks using overlapping resources.

No it only disables the oom killer for constrained allocations. If the big 
numa system uses a cpuset that limits the number of nodes then those 
allocations occurring within these cpusets are constrained allocations 
which will then lead to the killing of the application that allocated too 
much memory. I think this is much more consistent than trying to tame the 
OOM killer enough to stay in a certain cpuset.

F.e. a sysadmin may mistakenly start a process allocating too much memory
in a cpuset. The OOM killer will then start randomly shooting other 
processes one of which may be a critical process.. Ouch.

> Do we need this more radical constraint on the oom_killer?

Yes. One can make the OOM killer go postal if one specifies a memory 
policy that contains only one node and then allocates enough memory.

Actually a good Denial of service attack than can be used with cpusets 
and memory policies.
