Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTEUJjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTEUJjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:39:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29106 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261835AbTEUJjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:39:05 -0400
Date: Wed, 21 May 2003 11:48:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-Reply-To: <20030521023627.F07062C015@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0305211140120.2045-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 May 2003, Rusty Russell wrote:

> Perhaps I was reading too much into Linus' mail, but I read it as "don't
> obsolete the old interface and introduce a new one just because of some
> sense of aesthetics".

no. The concept is: "dont cause the user any pain". Reshuffling the
syscall internally and providing new interfaces for the feature to be
exposed in a cleaner way is perfectly OK as long as this does not hurt
anything else - and it does not in this case. New glibc will use the new
syscalls and will fall back to the old one if they are -ENOSYS, so new
glibc will work on older kernels as well. Old glibc will work with old
kernels and new kernels as well. This is being done for other interfaces
currently, this is the only mechanism to 'flush out' old syscalls
gracefully.

the newer a kernel and a glibc is, the less 'fallback' happens - the
faster the application is, so this compatibility scheme makes perfect
sense both support-wise and technically. (not counting the speedup caused
by the interface cleanups themselves)

not adding FUTEX_REQUEUE to the old syscall is the right solution - it was
never exposed to anyone in this way, so old glibc doesnt know about it -
and new glibc will never use the old interfaces.

any other disagreements?

	Ingo


