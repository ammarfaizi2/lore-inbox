Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUGLTgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUGLTgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUGLTgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:36:48 -0400
Received: from mail-relay-4.tiscali.it ([212.123.84.94]:34726 "EHLO
	sparkfist.tiscali.it") by vger.kernel.org with ESMTP
	id S261875AbUGLTgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:36:25 -0400
Date: Mon, 12 Jul 2004 21:36:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040712193606.GP20947@dualathlon.random>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040709235017.GP20947@dualathlon.random> <20040710005208.GW20947@dualathlon.random> <s5hpt71cyxq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpt71cyxq.wl@alsa2.suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 12:17:05PM +0200, Takashi Iwai wrote:
> Couldn't it be simply written like below?
> 
> #define BUILD_BUG_ON(condition) do { if (unlikely(condition)) BUILD_BUG(); } while(0)

BUILD_BUG_ON is a different thing. the "condition" is meant to be
evaluated at _compile_ time, not at runtime (so the unlikely is useless
since the compiler knows the result before it generates the bytecode).
This is why BUILD_BUG() isn't implemented anywhere, so you get a linker
error during the compilation.

For example with it you can do things like:

	BUILD_BUG_ON(offsetof(struct task_struct, thread.i387.fxsave) & 15);

(see asm-i386/bugs.h, it's doing the BUILD_BUG_ON by hand right now)
