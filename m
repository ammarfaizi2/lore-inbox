Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbWKEQMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWKEQMq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbWKEQMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:12:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932722AbWKEQMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:12:46 -0500
Date: Sun, 5 Nov 2006 08:12:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Benjamin LaHaise <bcrl@kvack.org>, Zachary Amsden <zach@vmware.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
In-Reply-To: <200611050641.14724.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0611050808090.25218@g5.osdl.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <20061105035556.GQ9057@kvack.org>
 <Pine.LNX.4.64.0611041959260.25218@g5.osdl.org> <200611050641.14724.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Andi Kleen wrote:
> 
> This means we should definitely change restore_flags() to only STI, 
> never popf

Whaa? That would be wrong. We don't always sti, quite often the flags were 
disabled anyway.

And changing restore-flags to a "conditional branch around sti" is likely 
not much better - mispredicted branches on a P4 are potentially worse than 
the popf cost.

Side note: for the netburst microarchitecture - aka P4 - in general, 
something like 48 cycles is a _good_ thing. I measured a internal 
micro-fault for marking a page table entry dirty at over 1500 cycles! 
There's a reason Intel dropped Netburst in favour of Core 2 - which is 
largely just an improved Pentium Pro uarch. Admittedly, the "just" is a 
bit unfair, because there's a _lot_ of improvement, but still..

So you should never actually make any real code design decisions based on 
a P4 result. The P4 is goign away, and it was odd. 

		Linus
