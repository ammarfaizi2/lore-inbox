Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267415AbTBUMHS>; Fri, 21 Feb 2003 07:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267417AbTBUMHS>; Fri, 21 Feb 2003 07:07:18 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:15709 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S267415AbTBUMHR>; Fri, 21 Feb 2003 07:07:17 -0500
Date: Fri, 21 Feb 2003 12:19:01 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Thomas Schlichter <schlicht@uni-mannheim.de>
cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c w
 ith flush_tlb_all()
In-Reply-To: <200302211224.39021.schlicht@uni-mannheim.de>
Message-ID: <Pine.LNX.4.44.0302211217390.1531-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2003, Thomas Schlichter wrote:
> 
> So here is a minimal change patch that should solve the preempt issue in 
> flush_map().
> 
> Instead of just doing a preempt_disable() before and a preempt_enable()
> after 
> the flush_kernel_map() calls I just changed the order so that the preempt 
> point is not between them...

No.  All that does is make sure that the cpu you start out on is
flushed, once or twice, and the cpu you end up on may be missed.
Use preempt_disable and preempt_enable.

Hugh

