Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbUKHVB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUKHVB1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbUKHU7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:59:45 -0500
Received: from jade.aracnet.com ([216.99.193.136]:12189 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261217AbUKHU5w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:57:52 -0500
Date: Mon, 08 Nov 2004 12:57:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Brent Casavant <bcasavan@sgi.com>
cc: Andi Kleen <ak@suse.de>, colpatch@us.ibm.com,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <263890000.1099947448@[10.10.2.4]>
In-Reply-To: <Pine.SGI.4.58.0411081314160.101942@kzerza.americas.sgi.com>
References: <239530000.1099435919@flay><Pine.LNX.4.44.0411030826310.6096-100000@localhost.localdomain><20041103090112.GJ8907@wotan.suse.de><Pine.SGI.4.58.0411031021160.79310@kzerza.americas.sgi.com> <276730000.1099515644@flay> <Pine.SGI.4.58.0411081314160.101942@kzerza.americas.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Matt has volunteered to write the mount option for this, so let's hold
>> off for a couple of days until that's done.
> 
> I had the time to do this myself.  Updated patch attached below.
> 
> Description:
> 
> This patch creates a tmpfs mount option and adds code which causes
> tmpfs allocations to be interleaved across the nodes of a NUMA machine.
> This is useful in situations where a large tmpfs file would otherwise
> consume most of the memory on a single node, forcing tasks running on
> that node to perform off-node allocations for other (i.e. non-tmpfs)
> memory needs.
> 
> Tightly synchronized HPC applications with large (on the order of
> a single node's total RAM) per-task memory requirements are an example
> of a type of application which benefits from this change.  Other
> types of workloads may prefer local tmpfs allocations, thus a mount
> option is provided.
> 
> The new mount option is "interleave=", and defaults to 0.  Any non-zero
> setting turns on interleaving.  Interleaving behavior can be changed
> via a remount operation.

Looks good to me, though I don't really know that area of code very well.
Hopefully Hugh or someone can give it a better review.

Thanks for doing that,

M.

