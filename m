Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTGAV1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 17:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTGAV1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 17:27:07 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:14229 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263848AbTGAV1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 17:27:03 -0400
Date: Tue, 1 Jul 2003 22:41:25 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Daniel Phillips <phillips@arcor.de>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
In-Reply-To: <200306301943.04326.phillips@arcor.de>
Message-ID: <Pine.LNX.4.53.0307012202510.16265@skynet>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <200306301943.04326.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003, Daniel Phillips wrote:

> On Tuesday 01 July 2003 03:39, Mel Gorman wrote:
> > I'm writing a small paper on the 2.6 VM for a conference.
>
> Nice stuff, and very timely.
>

I was hoping someone else would write it so I could read it but thats what
I said about the 2.4 VM :-) . Yep, once again, my contributions are mainly
documenting related, believe it or not, I actually do code a bit from time
to time

I was going to update the whole document based on this thread and repost
it but it's looking like it'll take me a few days for a week before I work
through it all (so I'm slow, sue me). This is especially true as there is
a lot of old email threads I need to read before I understand 100% of the
current discussion (which is also why I'm not replying to most posts in
this thread). Instead, I'm going to post up the bits that are changed and
hopefully get everything together.

This is the first change....

> You probably ought to mention that this is only needed by 32 bit architectures
> with silly amounts of memory installed.

Point... Taking into account what Martin said, the introduction to "PTEs
in high memory" now reads;

--Begin Extract--
   PTEs in High Memory
   ===================

   In 2.4, Page Table Entries (PTEs) must be allocated from ZONE_NORMAL as
   the kernel needs to address them directly for page table traversal. In a
   system with many tasks or with large mapped memory regions, this can place
   significant pressure on ZONE_NORMAL so 2.6 has the option of allocating
   PTEs from high memory.

   Allocating PTEs from high memory is a compile time option for two reasons.
   First and foremost, this is only really needed by 32 bit architectures
   with very large amounts of memory or when the workloads require many
   processes to share pages. With lower memory machines or 64 bit
   architectures, it is simply not required. Patches were submitted that
   would allow page tables to be shared between processes in a Copy-On-Write
   fashion which would mitigate the need for high memory PTEs but they were
   never merged.
--End Extract--

> On that topic, you might mention
> that the VM subsystem generally gets simpler and in some cases faster (i.e.,
> no more highmem mapping cost) in the move to 64 bits.
>

I'm wary of making a statement like that. I'm not sure the code actually
simpler with 64 bit but to me it looks about as complicated (or simple
depending on your perspective). On the faster point, I understand that it
is possible to have a net loss due to TLB and CPU cache misses. In this
case, I think I'll just keep quiet

> You also might want to mention pdflush.
>

Added to the todo list as well as object based rmap. I know object based
rmap isn't merged but it is discussed enough that I'll put the time in to
write about it.

-- 
Mel Gorman
