Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbTBUOkz>; Fri, 21 Feb 2003 09:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267463AbTBUOkz>; Fri, 21 Feb 2003 09:40:55 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:54145 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S267459AbTBUOkx>; Fri, 21 Feb 2003 09:40:53 -0500
Date: Fri, 21 Feb 2003 14:52:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Dave Jones <davej@codemonkey.org.uk>
cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c w
 ith flush_tlb_all()
In-Reply-To: <20030221142039.GA21532@codemonkey.org.uk>
Message-ID: <Pine.LNX.4.44.0302211439590.1669-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2003, Dave Jones wrote:
> It would probably clean things up a lot if we had a function to do..
> 
> static inline void on_each_cpu(void *func)
> {      
> #ifdef CONFIG_SMP
> 	preempt_disable();
> 	smp_call_function(func, NULL, 1, 1);
> 	func(NULL);
> 	preempt_enable();
> #else
> 	func(NULL);
> #endif
> }

Of course that's much much better.  But I think rather better as
static inline void on_each_cpu(void (*func) (void *info), void *info)
passing info to func instead of assuming NULL.  inline? maybe.

Hugh

