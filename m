Return-Path: <linux-kernel-owner+w=401wt.eu-S1426249AbWLHUC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426249AbWLHUC5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 15:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426254AbWLHUC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 15:02:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57079 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426250AbWLHUCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 15:02:55 -0500
Date: Fri, 8 Dec 2006 12:01:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061208193116.GI31068@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612081154060.3516@woody.osdl.org>
References: <20061206195820.GA15281@flint.arm.linux.org.uk>
 <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk>
 <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk>
 <4595.1165597017@redhat.com> <Pine.LNX.4.64.0612080903370.15959@schroedinger.engr.sgi.com>
 <20061208171816.GG31068@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612080919220.16029@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0612081101280.3516@woody.osdl.org> <20061208193116.GI31068@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2006, Russell King wrote:
> 
> No such restriction on ARM.
> 
> Also not true.  The architectural implementation is:

I checked the ARM manuals, and quite fankly, they don't back you up.

They do not claim that the physical address tag is byte-granular, and in 
fact they make it pretty clear that the same tag is used for all the 
sizes, which implies that the tag granularity is NOT byte granular, but 
likely something else. 

Both the manuals I checked also say: "Other events might cause the tag to 
be cleared", without going into particular details other than saying that 
a region that is marked non-shared might still clear the tag on access by 
other CPU's - but they leave it open whether that's by design or not.

In other words, if there actually is an architectural guarantee that 
ldrex/strex are really as strong as you imply, it's not in the standard 
architecture manuals from ARM at least for the ARM11562 or the ARM1136.

So I suspect you're wrong, and that the ldrex/strex tags actually are not 
all that different from other archtiectures which tend to have cacheline 
granularities or more (I _think_ the original alpha granularity was the 
whole address space, and any cache traffic would clear it. That's _really_ 
pathetically weak, but hey, I might remember wrong, and it was the very 
first implementation. I doubt ARM is _that_ weak, but I doubt it's as 
strong as you claim).

			Linus
