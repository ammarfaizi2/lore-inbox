Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVJQHEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVJQHEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVJQHEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:04:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17053 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750901AbVJQHEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:04:34 -0400
Date: Mon, 17 Oct 2005 00:03:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8
 bits
Message-Id: <20051017000343.782d46fc.akpm@osdl.org>
In-Reply-To: <434BEA0D.9010802@cosmosbay.com>
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
	<1129035658.23677.46.camel@localhost.localdomain>
	<Pine.LNX.4.64.0510110740050.14597@g5.osdl.org>
	<434BDB1C.60105@cosmosbay.com>
	<Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
	<434BEA0D.9010802@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
>  2) The unlock sequence is not anymore inlined. It appears twice or three times 
>  in the kernel.

Is that intentional though?  With <randon .config> my mm/swapfile.i has an
unreferenced

static inline void __raw_spin_unlock(raw_spinlock_t *lock)
{
	__asm__ __volatile__(
		"movb $1,%0" :"=m" (lock->slock) : : "memory" 
	);
}

which either a) shouldn't be there or b) should be referenced.

Ingo, can you confirm that x86's spin_unlock is never inlined?  If so,
what's my __raw_spin_unlock() doing there?

