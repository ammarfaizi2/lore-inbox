Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbTBUBnM>; Thu, 20 Feb 2003 20:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbTBUBnL>; Thu, 20 Feb 2003 20:43:11 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:37599 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267043AbTBUBnL>; Thu, 20 Feb 2003 20:43:11 -0500
Date: Thu, 20 Feb 2003 17:44:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>
Subject: Re: Performance of partial object-based rmap
Message-ID: <278890000.1045791857@flay>
In-Reply-To: <7490000.1045715152@[10.10.2.4]>
References: <7490000.1045715152@[10.10.2.4]>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The performance delta between 2.5.62-mjb1 and 2.5.62-mjb2 is caused
> by the partial object-based rmap patch (written by Dave McCracken).
> I expect this patch to have an increasing impact on workloads with
> more processes, and it should give a substantial space saving as 
> well as a performance increase. Results from 16x NUMA-Q system ... 
> 
> Profile comparison:
> 
> before
> 	15525 page_remove_rmap
> 	6415 page_add_rmap
> 
> after
> 	2055 page_add_rmap
> 	1983 page_remove_rmap

Did some space consumption comparisons on make -j 256:

before:
	24116 pte_chain objects in slab cache
after:
	716 pte_chain objects in slab cache

The vast majority of anonymous pages (for which we're using the non
object based method) are singletons, and hence use pte_direct ...
hence the massive space reduction.

M.

