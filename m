Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269352AbUIIFzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269352AbUIIFzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 01:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269353AbUIIFzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 01:55:44 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55235 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269352AbUIIFzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 01:55:22 -0400
Date: Thu, 09 Sep 2004 15:00:35 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC][PATCH] no bitmap buddy allocator : removing atomic ops (4/4)
In-reply-to: <413EF64B.2060407@jp.fujitsu.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <413FF183.2010207@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <413EF64B.2060407@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hiroyuki KAMEZAWA wrote:
> To check effects of this patch. I made a tiny test.
> 
> ************** test-program ********************
> for(i = 0; i < 1000; i++) {
>     mmap(16 Mega bytes, MAP_ANON);
>     touch all pages;
>     munmap(16 Mega bytes);
> }
> ************************************************
These are results when CONFIG_SMP=n

reference kernel- 2.6.9-rc1-mm4
Total 0:31.51 System 29.53 User 1.92
Total 0:31.76 System 29.82 User 1.89
Total 0:31.76 System 29.81 User 1.89
Total 0:31.84 System 29.79 User 2.00
Total 0:32.05 System 30.01 User 1.99

no bitmap witout optimization
Total 0:31.17 System 29.18 User 1.93
Total 0:31.30 System 29.28 User 1.97
Total 0:31.39 System 29.36 User 1.97
Total 0:31.46 System 29.40 User 2.02
Total 0:31.51 System 29.45 User 2.00

no bitmap with optimization
Total 0:31.17 System 29.10 User 2.01
Total 0:31.28 System 29.32 User 1.91
Total 0:31.35 System 29.29 User 2.01
Total 0:31.47 System 29.43 User 1.98
Total 0:31.50 System 29.52 User 1.93

There is no difference between optimized and not-optimized version.

-- Kame





> Results of this program.
> Host : Intex Xeon 1.8GHz x2, Memory 8Gbytes. Multi-user mode.
> 
> Reference Kernel --- linux-2.6.9-rc1-mm4
> Total 0:35.79 System 33.89 User 1.88
> Total 0:35.44 System 33.58 User 1.85
> Total 0:35.75 System 33.81 User 1.91
> Total 0:35.89 System 34.03 User 1.82
> Total 0:35.93 System 34.03 User 1.84
> 
> No-bitmap without this micro-optimization patch
> Total 0:37.58 System 35.69 User 1.89
> Total 0:37.52 System 35.66 User 1.86
> Total 0:37.56 System 35.68 User 1.88
> Total 0:37.64 System 35.76 User 1.88
> Total 0:37.72 System 35.89 User 1.82
> 
> No-bitmap with this micro-optimization patch.
> Total 0:35.28 System 33.45 User 1.81
> Total 0:35.38 System 33.62 User 1.75
> Total 0:35.44 System 33.58 User 1.84
> Total 0:35.52 System 33.58 User 1.90
> Total 0:35.79 System 33.92 User 1.81
> 
> Single-user-mode.
> 
> reference-kernel  linux-2.6.9-rc1-mm4:
> Total 0:35.20 System 33.32 User 1.88
> Total 0:35.23 System 33.37 User 1.85
> Total 0:35.58 System 33.77 User 1.81
> Total 0:35.49 System 33.60 User 1.90
> Total 0:35.79 System 33.80 User 1.99
> 
> No-bitmap without this micro-optimization patch
> Total 0:36.83 System 35.16 User 1.67
> Total 0:36.45 System 34.66 User 1.79
> Total 0:36.81 System 35.10 User 1.70
> Total 0:36.89 System 35.24 User 1.65
> Total 0:36.82 System 35.14 User 1.68
> 
> No-bitmap with this micor-optimization patch:
> Total 0:34.97 System 33.07 User 1.89
> Total 0:34.94 System 32.98 User 1.95
> Total 0:34.99 System 33.11 User 1.87
> Total 0:34.90 System 33.14 User 1.76
> Total 0:34.92 System 33.02 User 1.90
> 
> 
> Results with this patch is better than ones without this by 2 seconds.
> 2/1000 = 2ms per 1 iteration (for 16 Megabytes alloc/free).
> 

