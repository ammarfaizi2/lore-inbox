Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUAUQX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 11:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUAUQX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 11:23:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:1436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263598AbUAUQXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 11:23:25 -0500
Message-Id: <200401211623.i0LGNHo04546@mail.osdl.org>
Date: Wed, 21 Jan 2004 08:23:14 -0800 (PST)
From: markw@osdl.org
Subject: Re: DBT-2 anticipatory scheduler and filesystem results with 2.6.1
To: akpm@osdl.org
cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20040119203845.332cd5df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan, Andrew Morton wrote:
> markw@osdl.org wrote:
>>
>>  I ran some dbt-2 tests against 5 filesystems with 2.6.1-mm4 and 2.6.1. I
>>  see a degradation from 0 to 7% in throughput. 
> 
> -mm4 also had readahead changes which will adversely impact database-style
> workloads.  I'd suggest that you revert
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/broken-out/readahead-revert-lazy-readahead.patch
> 
> and retest.
> 
> We reverted lazy readahead because it broke NFS linear reads and was doing
> the wrong thing anyway.  We need to come up with something else for
> database-style workloads.

Ok, ran through a set of tests a -R of the
readahead-revert-lazy-readahead.patch.  Saw a significant improvement
with xfs, but the other file systems appeared to improve only marginally
compared to 2.6.1-mm4 with that patch.

Here's a summary compared to 2.6.1:

		% throughput change from 2.6.1 to 2.6.1-mm4 -R readahead
ext2		-4.9
ext3		-4.3
jfs		-5.1
reiserfs	-3.8
xfs		14.8

Here's the summary of the original 2.6.1-mm4 for reference:

		% throughput change from 2.6.1 to 2.6.1-mm4
ext2		-5.9%
ext3		-5.1%
jfs		-7.0%
reiserfs	-2.2%
xfs		-0.3%

And the link to the result details:
	http://developer.osdl.org/markw/fs/project_results.html
