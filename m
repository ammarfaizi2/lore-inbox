Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbTBUOjL>; Fri, 21 Feb 2003 09:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbTBUOjL>; Fri, 21 Feb 2003 09:39:11 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:24510 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267457AbTBUOjJ>;
	Fri, 21 Feb 2003 09:39:09 -0500
Date: Fri, 21 Feb 2003 15:01:27 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c w ith flush_tlb_all()
Message-ID: <20030221150127.GB22285@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302211217390.1531-100000@localhost.localdomain> <200302211342.19007.schlicht@uni-mannheim.de> <20030221142039.GA21532@codemonkey.org.uk> <200302211525.07213.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302211525.07213.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 03:25:01PM +0100, Thomas Schlichter wrote:

 > I found a function in the file mm/slab.c called smp_call_function_all_cpus() 
 > which tries to do the thing we want, but I think not even this function is 
 > preempt-safe...!

That certainly looks erm, odd.

 > Perhaps even the semantic of the function smp_call_function() could be changed 
 > to call the function on every CPU? Just an idea...

Some places that use it actually rely on it not executing on the local cpu.
It would also break backwards compatabiltiy for no real good reason.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
