Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbVCWXOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbVCWXOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbVCWXOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:14:34 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:62700 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262441AbVCWXOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:14:18 -0500
Date: Wed, 23 Mar 2005 15:13:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com
cc: andrea@suse.de, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-ID: <17250000.1111619602@flay>
In-Reply-To: <20050323144953.288a5baf.akpm@osdl.org>
References: <20050315204413.GF20253@csail.mit.edu><20050316003134.GY7699@opteron.random><20050316040435.39533675.akpm@osdl.org><20050316183701.GB21597@opteron.random><1111607584.5786.55.camel@localhost.localdomain> <20050323144953.288a5baf.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I run into OOM problem again on 2.6.12-rc1. I run some(20) fsx tests on
>>  2.6.12-rc1 kernel(and 2.6.11-mm4) on ext3 filesystem, after about 10
>>  hours the system hit OOM, and OOM keep killing processes one by one.
> 
> I don't have a very good record reading these oom dumps lately, but this
> one look really weird.  Basically no mapped memory, tons of pagecache on
> the LRU.
> 
> It would be interesting if you could run the same test on 2.6.11.  

One thing I'm finding is that it's hard to backtrace who has each page
in this sort of situation. My plan is to write a debug patch to walk
mem_map and dump out some info on each page. I would appreciate ideas
on what info would be useful here. Some things are fairly obvious, like
we want to know if it's anon / mapped into address space (& which),
whether it's slab / buffers / pagecache etc ... any other suggestions
you have would be much appreciated.

I'm suspecting in many cases we don't keep enough info, and it would be
too slow to keep it in the default case - so I may need to add some
extra debug fields in struct page as a config option, but let's start
with what we have.

M.

