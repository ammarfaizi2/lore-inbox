Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUEOFjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUEOFjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 01:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUEOFjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 01:39:09 -0400
Received: from hierophant.serpentine.com ([66.92.13.71]:29153 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S262906AbUEOFjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 01:39:06 -0400
Subject: Re: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andi Kleen <ak@muc.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
In-Reply-To: <m3oeorvy58.fsf@averell.firstfloor.org>
References: <1VLRr-38z-19@gated-at.bofh.it>
	 <m3oeorvy58.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1084599456.4895.103.camel@obsidian.pathscale.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 14 May 2004 22:37:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-14 at 08:14, Andi Kleen wrote:

> Before merging all that I would definitely recommend some generic
> module to allocate performance counters. IBM had a patch for this
> long ago, and it is even more needed now.

That's currently handled in user space, by PAPI (which sits on top of
perfctr).  One reason *not* to do it in the kernel is the bloat it would
entail; just look at the horrendous mess that is the P4 performance
counter event selector.

> Why do you check for K8 C stepping? I don't see any code that
> does anything special with that.

The reason it's interesting at all is that it's the first K8 stepping
that introduces new performance counter unit masks.  The kernel driver
already passes its notion of what the CPU type is up to userspace. 
(Clearly, userspace could figure this out, since it's just parsing the
cpuid instruction.)

It also checks the CPU type in a few places internally; it just doesn't
happen to care internally about K8 stepping C.  Thoroughness?

	<b

