Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268695AbTBZJaK>; Wed, 26 Feb 2003 04:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268696AbTBZJaK>; Wed, 26 Feb 2003 04:30:10 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:8383 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S268695AbTBZJaJ>; Wed, 26 Feb 2003 04:30:09 -0500
Date: Wed, 26 Feb 2003 09:37:42 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
Message-ID: <20030226103742.GA29250@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200302251908.55097.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302251908.55097.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 07:08:48PM +0100, Thomas Schlichter wrote:

 > here is a patch to solve all (I hope I missed none) possible problems that 
 > could occur on SMP machines running a preemptible kernel when 
 > smp_call_function() calls a function which should be also executed on the 
 > current processor.
 > 
 > This patch is based on the one Dave Jones sent to the LKML last friday and 
 > applies to the linux kernel version 2.5.63.

Just one comment. You moved quite a few of the preempt_disable/enable
pairs outside of the CONFIG_SMP checks.  The issue we're working against
here is to try and prevent preemption and ending up on a different CPU.
As this cannot happen if CONFIG_SMP=n, I don't see why you've done this.

		Dave

