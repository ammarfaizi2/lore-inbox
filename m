Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVC3WL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVC3WL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVC3WL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:11:27 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:38200 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S262458AbVC3WLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:11:04 -0500
Date: Wed, 30 Mar 2005 16:10:42 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: tripperda@nvidia.com
Subject: question about do_IRQ + 4k stacks
Message-ID: <20050330221042.GZ2104@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 30 Mar 2005 22:11:02.0555 (UTC) FILETIME=[5C474EB0:01C53575]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm investigating some 4k stack issues with our driver, and I noticed
this ordering in do_IRQ:

asmlinkage unsigned int do_IRQ(struct pt_regs regs)
{
	...

#ifdef CONFIG_DEBUG_STACKOVERFLOW
        /* Debugging check for stack overflow: is there less than 1KB free? */
        {
	...
        }
#endif

	...

#ifdef CONFIG_4KSTACKS

        for (;;) {
	... switch to interrupt stack
        }
#endif


Is the intention of this stack overflow check to catch a currently
running kernel thread that's getting low on stack space, or is the
intent to make sure there's enough stack space to handle the incoming
interrupt? if the later, wouldn't you want to potentially switch to
your interrupt stack to be more accurate? (I recognize that often you
will have switched to an empty stack, unless you have nested
interrupts)

Thanks,
Terence

