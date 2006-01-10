Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWAJOzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWAJOzX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWAJOzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:55:22 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:30997 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751094AbWAJOzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:55:22 -0500
X-IronPort-AV: i="3.99,351,1131350400"; 
   d="scan'208"; a="248116494:sNHT31025692"
To: Andrew Morton <akpm@osdl.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1136579193@eng-12.pathscale.com>
	<d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
	<20060110011844.7a4a1f90.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 10 Jan 2006 06:55:17 -0800
In-Reply-To: <20060110011844.7a4a1f90.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 10 Jan 2006 01:18:44 -0800")
Message-ID: <adaslrw3zfu.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 10 Jan 2006 14:55:19.0163 (UTC) FILETIME=[DFBEC4B0:01C615F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> This arch-independent routine copies data to a
    Bryan> memory-mapped I/O region, using 32-bit accesses.  It does
    Bryan> not guarantee access ordering, nor does it perform a memory
    Bryan> barrier afterwards.  This style of access is required by
    Bryan> some devices.

    Andrew> Not providing orderingor barriers makes this a rather
    Andrew> risky thing to export - people might use it, find their
    Andrew> driver "works" on one architecture, but fails on another.

    Andrew> I guess the "__" is a decent warning of this, and the
    Andrew> patch anticipates a higher-level raw_memcpy_toio32() which
    Andrew> implements those things, yes?

I suggested the __raw_ name to parallel __raw_writel and friends.  The
name for the version that ends with a write barrier would presumably
be just "memcpy_toio32()".  Bryan could easily add that his patch as
well, even though the Pathscale driver will only use the __raw_ version.

    Andrew> How come __raw_memcpy_toio32() is inlined?

That is a good question, especially since the optimized
x86_64-specific version is out-of-line.  I suspect the answer is
mainly that that's the easiest way to stick it in a header in
include/asm-generic.  I think it would be worth working a little
harder and making the generic version out-of-line.
