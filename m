Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277229AbRJLFKg>; Fri, 12 Oct 2001 01:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277228AbRJLFK1>; Fri, 12 Oct 2001 01:10:27 -0400
Received: from [202.135.142.196] ([202.135.142.196]:23300 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S277229AbRJLFKP>; Fri, 12 Oct 2001 01:10:15 -0400
Date: Fri, 12 Oct 2001 15:06:06 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-Id: <20011012150606.5d522fda.rusty@rustcorp.com.au>
In-Reply-To: <9q20a2$2cg$1@penguin.transmeta.com>
In-Reply-To: <OF206EE8AA.7A83A16B-ON88256AE1.005467E3@boulder.ibm.com>
	<20011010185848.D726@athlon.random>
	<9q20a2$2cg$1@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001 17:25:22 +0000 (UTC)
torvalds@transmeta.com (Linus Torvalds) wrote:

> Absolutely.  It's not that expensive an operation on sane hardware.  And
> it's definitely conceptually the only right thing to do - we're saying
> that we're doing a read that depends on a previous read having seen
> previous memory.  Ergo, "rmb()". 

Accessing pointer contents after you dereference the pointer is "obvious":
we've been trying to get Richard to understand the problem for FIVE MONTHS,
and he's not stupid!

The PPC manual (thanks Paul M) clearly indicates rmbdd() is not neccessary.
That they mention it explicitly suggests it's going to happen on more
architectures: you are correct, we should sprinkle rmbdd() everywhere
(rmb() is heavy on current PPC) and I'll update the Kernel Locking Guide now
the rules have changed.[1]

Rusty.
[1] Aren't we lucky our documentation is so sparse noone can accuse us of being
    inconsistent? 8)
