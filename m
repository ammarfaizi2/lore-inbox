Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbTDAXDe>; Tue, 1 Apr 2003 18:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbTDAXDe>; Tue, 1 Apr 2003 18:03:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37124 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262908AbTDAXDd>; Tue, 1 Apr 2003 18:03:33 -0500
Date: Tue, 1 Apr 2003 15:13:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Wayne Whitney <whitney@math.berkeley.edu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.65: Caching MSR_IA32_SYSENTER_CS kills dosemu
In-Reply-To: <1049235419.754.2.camel@localhost>
Message-ID: <Pine.LNX.4.44.0304011512190.13867-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 Apr 2003, Robert Love wrote:
> 
> Actually, do they do disable preemption - if they do not, something is
> broken.

Ok, I was too lazy to check. Anyway, the test-patch is worth trying, since
one of the areas fixed had no pre-emption protection regardless (ie it
used just a plain "smp_processor_id()"), and the patch should be
technically equivalent (just uglier) to a proper get_cpu().

> Because, even on UP, preemption can lead to a race over a variable that
> has no locking because its per-CPU.  But it would need locking
> otherwise, and thus we do need to disable preemption.

Yes, that was certainly the case here.

		Linus

