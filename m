Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUB1KnF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 05:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUB1KnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 05:43:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20641 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261605AbUB1KnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 05:43:01 -0500
Date: Sat, 28 Feb 2004 05:42:52 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: davidm@hpl.hp.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: [patch] u64 casts
Message-ID: <20040228104252.GG31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1077915522.2255.28.camel@cube> <16447.56941.774257.925722@napali.hpl.hp.com> <1077920213.2233.44.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077920213.2233.44.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 05:16:53PM -0500, Albert Cahalan wrote:
> Supposing that this is the case, you may get warnings.

It wouldn't be just about warnings if somebody uses current kernel
headers for /usr/include/linux and /usr/include/asm.
Think about C++ name mangling, there it matters a lot of
a type is long long or just long, although they are the same size.

It is true that (hopefully) most of the distributions use separate
modified kernel headers and glibc uses only very few kernel headers
in its headers, but there are certainly many apps in the wild
who #include <linux/*> or #include <asm/*> and I'm afraid still some
people use newest kernel headers for userland stuff.

So if you want to change that, I'd suggest to
#ifdef __KERNEL__
typedef unsigned long long __u64;
#else
typedef unsigned long __u64; /* Provided it has been defined that way before */
#endif

	Jakub
