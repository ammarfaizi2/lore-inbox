Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWFXBxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWFXBxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 21:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWFXBxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 21:53:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38047 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750783AbWFXBxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 21:53:50 -0400
Date: Fri, 23 Jun 2006 18:47:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <acahalan@gmail.com>
cc: linux-kernel@vger.kernel.org, 76306.1226@compuserve.com, ak@muc.de,
       akpm@osdl.org
Subject: Re: i386 ABI and the stack
In-Reply-To: <787b0d920606231837k5d57da8ct5c511def6c035176@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0606231844460.6483@g5.osdl.org>
References: <787b0d920606231837k5d57da8ct5c511def6c035176@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jun 2006, Albert Cahalan wrote:
> 
> Exactly how is an access below %esp a bug if we just added support?

It's always a bug on x86.

Signal handlers will overwrite the stack, so if you use the stack before 
decrementing the stack pointer, you're fundamentally screwed.

The "enter" (and "pusha" etc) instructions are special and magical, 
because they _will_ decrement the stack pointer atomically if they 
succeed.

> It seems that we're throwing away performance if we discourage
> the compiler from taking advantage of this area to optimize
> leaf functions and perhaps improve instruction scheduling.

We always have. It's the x86 ABI.

The x86-64 ABI has a 128-byte(*) zone that is safe from signals etc, so 
you can use a small amount of stack below the stackpointer safely. Not so 
on x86.

		Linus

(*) That "128 byte" is from memory. Maybe it's bigger.
