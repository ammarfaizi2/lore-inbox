Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423233AbWCUSnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423233AbWCUSnX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423252AbWCUSnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:43:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423222AbWCUSnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:43:20 -0500
Date: Tue, 21 Mar 2006 10:42:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
In-Reply-To: <1142965478.4749.58.camel@praia>
Message-ID: <Pine.LNX.4.64.0603211035390.3622@g5.osdl.org>
References: <20060320150819.PS760228000000@infradead.org> 
 <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>  <Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
  <1142962995.4749.39.camel@praia>  <Pine.LNX.4.64.0603210946040.3622@g5.osdl.org>
 <1142965478.4749.58.camel@praia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2006, Mauro Carvalho Chehab wrote:
> 
> What is sad is that I can't determinate the root cause of this breakage,
> but it seemed to be associated with merging handling at stg or git.

Note that the bad commit has a totally different commit message from any 
of your other merges. It was this one:

	diff-tree e338b736f1aee59b757130ffdc778538b7db18d6 (from cb31c70cdf1ac7034bed5f83d543f4888c39888a)
	Author:     Mauro Carvalho Chehab <mchehab@infradead.org>
	AuthorDate: Fri Mar 10 01:30:04 2006 -0300
	Commit:     Mauro Carvalho Chehab <mchehab@infradead.org>
	CommitDate: Fri Mar 10 01:30:04 2006 -0300

	    Merging Linus tree

	:100644 100644 be5ae600f5337dbb14daa8d4cace110486e14f79 81bc51369f59a413108fd8b150c3090541ba49f8 M      Documentation/feature-removal-schedule.txt
	:100644 100644 75205391b335f85c9b8a599d0d3b4c0dd1a8b41b fc99075e0af47f0b73a2ae2dfb7d19920c604dea M      Documentation/kernel-parameters.txt
	:100644 100644 9006063e73691da7b68449955a135f7c9317e2cd da677f829f7689966bf09aeda6d89fc4b6a876d1 M      arch/alpha/kernel/irq.c
	...

ie it does _not_ fit the pattern of your other merges.

Here's an example of a real git merge, with a conflict fixed up:

	Merge: 7705a87... 86d720e...
	Author: Mauro Carvalho Chehab <mchehab@infradead.org>
	Date:   Mon Mar 20 06:43:08 2006 -0300
	
	    Merge branch 'prev'
	    
	    Conflicts:
	    
	        drivers/media/video/em28xx/em28xx-video.c

which is the standard commit message for modern git when a conflict 
happened that you needed to fix up before committing.

And here's a couple of your non-conflicting merges:

	commit 155ec9e63da962bf26ffc65a4088c6cc935f28db
	Merge: 8e2cc1a... 8a59822...
	Author: Mauro Carvalho Chehab <mchehab@infradead.org>
	Date:   Wed Mar 8 12:34:10 2006 -0300
	
	    Merge branch 'work-fixes'
	
	commit cb31c70cdf1ac7034bed5f83d543f4888c39888a
	Merge: 06b1c30... 044f324...
	Author: Mauro Carvalho Chehab <mchehab@infradead.org>
	Date:   Wed Mar 8 12:33:42 2006 -0300
	
	    Merge branch 'work'

which are also clearly generated with git (this is the standard 
boilerplate git commit message for a merge with no conflict).

So just the merge message tells me that it wasn't a regular git merge, but 
something else.

		Linus
