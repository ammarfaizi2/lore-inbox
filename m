Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTJIPL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJIPL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:11:58 -0400
Received: from colin2.muc.de ([193.149.48.15]:43534 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262240AbTJIPL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:11:56 -0400
Date: 9 Oct 2003 17:12:12 +0200
Date: Thu, 9 Oct 2003 17:12:12 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       bos@serpentine.com
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
Message-ID: <20031009151212.GA54555@colin2.muc.de>
References: <20031009145235.GA47202@colin2.muc.de> <Pine.LNX.4.44.0310090754280.1694-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310090754280.1694-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 07:56:07AM -0700, Linus Torvalds wrote:
> 
> On 9 Oct 2003, Andi Kleen wrote:
> > 
> > That is exactly what the patch is doing.
> 
> No it's not.
> 
> What I'm asking for is a simple
> 
> 	if (vma->vm_flags & VM_READ)
> 		make_pages_readable();
> 
> kind of thing. A couple of one-liners in the _callers_, not a horribly 
> ugly change way down the stack.

Ok. But what is with mappings that have MAY_READ not set ?
[not 100% this cannot happen]

Without the changes make_pages_present didn't call get_user_pages
with the "force" argument. And changing it unconditionally would
change the behaviour for everybody.

Also there is still the problem that it will fail early for SIGBUS
that happens for other reasons (e.g. a hardware driver not being
able to mmap everything) 

-Andi

