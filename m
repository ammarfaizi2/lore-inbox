Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbTEILjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbTEILjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:39:49 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:41462 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262485AbTEILjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:39:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16059.38513.197275.134938@gargle.gargle.HOWL>
Date: Fri, 9 May 2003 13:52:17 +0200
From: mikpe@csd.uu.se
To: Andi Kleen <ak@muc.de>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
In-Reply-To: <20030509113845.GA4586@averell>
References: <3EBB5A44.7070704@redhat.com>
	<20030509092026.GA11012@averell>
	<16059.37067.925423.998433@gargle.gargle.HOWL>
	<20030509113845.GA4586@averell>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > 
 > On Fri, May 09, 2003 at 01:28:11PM +0200, mikpe@csd.uu.se wrote:
 > > I have a potential use for mmap()ing in the low 4GB on x86_64.
 > 
 > Just use MAP_32BIT

Will that be corrected to use the full 4GB space? 2GB is too small.

 > > Sounds like your MAP_32BIT really is MAP_31BIT :-( which is too limiting.
 > > What about a more generic way of indicating which parts of the address
 > > space one wants? The simplest that would work for me is a single byte
 > > 'nrbits' specifying the target address space as [0 .. 2^nrbits-1].
 > > This could be specified on a per-mmap() basis or as a settable process attribute.
 > 
 > On x86-64 an mmap extension for that would be fine, but on i386 you get
 > problems because mmap64() already maxes out the argument limit and you 
 > cannot add more.

This would only be used on x86_64. i386 compat is a non-issue.
(This is for runtime systems stuff, not applictions.)

 > prctl is probably better. You really want [start; end] right ? 

I just want mmap() to return addresses that fit in 32 bits.

MAP_32BIT would do nicely, if it wasn't limited to 2GB.

/Mikael
