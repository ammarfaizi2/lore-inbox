Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbUKDDkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbUKDDkd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 22:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUKDDkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 22:40:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:56536 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261174AbUKDDka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 22:40:30 -0500
Date: Wed, 3 Nov 2004 19:40:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: avoid asmlinkage on x86 traps/interrupts
In-Reply-To: <20041104020835.GL3571@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0411031938480.2187@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411021250310.2187@ppc970.osdl.org>
 <20041103090710.GV3571@dualathlon.random> <Pine.LNX.4.58.0411030719061.2187@ppc970.osdl.org>
 <20041104020835.GL3571@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Nov 2004, Andrea Arcangeli wrote:
> 
> I wonder why they don't forbid it completely then. I mean, what's magic
> about an input parmeter here? Clobbers are about the internals of
> the asm

Actually, they are mostly about register allocation. And that's apparently 
why the gcc rules ended up changing: by setting a clobber, you basically 
allocate that register for the instruction, and tell gcc that it's dead.

That's also likely why such a register cannot be an input (or an output): 
it cannot be allocated.

		Linus
