Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbULPLTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbULPLTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 06:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbULPLTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 06:19:52 -0500
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:17026 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261480AbULPLTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 06:19:49 -0500
Message-ID: <41C16D8D.7020702@umich.edu>
Date: Thu, 16 Dec 2004 06:12:13 -0500
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <werner@almesberger.net>
CC: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [RFC] Generalized prio_tree, revisited
References: <20041216053118.M1229@almesberger.net>
In-Reply-To: <20041216053118.M1229@almesberger.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> did you have a chance to look at the prio_tree generalization ?

I admit I haven't gone through the patch carefully yet. Overall
it looks good except for a problem which bothers me. The "raw"
prio_tree can only handle unique intervals, i.e., we cannot
insert two intervals with the same indices. Check vm_set.head
and vma_prio_tree_* functions to see how multiple vmas with
identical indices are handled.

> There are currently no in-tree users of the generalized prio_tree,
> but an example of one can be found in the elevator code of ABISS
> (abiss.sourceforge.net), where it's used to detect overlapping
> requests, which in turn is needed to improve barrier handling in
> the elevator. 

Maybe in your case you don't have to worry about storing multiple
identical intervals. However, if we are generalizing prio_tree then
we have to consider that, I guess. This is similar to map and multi_map
in C++. I _guess_ in prio_tree case we will be using the multi_
variant more often. So, I was thinking something like this:

struct raw_prio_tree_node {}
/* same as in your patch */
struct unique_prio_tree_node {}
/* same as prio_tree_node in your patch */
struct prio_tree_node {}
/* somthing similar to shared in vm_area_struct */

> Jens has also indicated interest in putting overlap
> handling into the general block IO layer.

I wish we could have a patch using the generlized prio_tree when
we propose to merge the generalized prio_tree code.

> Are there any standard benchmarks I could run to show how/if this
> affects VMA performance ? I'd be surprised if there was much of a
> change, but you never know.

I don't think the performance drop will be measurable.

Thanks,
Rajesh
