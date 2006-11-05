Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161339AbWKEQzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161339AbWKEQzn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161350AbWKEQzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:55:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:39633 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161339AbWKEQzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:55:42 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
Date: Sun, 5 Nov 2006 17:54:11 +0100
User-Agent: KMail/1.9.5
Cc: Benjamin LaHaise <bcrl@kvack.org>, Zachary Amsden <zach@vmware.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <200611050641.14724.ak@suse.de> <Pine.LNX.4.64.0611050808090.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611050808090.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611051754.11982.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 November 2006 17:12, Linus Torvalds wrote:

> And changing restore-flags to a "conditional branch around sti" 

Yes of course.

> is likely  
> not much better 

We'll see.

It used to be a bad idea because everything was inline, but these
days with out of line code one can be much more flexible.

> - mispredicted branches on a P4 are potentially worse than  
> the popf cost.

They are far less than 48 cycles. The P4 is not _that_ bad in this
area.

> Side note: for the netburst microarchitecture - aka P4 - in general, 
> something like 48 cycles is a _good_ thing. I measured a internal 
> micro-fault for marking a page table entry dirty at over 1500 cycles! 
> There's a reason Intel dropped Netburst in favour of Core 2 - which is 
> largely just an improved Pentium Pro uarch. Admittedly, the "just" is a 
> bit unfair, because there's a _lot_ of improvement, but still..
> 
> So you should never actually make any real code design decisions based on 
> a P4 result. The P4 is goign away, and it was odd. 

There are millions and millions of P4s out there running 
Linux and I don't think that will change any time soon (in fact Intel will
be still shipping many new ones for a long time) If there are cheap 
valuable optimizations for P4 that don't impact others much I'm all for them.
 
-Andi
