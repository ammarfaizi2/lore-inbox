Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUG2AkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUG2AkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUG2AhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:37:20 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:8114 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267389AbUG2AfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:35:15 -0400
Date: Thu, 29 Jul 2004 11:30:49 +1000
From: Nathan Scott <nathans@sgi.com>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       L A Walsh <lkml@tlinx.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040729013049.GE800@frodo>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <40EEC9DC.8080501@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EEC9DC.8080501@tlinx.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 09:37:48AM -0700, L A Walsh wrote:
> It's a feature! :-)
> 
> It's been in the code for years to randomly write nulls to some files 

Pfft, nonsense.  The problem relates to an updated inode size
being flushed ahead of the data behind it (hence a size update
can make it out before delayed allocate extents do, and we end
up with a hole beyond the end of file, which reads as zeroes).

> Apparently not easily reproduced, no one has a clue why it does it.  
> Just does. 

No, its actually well known why it behaves this way.
We are looking into ways to address this, and have some
ideas - the trick is fixing it without hurting write
performance - which we will do, its just not trivial.

There are several techiques to reduce the impact of this
behaviour, as others have described (or see the linux-xfs
archives).

cheers.

-- 
Nathan
