Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWDKLzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWDKLzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWDKLzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:55:37 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:34011 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750779AbWDKLzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:55:37 -0400
Date: Tue, 11 Apr 2006 13:55:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Detecting illegal memory access
In-Reply-To: <Pine.LNX.4.61.0604110730090.29083@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0604111350050.928@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0604111230190.928@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0604110730090.29083@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>A user program can trap EFAULT.

There are no syscalls involved. It is a [arch-dependent] stack backtrace 
that walks up EBP. But object files compiled with -fomit-frame-pointer have 
random values in %ebp. So when doing

    ebp = *(void **)ebp;

it either succeeds or throws SIGSEGV. Catching signals is catchy because 
the backtrace might be done in a threaded application. Does *jmp() work 
with threads?


>However, you need to use siglongjmp()
>to get back into your program and continue, plus you need to do very
>careful coding to mask and unmask the appropriate signals though it
>all. Since protection is on a per-page basis, one could make a program
>that attempts to R/W from virtual page 0 on up, recoding success or
>failure for each page.


Jan Engelhardt
-- 
