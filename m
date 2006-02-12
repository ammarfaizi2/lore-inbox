Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWBLS53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWBLS53 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 13:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWBLS53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 13:57:29 -0500
Received: from silver.veritas.com ([143.127.12.111]:14396 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750831AbWBLS52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 13:57:28 -0500
Date: Sun, 12 Feb 2006 18:57:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ryan Richter <ryan@tau.solarneutrino.net>, Andi Kleen <ak@suse.de>
cc: Brian King <brking@us.ibm.com>, "David S. Miller" <davem@davemloft.net>,
       James.Bottomley@steeleye.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
In-Reply-To: <20060211223810.GA12064@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.61.0602121838050.15101@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com>
 <43E7613B.5060706@us.ibm.com> <Pine.LNX.4.61.0602061621450.3560@goblin.wat.veritas.com>
 <200602062211.29993.ak@suse.de> <Pine.LNX.4.61.0602062154430.3652@goblin.wat.veritas.com>
 <20060211223810.GA12064@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Feb 2006 18:57:27.0661 (UTC) FILETIME=[2B0961D0:01C63006]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2006, Ryan Richter wrote:
> On Mon, Feb 06, 2006 at 10:11:09PM +0000, Hugh Dickins wrote:
> > Below is, I think, the 2.6.15 equivalent of the patch Andi posted.
> > Ryan cannot effectively test Andi's patch on 2.6.16-rc because Mike
> > Christie's scsi_execute_async changes have serendipitously fixed
> > the st instance.  Ryan, would you be able to test the patch below
> > on 2.6.15 without my st.c,st.h patch?
> 
> This patch survived 6 runs, and I'll keep running it.

Many thanks for all your efforts on this, Ryan: for reporting the bug,
for your patience in waiting for a diagnosis and a fix, and for
uncomplainingly testing so many workarounds and fixes.

I'll say a mean thing, but please take it as the compliment it's
intended to be: I hope you find lots more bugs, because you're the
rare someone we can depend on to see them through to the final fix!
Nah, you've had your share, you deserve a break.

Andi, do you feel this x86_64-gart-dma-merge.patch has now had enough
testing?  I've read through your gart_map_sg() more carefully now, and
the patch looks right to me (it seems to be a misunderstanding that the
lines you're now deleting were ever in).  I've also read through, less
carefully, the sg coalescing routines in other architectures, and found
no such offending code in them.  Brian did the same earlier and found
nothing.

So I'd like to believe that your x86_64-gart-dma-merge.patch is the
final answer to this issue, and see it go forward into 2.6.16-rc -
if you feel it's ready now.  Then we can just throw away those driver
patches I posted a week ago (including the "ipr" one of this thread).

Thanks,
Hugh
