Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTEILPp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTEILPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:15:45 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:27636 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262444AbTEILPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:15:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16059.37067.925423.998433@gargle.gargle.HOWL>
Date: Fri, 9 May 2003 13:28:11 +0200
From: mikpe@csd.uu.se
To: Andi Kleen <ak@muc.de>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
In-Reply-To: <20030509092026.GA11012@averell>
References: <3EBB5A44.7070704@redhat.com>
	<20030509092026.GA11012@averell>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > On Fri, May 09, 2003 at 09:35:32AM +0200, Ulrich Drepper wrote:
 > > It would be much better if there would also be a MAP_32PREFER flag with
 > > the appropriate semantics.  The failing mmap() calls seems to be quite
 > > expensive so programs with many threads are really punished a lot.
 > 
 > That's just an inadequate data structure. It does an linear search of the
 > VMAs and you probably have a lot of them. Before you add kludges like this 
 > better fix the data structure for fast free space lookup.
 > 
 > MAP_32BIT currently limits to the first 2GB only. That's needed because
 > most programs use it to allocate modules for the small code model and that
 > only supports 2GB (poster child for that is the X server) But for your 
 > application 4GB would be better. But adding another MAP_32BIT_4GB or so
 > would be quite ugly. I considered making the address where mmap starts searching
 > (TASK_UNMAPPED_BASE) settable using a prctl.

I have a potential use for mmap()ing in the low 4GB on x86_64.
Sounds like your MAP_32BIT really is MAP_31BIT :-( which is too limiting.
What about a more generic way of indicating which parts of the address
space one wants? The simplest that would work for me is a single byte
'nrbits' specifying the target address space as [0 .. 2^nrbits-1].
This could be specified on a per-mmap() basis or as a settable process attribute.

/Mikael
