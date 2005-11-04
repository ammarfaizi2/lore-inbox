Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbVKDPPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbVKDPPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbVKDPPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:15:05 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:7608 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932747AbVKDPPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:15:02 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] swapin rlimit
Date: Fri, 4 Nov 2005 09:14:01 -0600
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>, pbadari@gmail.com, torvalds@osdl.org,
       jdike@addtoit.com, nickpiggin@yahoo.com.au, gh@us.ibm.com,
       kamezawa.hiroyu@jp.fujitsu.com, haveblue@us.ibm.com, mel@csn.ul.ie,
       mbligh@mbligh.org, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <20051104072628.GA20108@elte.hu> <20051103233628.12ed1eee.akpm@osdl.org>
In-Reply-To: <20051103233628.12ed1eee.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511040914.02635.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 November 2005 01:36, Andrew Morton wrote:
> >  wouldnt the clean solution here be a "swap ulimit"?
>
> Well it's _a_ solution, but it's terribly specific.
>
> How hard is it to read /proc/<pid>/nr_swapped_in_pages and if that's
> non-zero, kill <pid>?

Things like make fork lots of short-lived child processes, and some of those 
can be quite memory intensive.  (The gcc 4.0.2 build causes an outright swap 
storm for me about halfway through, doing genattrtab and then again compiling 
the result).

Is there any way for parents to collect their child process's statistics when 
the children exit?  Or by the time the actual swapper exits, do we not care 
anymore?

Rob
