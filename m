Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbTBTUOJ>; Thu, 20 Feb 2003 15:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTBTUOI>; Thu, 20 Feb 2003 15:14:08 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:22452 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266932AbTBTUOD>;
	Thu, 20 Feb 2003 15:14:03 -0500
Date: Thu, 20 Feb 2003 20:36:19 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c with flush_tlb_all()
Message-ID: <20030220203619.GA26583@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200302202002.h1KK2YZ00018@rumms.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302202002.h1KK2YZ00018@rumms.uni-mannheim.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 09:00:05PM +0100, Thomas Schlichter wrote:

 > This patch replaces the flush_map() function in the arch/i386/mm/pageattr.c file with flush_tlb_all() calls, as the flush_map() function wants to do the same, but just forgot the preempt_disable() and preempt_enable() calls.
 > 
 > To minimize future inconsistency I think this patch should be applied...

This looks bogus. You're killing the wbinvd() in flush_kernel_map() which
is needed.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
