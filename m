Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUHVUV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUHVUV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 16:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268189AbUHVUV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 16:21:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:39579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268209AbUHVUVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 16:21:21 -0400
Date: Sun, 22 Aug 2004 13:21:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Keith Owens <kaos@sgi.com>
Subject: Re: [PATCH][1/4] Completely out of line spinlocks / i386
In-Reply-To: <Pine.LNX.4.58.0408211320520.27390@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0408221318060.17766@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408211320520.27390@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Aug 2004, Zwane Mwaikambo wrote:
>
> Pulled from the -tiny tree, the focus of this patch is for reduced kernel
> image size but in the process we benefit from improved cache performance
> since it's possible for the common text to be present in cache. This is
> probably more of a win on shared cache multiprocessor systems like
> P4/Xeon HT. It's been benchmarked with bonnie++ on 2x and 4x PIII (my
> ideal target would be a 4x+ logical cpu Xeon).

I _really_ think that if we're going to make spinlocks be out-of-line, 
then we need to out-of-line the preemption code too.

And at that point I'm more than happy to just make it unconditional,
assuming the profiling thing (which was my only worry) has been verified.

And I suspect that the all-C version is pretty much equivalent to the
assembler one, if you use FASTCALL() to make gcc at least use register 
argument passing conventions. The advantage is much clearer code, I'd say.

		Linus
