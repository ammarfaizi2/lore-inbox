Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUEKCOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUEKCOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 22:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUEKCOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 22:14:36 -0400
Received: from hera.kernel.org ([63.209.29.2]:61389 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261405AbUEKCOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 22:14:34 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: AMD64 and RAID6
Date: Tue, 11 May 2004 02:13:47 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c7pcsr$u4e$1@terminus.zytor.com>
References: <409D1D86.6050907@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1084241627 30863 127.0.0.1 (11 May 2004 02:13:47 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 11 May 2004 02:13:47 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <409D1D86.6050907@clanhk.org>
By author:    "J. Ryan Earl" <heretic@clanhk.org>
In newsgroup: linux.dev.kernel
>
> I noticed the following in my dmesg:
> 
> raid5: measuring checksumming speed
>   generic_sse:  6604.000 MB/sec
> raid5: using function: generic_sse (6604.000 MB/sec)
> raid6: int64x1   1847 MB/s
> raid6: int64x2   2753 MB/s
> raid6: int64x4   2878 MB/s
> raid6: int64x8   1902 MB/s
> raid6: sse2x1    1015 MB/s
> raid6: sse2x2    1488 MB/s
> raid6: sse2x4    1867 MB/s
> raid6: using algorithm sse2x4 (1867 MB/s)
> md: raid6 personality registered as nr 8
> md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> 
> Why doesn't RAID6 use the int64x4 algorithm in this situation?  What is 
> the motivation of setting the 'prefer field' on the sse algorithms and 
> not on the integer based algorithms?
> 

The SSE algorithms are non-cache-polluting.  This makes them slightly
slower, but avoids slowing the rest of the machine down as much.

	-hpa
