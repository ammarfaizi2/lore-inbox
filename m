Return-Path: <linux-kernel-owner+w=401wt.eu-S1750973AbXAKBYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbXAKBYm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbXAKBYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:24:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39106 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750973AbXAKBYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:24:41 -0500
Date: Thu, 11 Jan 2007 12:24:04 +1100
From: David Chinner <dgc@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Chinner <dgc@sgi.com>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
Message-ID: <20070111012404.GW33919298@melbourne.sgi.com>
References: <20070110223731.GC44411608@melbourne.sgi.com> <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com> <20070110230855.GF44411608@melbourne.sgi.com> <45A57333.6060904@yahoo.com.au> <20070111003158.GT33919298@melbourne.sgi.com> <45A58DFA.8050304@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A58DFA.8050304@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 12:08:10PM +1100, Nick Piggin wrote:
> David Chinner wrote:
> >Sure, but that doesn't really show the how erratic the per-filesystem
> >throughput is because the test I'm running is PCI-X bus limited in
> >it's throughput at about 750MB/s. Each dm device is capable of about
> >340MB/s write, so when one slows down, the others will typically
> >speed up.
> 
> But you do also get aggregate throughput drops? (ie. 2.6.20-rc3-worse)

Yes - you can see that from the vmstat output I sent.

At 500GB into the write of each file (about 60% of the disks filled)
the per fs write rate should be around 220MB/s, so aggregate should
be around 650MB/s. That's what Im seeing with 2.6.18 and 2.6.20-rc3
with a tweaked dirty_ratio. Without the dirty_ratio tweak, you see
what is in 2.6.20-rc3-worse.

e.g. I just changed dirty ratio from 10 to 40 and I've gone from
consistent 210-215MB/s per filesystm (~630-650MB/s aggregate) to
ranging over 110-200MB/s per fielsystem and aggregates of ~450-600MB/s.
I changed dirty_ratio back to 10, and within 15 seconds we are back
to consistent 210MB/s per filesystem and 630-650MB/s write.

> >So, what I've attached is three files which have both
> >'vmstat 5' output and 'iostat 5 |grep dm-' output in them.
> 
> Ahh, sorry to be unclear, I meant:
> 
>   cat /proc/vmstat > pre
>   run_test
>   cat /proc/vmstat > post

Ok, I'll get back to you on that one - even at 600+MB/s, writing 5TB
of data takes some time....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
