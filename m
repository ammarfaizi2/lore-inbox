Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUHFD0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUHFD0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUHFD0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:26:39 -0400
Received: from jade.spiritone.com ([216.99.193.136]:17811 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266259AbUHFD0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:26:19 -0400
Date: Thu, 05 Aug 2004 20:24:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de,
       lse-tech@lists.sourceforge.net, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <247790000.1091762644@[10.10.2.4]>
In-Reply-To: <20040805190500.3c8fb361.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><20040805101038.3740.52850.89920@sam.engr.sgi.com><256150000.1091739330@flay> <20040805190500.3c8fb361.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> is the point to add back virtualized memory and 
>> CPU numbering sets specific to each process or group of them,
>> a la cpumemsets thing you were posting a year or two ago?
> 
> To answer the easy question first, no.  No virtual numbering anymore. We
> might do some virtualizing in user library code, but so far as this
> patch and the kernel are aware, cpu number 17 is cpu number 17, all the
> time, using the same cpu and node numberings as used in the other kernel
> API's (setaffinity, mbind and set_mempolicy) and in the kernel cpumasks
> and nodemasks.

OK, good ;-) I don't think the kernel should have to deal with that stuff.
Sorry, it's just a little difficult to dive into a large patch without 
a higher level idea what it's trying to do (which after your last email, 
I think I have a much better grasp on).
 
...

> The existing cpu and memory placement facilities, added in 2.6,
> set_schedaffinity (for cpus) and mbind/set_mempolicy (for memory) are
> just the right thing for an individual task to manage in detail its
> placement across the resources available to it (the online cpus and
> nodes if CONFIG_CPUSET is disabled, or within the cpuset if cpusets
> are enabled).

I agree that the current mechanisms are not wholly sufficient - the
most obvious failing being that whilst you can bind a process to a
resource, there's very little support for making a resource exclusively
available to a process or set thereof.
 
> But they do not provide the named hierarchy with kernel enforced
> permissions and resource support required to sanely manage the
> largest multi-use systems.

Right ... but I'm kind of shocked by the size of the patch to fix what
seems like a fairly simple problem. The other thing that seems to glare
at me is the overlap between what you have here and PAGG/CKRM. Does
either cpusets depend on PAGG/CKRM or vice versa? They seem to have 
similar goals, and it'd be strange to have two independant mechanisms.

> Three additional ways to approach this patch:
> 
>  1) The first file in the patch, Documentation/cpusets.txt,
>     describes this facility, and its purpose.
> 
>  2) Look at the hooks in the rest of the kernel.  I have spent much
>     time minimizing these hooks, so that they are few in number,
>     placed as best I could in low maintenace code in the kernel,
>     and vanish if CONFIG_CPUSETS is disabled.  But in addition
>     to evaluating the risk and impact of the hooks, you can get
>     a further sense of how cpusets works from these hooks.
>     These hooks are listed in Documentation/cpusets.txt.
> 
>  3) Look at the include/linux/cpusets.h header file.  It shows
>     the tiny interface with the rest of the kernel, which
>     pretty much evaporates if CONFIG_CPUSET is disabled.

Thanks ... that'll help me. I'll try to look through it in some more
detail.

M.
