Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVBNSid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVBNSid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVBNSid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:38:33 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:25031 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261517AbVBNSiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:38:24 -0500
Message-ID: <4210F01E.9070707@us.ibm.com>
Date: Mon, 14 Feb 2005 10:38:22 -0800
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       tytso@mit.edu, pbadari@us.ibm.com, suparna@in.ibm.com,
       gerrit@us.ibm.com, tappro@clusterfs.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Latest ext3 patches (extents, mballoc, delayed
 allocation)
References: <1106354192.3634.19.camel@dyn318043bld.beaverton.ibm.com>	<m3hdl2lehb.fsf@bzzz.home.net> <4207BBEA.7090705@us.ibm.com> <m3y8dude4q.fsf@bzzz.home.net>
In-Reply-To: <m3y8dude4q.fsf@bzzz.home.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:

> Good day all, 
> 
> I've updated the patchset against 2.6.10. A bunch of bugs have been
> fixed and mballoc now behaves smarter a bit. Extents and mballoc 
> patches collects some stats they print upon umount. NOTE: they must
> not be used to store important data. A lot of things are to be done.
> 

Thanks Alex, for the hard work.

> Please review. Any comments and suggestions are very welcome.

Will do.

> 
> 
> The followins crazy listing shows tiobench's results for SMP box:
> 
> Random Reads
>                               File  Blk   Num                   Avg     CPU
> Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency   Eff
> ---------------------------- ------ ----- ---  ------ ------ --------- -----
> ext2                          512   4096    1  119.05 40.37%     0.031   295
> ext3                          512   4096    1  134.78 37.08%     0.028   363
> ext3rs                        512   4096    1   25.18 8.377%     0.154   301

The throughput here is really weird. Reservation code does not touch 
read code path. I could imagine that it maybe change the disk layout and 
make a difference on sequential reads, but I am not sure how it will 
affect the random read. And this is happening on 1 thread and 4 threads, 
but for 2 threads, reservation case is the best. I will see if I could 
repeat the same results here.

Mingming
