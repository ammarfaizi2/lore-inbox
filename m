Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTEEPt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 11:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTEEPt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 11:49:58 -0400
Received: from holomorphy.com ([66.224.33.161]:17025 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262407AbTEEPt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 11:49:57 -0400
Date: Mon, 5 May 2003 09:02:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David van Hoose <davidvh@cox.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69
Message-ID: <20030505160222.GP8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	David van Hoose <davidvh@cox.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EB602ED.3080207@cox.net> <Pine.LNX.4.44.0305050851080.18785-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305050851080.18785-100000@home.transmeta.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 08:56:41AM -0700, Linus Torvalds wrote:
> They actually started in 2.5.60 if it's the same bug.
> And yes, you'd get random crashes, panics, lockups and even reboots. The 
> problem was that the pmd/pgd's were put in the slab cache in between 
> 2.5.59 and 2.5.60, and that was simply wrong because the AGP code changes 
> the cacheability of the kernel pages when it maps stuff into the AGP 
> aperture. That in turn will change the page tables but it won't update the 
> cached entries in the pmd slab caches. 
> So what happens is that once you exit X, and the page tables are put back
> together without the cacheability changes, and you start a new program,
> that program may get a page table with partly bogus kernel page table
> entries.
> That, in turn, when it happens will cause _major_ memory corruption, and
> your machine is toast, often in very interesting ways because the internal
> kernel data structures got corrupted. It can also cause random SIGSEGV's
> etc.
> But it only happens with AGP, and a lot of people either don't use it or 
> run only one X session.

Any chance one of you could try out the fixed slabification patches?
Message-ID: <20030505105213.GO8931@holomorphy.com>

-- wli
