Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWJCOse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWJCOse (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 10:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWJCOse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 10:48:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964777AbWJCOsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 10:48:33 -0400
Date: Tue, 3 Oct 2006 07:48:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Randy Dunlap <rdunlap@xenotime.net>, akpm <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2 II -- it's
 terminally broken
In-Reply-To: <200610031211.46168.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0610030746260.3952@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
 <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org> <20061002202426.aa3ecb4f.rdunlap@xenotime.net>
 <200610031211.46168.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Oct 2006, Andi Kleen wrote:
> 
> Actually I looked at the code more closely. It looks like kernel math
> emulation is much more broken. e.g. kernel_fpu_begin() is missing
> code and lots of other paths in i387 that need to check HAVE_HWFP don't.

No it's not.

kernel_fpu_begin() has the _one_ test that matters:

	if (thread->status & TS_USEDFPU) {

since if software emulation is on, nobody will ever have the TS_USEDFPU 
flag set.

> Fixing it properly would be much more work.

No. It's all fixed properly already.

The bug is simply on the newer FXSR paths - marking the FPU emulation 
broken is just stupid. 

		Linus
