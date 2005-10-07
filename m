Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbVJGTKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbVJGTKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 15:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbVJGTKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 15:10:49 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:28318 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1030472AbVJGTKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 15:10:48 -0400
Subject: Re: 2.6.14-rc3-rt10 crashes on boot
From: John Rigg <lk@sound-man.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Message-Id: <E1ENxhr-0001CH-12@localhost.localdomain>
Date: Fri, 07 Oct 2005 20:16:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 7 Steve Rostedt wrote:

>Add this patch and it will add the option for you in x86_64 (I forgot that
>you were using that).  I even set it to be default on. I didn't add a test
>in do_IRQ, but I believe that the tests in latency.c should be good
>enough.

Hi Steve,

Thanks for the patch. I applied it to 2.6.14-rc3-rt12, looked in
arch/x86_64/Kconfig.debug just to be sure it applied OK to -rt12,
then ran make. It failed to compile, with the following message:

  CC      kernel/rt.o
  CC      kernel/latency.o
kernel/latency.c: In function '__print_worst_stack':
kernel/latency.c:336: warning: format '%d' expects type 'int', but argument 5 has type 'long unsigned int'
kernel/latency.c:384:3: error: #error Poke the author of above asm code line !
kernel/latency.c: In function 'debug_stackoverflow':
kernel/latency.c:386: error: 'STACK_WARN' undeclared (first use in this function)
kernel/latency.c:386: error: (Each undeclared identifier is reported only once
kernel/latency.c:386: error: for each function it appears in.)
make[1]: *** [kernel/latency.o] Error 1
make: *** [kernel] Error 2

I wonder if DEBUG_STACKOVERFLOW was left out of x86_64 for this reason.

John
