Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWHYHed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWHYHed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWHYHed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:34:33 -0400
Received: from ns.suse.de ([195.135.220.2]:57309 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751164AbWHYHed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:34:33 -0400
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: Incorrect alignment assumptions in x86_64 stacktrace
Date: Fri, 25 Aug 2006 09:33:53 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
References: <13065.1156489198@kao2.melbourne.sgi.com>
In-Reply-To: <13065.1156489198@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608250933.53623.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 08:59, Keith Owens wrote:
> 2.6.18-rc4 arch/x86_64/kernel/stacktrace.c::get_stack_end() incorrectly
> assumes that the irqstackptr is IRQSTACKSIZE aligned.
> 
> 	stack_end = (unsigned long)cpu_pda(cpu)->irqstackptr;
> 	if (stack_end) {
> 		stack_start = stack_end & ~(IRQSTACKSIZE-1);
> 
> irqstackptr is only guaranteed to be page aligned, not IRQSTACKSIZE
> (4*PAGE_SIZE) aligned.

Thanks. I have already removed that code post 2.6.18 (the standard backtracer
now does both stacktrace and show_trace) 

You think it is important enough for 2.6.18?

-Andi

