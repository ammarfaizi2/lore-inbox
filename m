Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263113AbUJ2HeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbUJ2HeF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 03:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbUJ2HeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 03:34:04 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:59572 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263113AbUJ2Hd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 03:33:57 -0400
Date: Fri, 29 Oct 2004 17:31:48 +1000
From: Nathan Scott <nathans@sgi.com>
To: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-xfs@oss.gi.com, linux-kernel@vger.kernel.org
Subject: Re: Filesystem performance on 2.4.28-pre3 on hardware RAID5.
Message-ID: <20041029073148.GG1246@frodo>
References: <41817612.2020104@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41817612.2020104@ribosome.natur.cuni.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Fri, Oct 29, 2004 at 12:43:30AM +0200, Martin MOKREJ? wrote:
> "mount -t xfs -o async" unexpectedly kills random seek performance,
> but is still a bit better than with "-o sync". ;) Maybe it has to do
> with the dramatic jump in CPU consumption of this operation,
> as it in both cases it takes about 21-26% instead of usual 3%.
> Why? Isn't actually async default mode?

Thats odd.  Actually, I'm not sure what the "async" option is meant
to do, it isn't seen by the fs afaict (XFS isn't looking for it)... 
we also use the generic_file_llseek code in XFS ... so we're not
doing anything special there either -- some profiling data showing
where that CPU time is spent would be insightful.

> Sequential create /Create
> Random create /Create
> XFS             60-120 ms

You may get better results using a version 2 log (mkfs option)
with large in-core log buffers (mount option) for these (which
mkfs version are you using atm?)

cheers.

-- 
Nathan
