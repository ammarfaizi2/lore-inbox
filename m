Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264629AbSLVPYz>; Sun, 22 Dec 2002 10:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbSLVPYz>; Sun, 22 Dec 2002 10:24:55 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:33922 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S264629AbSLVPYy>;
	Sun, 22 Dec 2002 10:24:54 -0500
Date: Sun, 22 Dec 2002 15:32:29 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>, bart@etpmod.phys.tue.nl,
       davej@codemonkey.org.uk, hpa@transmeta.com, terje.eggestad@scali.com,
       matti.aarnio@zmailer.org, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021222153229.GA30269@bjl1.asuk.net>
References: <Pine.LNX.4.44.0212211858240.8783-100000@home.transmeta.com> <Pine.LNX.4.44.0212221111080.31068-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212221111080.31068-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> and i'm 100% sure the more robust eflags saving will also avoid security
> holes. The amount of security-relevant complexity that comes from all the
> x86 features [and their combinations] is amazing.

Userspace can skip the "popfl" with a well-timed signal.  If the
"sysexit" path leaves the kernel with an unsafe eflags, that will
propagate into the signal handler.

AFAICT, one of these is required:

	1. eflags must be safe before leaving kernel space, or
	2. setup_sigcontext() must clean it up (it already does clear TF).

-- Jamie
