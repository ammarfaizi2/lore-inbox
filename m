Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVJCDYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVJCDYj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 23:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVJCDYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 23:24:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60818 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932132AbVJCDYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 23:24:38 -0400
Date: Sun, 2 Oct 2005 20:24:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
cc: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
In-Reply-To: <2cd57c900510021954l20488718n20b06f2cbc6c567d@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0510022015470.31407@g5.osdl.org>
References: <433C0F3D.30C19186@tv-sign.ru>  <Pine.LNX.4.58.0509290901060.3308@g5.osdl.org>
 <2cd57c900510021954l20488718n20b06f2cbc6c567d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Oct 2005, Coywolf Qi Hunt wrote:
> 
> The inequality comparisons are faster or faster on some CPU.
> We should use it if we can keep the order IMHO.

Which CPU are you talking about? Inequality is almost never faster than a 
logical op.

Any CPU I can think of has a "and + compare against zero". x86 calls it 
"test", although a regular "and" will do it too. ppc has "andi.". alpha 
comparisons are against registers being zero or not, so again it's an 
"and".

And there are very few ALU's that don't do logicals (they're much simpler 
than an adder), although I seem to remember that the P4 was odd in that 
respect (with the second ALU being limited to some strange subcases).

So I don't think that ends up being a concern in real life. 

		Linus
