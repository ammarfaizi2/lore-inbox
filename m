Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUKWVa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUKWVa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUKWV3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 16:29:09 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:11172 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261292AbUKWV2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 16:28:24 -0500
Date: Wed, 24 Nov 2004 08:27:36 +1100
From: Nathan Scott <nathans@sgi.com>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jan De Luyck <lkml@kcore.org>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [2.6.10-rc2] XFS filesystem corruption
Message-ID: <20041124082736.E6205230@wobbly.melbourne.sgi.com>
References: <200411221530.30325.lkml@kcore.org> <20041122155106.GG2714@holomorphy.com> <41A30D3E.9090506@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41A30D3E.9090506@gmx.de>; from prakashkc@gmx.de on Tue, Nov 23, 2004 at 11:13:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 11:13:18AM +0100, Prakash K. Cheemplavam wrote:
> 
> While we are at it: Is xfs known to be broken while preempt is on? (Esp 

Nope.

> using ck's preemp big kernel lock?) I got following using a raid0 setup 
> with xfs. I thought it would be a driver issue, but reformatting to ext3 
> the stripe array runs now w/o probs for a few days. (xfs crapped out 
> after a few hours on heavy disk activity.)
> ...
> Nov 21 10:10:45 tachyon end_request: I/O error, dev sdb, sector 10480855
> Nov 21 10:10:45 tachyon I/O error in filesystem ("md0") meta-data dev 
> md0 block 0x13fd990       ("xfs_trans_read_buf") error 5 buf count 8192

This looks like your driver passed an error back up to the
filesystem while it was doing metadata IO and XFS chose to
shut it down to prevent further damage.  It's unlikely to
be a preempt/xfs problem.  Possibly hardware.  Did you see
any of those device errors since switching to ext3?

cheers.

-- 
Nathan
