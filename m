Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965857AbWKEIfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965857AbWKEIfq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 03:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965858AbWKEIfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 03:35:46 -0500
Received: from 1wt.eu ([62.212.114.60]:50436 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S965857AbWKEIfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 03:35:45 -0500
Date: Sun, 5 Nov 2006 09:34:16 +0100
From: Willy Tarreau <w@1wt.eu>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061105083416.GA2246@1wt.eu>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0611041633110.25218@g5.osdl.org> <Pine.LNX.4.64.0611050410210.29515@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611050410210.29515@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 05:14:06AM +0100, Mikulas Patocka wrote:
> On Sat, 4 Nov 2006, Linus Torvalds wrote:
> >- you have a _very_ confusing usage of upper-case. Not only are a lot of
> >  functions upper-case, some filenames are also upper-case. What would
> >  otherwise be more readable just ends up being hard to read because it's
> >  so odd and unexpected.
> >
> >  I'm sure there is some logic to it, but it escapes me.
> 
> I'm used to this. I usually make important functions with uppercase 
> letters and nonimportant temporary functions with lowercase letters.
>
> But I see that it contradicts general kernel coding style, so I can change 
> it.

We're more used to have uppercase for macros (or enums) and lowercase for
the rest. That way, when you read NULL, KERN_WARNING, PAGE_CACHE_SIZE,
INIT_LIST_HEAD..., you know that you're dealing with a macro, which is
very convenient.

> BTW do you find uppercase typedefs like
> typedef struct {
> 	...
> } SPADFNODE;
> confusing too?

Yes for the reason above. Also, we don't much use type definitions for
structures, because it's easier to understand "struct spadfnode *node"
in a function declaration than "SPADFNODE *node". Take a look at other
file systems. You'll see lots of "struct inode", "struct buffer_head".
Sometimes, you'll find some types suffixed with "_t", such as "handle_t"
or "spinlock_t". Generally, they are used for very commonly used data
(such as spinlocks), or opaque data which are passed between functions
without any interpretation. But it's more from observation than a rule.

> Uppercase filenames are there because the files are taken from another 
> (not yet released) project. But the kernel driver does not share any code 
> except definitions of disk structures, I saw how badly an attempt to share 
> kernel code affected XFS.

It's better to avoid uppercases in file names. I recently had to help
a user who could not build his kernel because of strange errors. I
finally found out that he was building from "entry.s" instead of "entry.S",
which suggested he copied the tree on a FAT. He confirmed having used a
vfat-formatted USB stick to copy his tree. Such errors are very annoying
to debug.

(...)
> I placed some benchmark on 
> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/benchmarks/

Not bad at all it seems !

Regards,
Willy

