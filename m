Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVG2IMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVG2IMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVG2IMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:12:24 -0400
Received: from fmr23.intel.com ([143.183.121.15]:40148 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262514AbVG2ILE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:11:04 -0400
Message-Id: <200507290808.j6T88ng08130@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Keith Owens'" <kaos@ocs.com.au>, "Ingo Molnar" <mingo@elte.hu>
Cc: <David.Mosberger@acm.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Add prefetch switch stack hook in scheduler function 
Date: Fri, 29 Jul 2005 01:08:48 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWUEIGnnJ6u6pR3R+ChSvBOXY6mOgAAGB1w
In-Reply-To: <10462.1122622689@kao2.melbourne.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote on Friday, July 29, 2005 12:38 AM
> BTW, for ia64 you may as well prefetch pt_regs, that is also quite
> large.
> 
> #define MIN_KERNEL_STACK_FOOTPRINT (IA64_SWITCH_STACK_SIZE + IA64_PT_REGS_SIZE)

This has to be carefully done, because you really don't want to overwhelm
number of outstanding L2 cache misses.  It only has a limited amount of
queue and once that is filled, cpu get into L2 recirculate state.  And that
is going to be very painful because it translate into cpu stall cycles.

