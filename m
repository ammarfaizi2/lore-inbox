Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWEIREw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWEIREw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWEIREw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:04:52 -0400
Received: from gold.veritas.com ([143.127.12.110]:12940 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750727AbWEIREv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:04:51 -0400
X-IronPort-AV: i="4.05,106,1146466800"; 
   d="scan'208"; a="59349415:sNHT31840196"
Date: Tue, 9 May 2006 18:04:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com, akpm@osdl.org,
       Andi Kleen <ak@suse.de>, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, hch@infradead.org
Subject: Re: [RFC] [PATCH 6/6] Kprobes: Remove breakpoints from the copied
 pages
In-Reply-To: <20060509071523.GF22493@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0605091747050.10238@blonde.wat.veritas.com>
References: <20060509065455.GA11630@in.ibm.com> <20060509065917.GA22493@in.ibm.com>
 <20060509070106.GB22493@in.ibm.com> <20060509070508.GC22493@in.ibm.com>
 <20060509070911.GD22493@in.ibm.com> <20060509071204.GE22493@in.ibm.com>
 <20060509071523.GF22493@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 May 2006 17:04:51.0410 (UTC) FILETIME=[AF85CB20:01C6738A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006, Prasanna S Panchamukhi wrote:
> This patch removes the breakpoints if the pages read from the page
> cache contains breakpoints. If the pages containing the breakpoints
> is copied from the page cache, the copied image would also contain
> breakpoints in them. This could be a major problem for tools like
> tripwire etc and cause security concerns, hence must be prevented.
> This patch hooks up the actor routine, checks if the executable was
> a probed executable using the file inode and then replaces the
> breakpoints with the original opcodes in the copied image.

You've done a nice job of making the code look like kernel code
throughout, it's a much tidier patchset than many.

With that said... it looks to me like one of the scariest and
most inappropriate sets I can remember.  Getting the kernel to
connive in presenting an incoherent view of its pagecache:
I don't think we'd ever want that.

There's all kinds of things that could be said about the details
(your locking is often insufficient, for example); but there's a
lot going on, and it doesn't seem worth going through this line
by line, when the whole concept seems so unwelcome.

You've a big task to convince people that this is something the
Linux kernel will want: and perhaps you'll succeed - good luck.

But please approach what you're trying to do from userspace:
you can patch the binaries from there if you wish (but not on
my system, thanks).  Or perhaps you can patch it all into the
kernel via kprobes itself, but I wouldn't recommend it.

Hugh
