Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290380AbSAXWJC>; Thu, 24 Jan 2002 17:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290381AbSAXWIx>; Thu, 24 Jan 2002 17:08:53 -0500
Received: from zero.tech9.net ([209.61.188.187]:17 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290380AbSAXWIj>;
	Thu, 24 Jan 2002 17:08:39 -0500
Subject: Re: RFC: booleans and the kernel
From: Robert Love <rml@tech9.net>
To: root@chaos.analogic.com
Cc: Oliver Xymoron <oxymoron@waste.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020124165419.1859A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020124165419.1859A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 17:13:05 -0500
Message-Id: <1011910400.966.17.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-24 at 16:55, Richard B. Johnson wrote:

> Don't you wish!
> [snip]
> 	cmpl $0,8(%ebp)      <-------------- Compare against zero.

Ah, but you compiled without optimization.  Using your example program,
`gcc -Wall -S example.c' gives me the same output as you.  But with -O2
I get:

foo:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %edx
	xorl	%eax, %eax
	testl	%edx, %edx
	sete	%al
	popl	%ebp
	ret

Which is the XOR and self-test with no constant Oliver described.

	Robert Love

