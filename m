Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUBHBO1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUBHBO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:14:27 -0500
Received: from dp.samba.org ([66.70.73.150]:31628 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261774AbUBHBOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:14:18 -0500
Date: Sun, 8 Feb 2004 12:12:21 +1100
From: Anton Blanchard <anton@samba.org>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <20040208011221.GV19011@krispykreme>
References: <20040207095057.GS19011@krispykreme> <200402080040.i180eY811893@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402080040.i180eY811893@owlet.beaverton.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> The current imbalance code rounds up to 1, meaning that we'll often
> see an "imbalance" of 1 even when it's 1 to 0 and just been moved.
> Did you see these results even with Martin's patch to not round up to 1?

Indeed Martins patch does fix the problem:

cpu    user  system    idle             cpu    user  system    idle
cpu0      0       0     100             cpu1      0       0     100
cpu2      0       0     100             cpu3      0       0     100
cpu4      0       0     100             cpu5      0       0     100
cpu6      0       0     100             cpu7      0       0     100
cpu8      0       0     100             cpu9      0       0     100
cpu10     0       0     100             cpu11     0       0     100
cpu12     0       0     100             cpu13   100       0       0
cpu14     0       0     100             cpu15     0       0     100

My current tree has your patch and Martins patch. So far its looking
good.

Anton
