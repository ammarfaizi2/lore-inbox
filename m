Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUBJQ0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUBJQ0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:26:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:18332 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265985AbUBJQ0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:26:06 -0500
Date: Tue, 10 Feb 2004 08:25:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andi Kleen <ak@suse.de>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
In-Reply-To: <1076384799.893.5.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
References: <1076384799.893.5.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> Just reverting the patch fixes it. Though, the patch do make sense in
> some cases, paulus suggested to modify the code so that for a non
> MAP_FIXED map, it still search from the passed-in address, but avoids
> the spare between the current mm->brk and TASK_UNMAPPED_BASE, thus the
> algorithm would still work for things outside of these areas.
> 
> Commment ?

I'd rather revert it. If it has broken something, I'm nervous that random 
hacking will just break more. I see the patch that fixes it, but what else 
will now break? Having a magic special case for "brk" is just too damn 
ugly for words.

What I find strange is that bash passed in something else than NULL as the 
argument in the first place. Doing a quick trace of my bash executable 
shows non-NULL hints only for MAP_FIXED mmap's. So what triggered this? 

Random special cases in code are just evil, and end up biting us in the 
end. Which is why I'd rather see the revert, along with more of a look at 
_why_ bash does what it does for you.

			Linus
