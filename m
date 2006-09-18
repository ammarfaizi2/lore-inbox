Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWIRWwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWIRWwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWIRWwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:52:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030241AbWIRWwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:52:37 -0400
Date: Mon, 18 Sep 2006 15:52:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       billm@melbpc.org.au, billm@suburbia.net
Subject: Re: Math-emu kills the kernel on Athlon64 X2
In-Reply-To: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609181549200.4388@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Sep 2006, Jesper Juhl wrote:
> 
> If I enable the math emulator in 2.6.18-rc7-git2 (only version I've
> tried this with) and then boot the kernel with "no387" then I only get
> as far as lilo's "...Booting the kernel." message and then the system
> hangs.

I'm wondering if it tries to use the MMX/XMM stuff for memcpy and friends. 

I'm also wondering why you'd be doing what you seem to try to be doing in 
the first place ;)

Basically, "no387" doesn't seem to disable any of the fancier FPU 
features, even though it obviously should. If you ask for math emulation, 
you'll get emulation faults for _all_ of the modern MMX stuff too (which 
we don't do). 

It's entirely possible that nobody has ever tested this combination.

		Linus
