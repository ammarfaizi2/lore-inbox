Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWEMXUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWEMXUm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWEMXUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:20:42 -0400
Received: from mail.suse.de ([195.135.220.2]:25734 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964792AbWEMXUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:20:41 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	<20060513160541.8848.2113.stgit@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 14 May 2006 01:20:40 +0200
In-Reply-To: <20060513160541.8848.2113.stgit@localhost.localdomain>
Message-ID: <p73u07t5x6f.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> This patch adds the base support for the kernel memory leak detector. It
> traces the memory allocation/freeing in a way similar to the Boehm's
> conservative garbage collector, the difference being that the orphan
> pointers are not freed but only shown in /proc/memleak. Enabling this
> feature would introduce an overhead to memory allocations.

Interesting approach. Did you actually find any leaks with this? 

What looks a bit dubious is how objects reuse is handled. You can't
distingush an reused object from an old leaked pointer. But due
to the way slab allocates this should be pretty common. I guess
for your approach to be effective slab would need to be changed
to a queue?

-Andi

