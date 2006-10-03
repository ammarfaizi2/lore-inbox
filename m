Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWJCL2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWJCL2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 07:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWJCL2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 07:28:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20928 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750707AbWJCL2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 07:28:24 -0400
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2 II --
	it's terminally broken
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Linus Torvalds <torvalds@osdl.org>,
       akpm <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200610031211.46168.ak@suse.de>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
	 <20061002202426.aa3ecb4f.rdunlap@xenotime.net>
	 <200610031211.46168.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Oct 2006 12:53:34 +0100
Message-Id: <1159876414.17553.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-03 am 12:11 +0200, ysgrifennodd Andi Kleen:
> On Tuesday 03 October 2006 05:24, Randy Dunlap wrote:
> 
> Actually I looked at the code more closely. It looks like kernel math
> emulation is much more broken. e.g. kernel_fpu_begin() is missing
> code and lots of other paths in i387 that need to check HAVE_HWFP don't.

That check would be wrong anyway. A kernel built with FPU emulation
boots, runs and uses the hardware FPU code correctly. The problem area
is the X86_FEATURE_foo stuff. I think that comes down to a single thing
- if we have FPU disabled clear X86_FEATURE_FXSR|X86_FEATURE_MMX|
X86_FEATURE_SSE* in the boot cpu features during early option
parsing/setup. Basically the emulated FPU is forgetting to tell the
truth about the fact its a very basic FPU.

Alan

