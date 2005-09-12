Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVILSmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVILSmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVILSmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:42:55 -0400
Received: from ns.suse.de ([195.135.220.2]:28373 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932122AbVILSmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:42:54 -0400
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [2/3] {PREFIX:-x86_64}: Convert mempolicies to nodemask_t
Date: Mon, 12 Sep 2005 20:42:57 +0200
User-Agent: KMail/1.8
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <4322CA79.mailAO51VX9XB@suse.de> <20050912022615.0140cc64.pj@sgi.com>
In-Reply-To: <20050912022615.0140cc64.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509122042.57328.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 11:26, Paul Jackson wrote:
> Andi wrote:
> > Convert mempolicies to nodemask_t


Thanks for the review.


>  1) Can the include of 'linux/bitmap.h' be removed from the file
>     linux/include/linux/mempolicy.h?

Done.

>  2) /* AK: shouldn't this error out instead? */
I'll leave this to you.


>  3) Either this current patch of Andi's, or the patch considered for (2)
>     above should also convert whatever kernel/cpuset.c call the mempolicy.c
>     code is making from bitmaps to nodemasks, rather than convert to
> bitmaps across the boundary:
>
> 	cpuset_restrict_to_mems_allowed(nodes_addr(*nodes));
Leaving this to you too

(BTW I have one patch for cpusets pending to improve the fast path,
need to test it a little bit more before sending off though) 

>
>  4) Should the following line:
>
> 	+	PDprintk("setting mode %d nodes[0] %lx\n", mode, nodes_addr(nodes)[0]);
>
>     instead be:
>
> 	+	PDprintk("setting mode %d nodes[0] %lx\n", mode, nodes_addr(*nodes)[0]);
Fixed.

>
>   5) If anyone ever (even for debugging) adds something to the nodemask_t
Fixed.


>  6) How come I don't see changes for the 'compat_sys_get_mempolicy()'
> routine?

Because it doesn't work with nodemask_ts, but only with variable length
user buffers.

>
>  7) Do -not- add one for the next node in interleave_nodes():
Fixed (+ 8) 

Thanks,
-Andi
