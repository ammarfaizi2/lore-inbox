Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTEVOmf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 10:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTEVOmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 10:42:35 -0400
Received: from holomorphy.com ([66.224.33.161]:140 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261906AbTEVOme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 10:42:34 -0400
Date: Thu, 22 May 2003 07:55:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm8
Message-ID: <20030522145531.GR8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030522021652.6601ed2b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030522021652.6601ed2b.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 02:16:52AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm8/
> . One anticipatory scheduler patch, but it's a big one.  I have not stress
>   tested it a lot.  If it explodes please report it and then boot with
>   elevator=deadline.
> . The slab magazine layer code is in its hopefully-final state.
> . Some VFS locking scalability work - stress testing of this would be
>   useful.


Looks like this bit fell out from mainline; required for CONFIG_NUMA
to compile and identical to mainline.

-- wli

diff -prauN mm8-2.5.69-1/kernel/sched.c mm8-2.5.69-2/kernel/sched.c
--- mm8-2.5.69-1/kernel/sched.c	2003-05-22 04:54:59.000000000 -0700
+++ mm8-2.5.69-2/kernel/sched.c	2003-05-22 07:35:01.000000000 -0700
@@ -1084,6 +1084,9 @@ static void balance_node(runqueue_t *thi
 
 static void rebalance_tick(runqueue_t *this_rq, int idle)
 {
+#ifdef CONFIG_NUMA
+	int this_cpu = smp_processor_id();
+#endif
 	unsigned long j = jiffies;
 
 	/*
