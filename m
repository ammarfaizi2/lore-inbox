Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbVKMTZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbVKMTZT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 14:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVKMTZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 14:25:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750835AbVKMTZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 14:25:18 -0500
Date: Sun, 13 Nov 2005 11:24:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
In-Reply-To: <20051113074241.GA29796@redhat.com>
Message-ID: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com>
 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 Nov 2005, Dave Jones wrote:
> 
> Looks like the Ubuntu people already did this...

Yeah, that looks like a sane patch, although I dislike the #ifdef config 
option thing (either it works or it doesn't).

It also does it the right way: using LOCK_PREFIX means that you catch 
exactly the users that depend on SMP, and not _all_ "lock" prefixes (as 
mentioned, some of the lock prefixes are there as memory fences and are 
valid and needed even on UP). So me likee.

The only question being whether you'd actually want to nop out the 
spinlock instructions _entirely_ (in addition to changing the nops on 
things like semaphores). Without the lock, they're not that expensive, but 
hey, it's still a useless (memory-modifying) instruction.

		Linus
