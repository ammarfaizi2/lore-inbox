Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270625AbTHAAou (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 20:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270632AbTHAAou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 20:44:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:37110 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270625AbTHAAot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 20:44:49 -0400
Date: Thu, 31 Jul 2003 17:47:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic on 2.6.0-test1-mm1
Message-ID: <390810000.1059698875@flay>
In-Reply-To: <20030731223710.GI15452@holomorphy.com>
References: <5110000.1059489420@[10.10.2.4]> <20030731223710.GI15452@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jul 29, 2003 at 07:37:00AM -0700, Martin J. Bligh wrote:
>> The big box had this on the console ... looks like it was doing a
>> compile at the time ... sorry, only just noticed it after returning
>> from OLS, so don't have more context (2.6.0-test1-mm1).
>> kernel BUG at include/linux/list.h:149!
>> invalid operand: 0000 [#1]
>> SMP 
>> CPU:    3
>> EIP:    0060:[<c0117f98>]    Not tainted VLI
>> EFLAGS: 00010083
>> EIP is at pgd_dtor+0x64/0x8c
> 
> This is on PAE, so you're in far deeper trouble than I could have caused:
> 
>         pgd_cache = kmem_cache_create("pgd",
>                                 PTRS_PER_PGD*sizeof(pgd_t),
>                                 0,
>                                 SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
>                                 pgd_ctor,
>                                 PTRS_PER_PMD == 1 ? pgd_dtor : NULL);
> 
> You've applied mingo's patch, which needs to check for PAE in certain
> places like the above. Backing out highpmd didn't make this easier, it
> just gave you performance problems because now all your pmd's are stuck
> on node 0 and another side-effect of those changes is that you're now
> pounding pgd_lock on 16x+ boxen. You could back out the preconstruction
> altogether, if you're hellbent on backing out everyone else's patches
> until your code has nothing to merge against.

I think this was just virgin -mm1, I can go back and double check ...
Not sure what the stuff about backing out other peoples patches was
all about, I just pointed out the crash.

Andrew had backed out highpmd for other reasons before I even mailed
this out, if that's what your knickers are all twisted about ... I have
no evidence that was causing the problem ... merely that it goes away
on -test2-mm1 ... it was Andrew's suggestion, not mine.

M.

