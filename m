Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVL1PmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVL1PmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 10:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVL1PmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 10:42:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:17852 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964847AbVL1PmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 10:42:01 -0500
Date: Wed, 28 Dec 2005 16:41:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 02/2] allow gcc4 to optimize unit-at-a-time
Message-ID: <20051228154138.GA18798@elte.hu>
References: <20051228114701.GC3003@elte.hu> <p734q4tb5na.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p734q4tb5na.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> But one caveat: turning on unit-at-a-time makes objdump -S / make 
> foo/bar.lst with CONFIG_DEBUG_INFO essentially useless because objdump 
> cannot deal with functions being out of order in the object file. This 
> can be a big problem while analyzing oopses - essentially you have to 
> analyze the functions without source level information. And with 
> unit-at-a-time they become bigger so it's more difficult.
> 
> But I still think it's a good idea.

hm, i dont seem to have problems with DEBUG_INFO. I picked a random 
address within the kernel:

c035766f T schedule_timeout

(gdb) list *0xc035768f
0xc035768f is in schedule_timeout (kernel/timer.c:1075).
1070                     * should never happens anyway). You just have the printk()
1071                     * that will tell you if something is gone wrong and where.
1072                     */
1073                    if (timeout < 0)
1074                    {
1075                            printk(KERN_ERR "schedule_timeout: wrong timeout "
1076                                    "value %lx from %p\n", timeout,
1077                                    __builtin_return_address(0));
1078                            current->state = TASK_RUNNING;
1079                            goto out;
(gdb)

or is it something else that breaks?

	Ingo
