Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTEIL0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbTEIL0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:26:22 -0400
Received: from zero.aec.at ([193.170.194.10]:18699 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262457AbTEIL0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:26:19 -0400
Date: Fri, 9 May 2003 13:38:45 +0200
From: Andi Kleen <ak@muc.de>
To: mikpe@csd.uu.se
Cc: Andi Kleen <ak@muc.de>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
Message-ID: <20030509113845.GA4586@averell>
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16059.37067.925423.998433@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, May 09, 2003 at 01:28:11PM +0200, mikpe@csd.uu.se wrote:
> I have a potential use for mmap()ing in the low 4GB on x86_64.

Just use MAP_32BIT

> Sounds like your MAP_32BIT really is MAP_31BIT :-( which is too limiting.
> What about a more generic way of indicating which parts of the address
> space one wants? The simplest that would work for me is a single byte
> 'nrbits' specifying the target address space as [0 .. 2^nrbits-1].
> This could be specified on a per-mmap() basis or as a settable process attribute.

On x86-64 an mmap extension for that would be fine, but on i386 you get
problems because mmap64() already maxes out the argument limit and you 
cannot add more.
 
You could only implement it with a structure in memory pointed to by an
argument, which would be ugly.

prctl is probably better. You really want [start; end] right ? 

Pity that task_struct is already so bloated, so every new entry hurts.

-Andi

