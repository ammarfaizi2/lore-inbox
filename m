Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUHLGva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUHLGva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 02:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268431AbUHLGva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 02:51:30 -0400
Received: from holomorphy.com ([207.189.100.168]:43657 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268425AbUHLGu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 02:50:57 -0400
Date: Wed, 11 Aug 2004 23:50:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] 2.6.8-rc4-mm1 - UML fixes
Message-ID: <20040812065047.GG11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jeff Dike <jdike@addtoit.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200408120415.i7C4FWJd010494@ccure.user-mode-linux.org> <20040812033012.GE11200@holomorphy.com> <200408120541.i7C5fIJd010913@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408120541.i7C5fIJd010913@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli@holomorphy.com said:
>> Out of curiosity, why are you allocating 4*PAGE_SIZE for the stack if
>> you're only going to use 2*PAGE_SIZE of it? I saw no other users for
>> the rest of ->thread_info offhand. 

On Thu, Aug 12, 2004 at 01:41:18AM -0400, Jeff Dike wrote:
> Well, that's slightly misleading.  The other two pages (minus the thread_info)
> are available for stack if needed.  UML stacks are somewhat larger than the
> native kernel stacks because of the userspace signal frames, so I allocate
> 4 pages for now to be safe.

This might confuse CONFIG_DEBUG_PAGEALLOC, which uses THREAD_SIZE to
detect the end of the kernel stack in store_stackinfo() in mm/slab.c
and kstack_end() in include/linux/sched.h, and the sizing heuristic
for max_threads in fork_init().

Also, how is this meant to interoperate with CONFIG_KERNEL_STACK_ORDER?
It seems to ignore the setting from the config option.


-- wli
