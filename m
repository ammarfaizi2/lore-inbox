Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264067AbUEXGYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbUEXGYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUEXGYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:24:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:42892 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264057AbUEXGY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:24:29 -0400
Date: Mon, 24 May 2004 10:25:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
Message-ID: <20040524082522.GA23725@elte.hu>
References: <20040523194302.81454.qmail@web90007.mail.scd.yahoo.com> <Pine.LNX.4.58.0405231329460.25502@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405231329460.25502@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Quite frankly, a number of us are hoping that we can make them
> unnecessary. The cost of the 4g/4g split is absolutely _huge_ on some
> things, including basic stuff like kernel compiles.
>
> The only valid reason for the 4g split is that the VM doesn't always
> behave well with huge amounts of highmem. The anonvma stuff in
> 2.6.7-pre1 is hoped to make that much less of an issue.
>
> Personally, if we never need to merge 4g for real, I'll be really
> really happy. I see it as a huge ugly hack.

i agree with the hack part - but the performance aspect has been blown
out of proportion. 4:4 has the same cost on kernel compiles as highpte.
There are also real workloads where it actually helps performance.

also, the 4:4 overhead is really a hardware problem - and there are
x86-compatible CPUs (amd64) where the TLB flush problem has already been
solved: on amd64 the 4:4 feature has no noticeable overhead. So as long
as people opt for a 32-bit OS (even on a 64-bit CPU, for whatever weird
compatibility reason), 4:4 can be useful. For the other workloads i as
much hope as everyone else that people switch to a 64-bit OS on x86-64
ASAP!

also, while a quick transition to x86-64 will most likely happen, the
large installed base of big x86 boxes is a matter of fact too - and they
wont vanish into thin air. Also, there will always be specific user
workloads where lowmem grows to large values. Not to mention the fact
that 4:4 is a nice debugging/security tool as you cannot dereference
user pointers ;) - it has caught countless bugs already. Plus there are
specific workloads that want 4GB of userspace (and no, 3.5 GB wont do).

So 4:4 will have its niches where it will live on. We could argue on and
on how quickly 'x86 with more than 4GB of RAM' and 'x86 with 4GB of a
userspace' will become a niche, hopefully it happens fast but we've got
to keep our options open.

	Ingo
