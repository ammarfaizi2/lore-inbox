Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262424AbSJNUop>; Mon, 14 Oct 2002 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbSJNUop>; Mon, 14 Oct 2002 16:44:45 -0400
Received: from zero.aec.at ([193.170.194.10]:57100 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262424AbSJNUoi>;
	Mon, 14 Oct 2002 16:44:38 -0400
To: Daniele Lugli <genlogic@inrete.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
References: <3DAB1F00.667B82B5@inrete.it>
From: Andi Kleen <ak@muc.de>
Date: 14 Oct 2002 22:45:30 +0200
In-Reply-To: <3DAB1F00.667B82B5@inrete.it>
Message-ID: <m33cr8kavp.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Lugli <genlogic@inrete.it> writes:

> *** one of my data structures has a field named 'current'. ***
> 
> Pretty common word, isn't it? Would you think it can cause such a
> trouble? But in some of my files I happen to indirectly include
> <asm/current.h> (kernel 2.4.18 for i386), containing the following line:
> 
> #define current get_current()

How about changing the definition to: 

#define current ((struct task_struct *)get_current()) 

That should get the same effect as currently for kernel code, but 
will guarantee a syntax error if it's used in a structure declaration.

-Andi
