Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVKKUWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVKKUWT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVKKUWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:22:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751155AbVKKUWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:22:18 -0500
Date: Fri, 11 Nov 2005 12:22:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
In-Reply-To: <4374FB89.6000304@vmware.com>
Message-ID: <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Nov 2005, Zachary Amsden wrote:
> 
> Yes, this is fine, but is it worth writing the feature discovery code?  I
> suppose it doesn't matter, as it gets jettisoned after init.  I guess it is
> just preference.

Well, you could do the feature discovery by trying to take a fault early 
at boot-time. That's how we verify that write-protect works, and how we 
check that math exceptions come in the right way..

> Could we consider doing the same with LOCK prefix for SMP kernels booted on
> UP?  Evil grin.

Not so evil - I think it's been discussed. Not with alternates (not worth 
it), but it wouldn't be hard to do: just add a new section for "lock 
address", and have each inline asm that does a lock prefix do basically

	1:
		lock ; xyzzy

	.section .lock.address
	.long 1b
	.previous

and then just walk the ".lock.address" thing and turn all locks into 0x90 
(nop).

		Linus
