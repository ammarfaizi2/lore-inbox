Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946523AbWJTVQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946523AbWJTVQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946525AbWJTVQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:16:51 -0400
Received: from gw.goop.org ([64.81.55.164]:29099 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1946523AbWJTVQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:16:50 -0400
Message-ID: <45393CBD.8000400@goop.org>
Date: Fri, 20 Oct 2006 14:16:45 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Eric Sandeen <sandeen@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] more helpful WARN_ON and BUG_ON messages
References: <4538F81A.2070007@redhat.com>
In-Reply-To: <4538F81A.2070007@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:
> After a few bugs I encountered in FC6 in buffer.c, with output like:
>
> Kernel BUG at fs/buffer.c: 2791
>
> where buffer.c contains:
>
> ...
>         BUG_ON(!buffer_locked(bh));
>         BUG_ON(!buffer_mapped(bh));
>         BUG_ON(!bh->b_end_io);
> ...
>
> around line 2790, it's awfully tedious to go get the exact failing kernel tree
> just to see -which- BUG_ON was encountered.
>
> Printing out the failing condition as a string would make this more helpful IMHO.
>   

This seems like a generally useful idea - certainly more valuable than 
storing+printing the function name.

You might want to look at the BUG patches I wrote, which are currently 
in -mm.  I added general machinery to allow architectures to easily 
implement BUG() efficiently (ie, with a minimal amount of BUG-related 
icache pollution).  If you were to store the BUG_ON expression, it would 
be best to extend struct bug_entry and store it there - doing it in 
asm-generic BUG_ON() means you still end up with code to set up the 
printk in the mainline code path, and it also won't honour 
CONFIG_DEBUG_BUGVERBOSE being disabled.

    J
