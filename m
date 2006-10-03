Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWJCKFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWJCKFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWJCKFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:05:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:27035 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964858AbWJCKFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:05:40 -0400
From: Andi Kleen <ak@suse.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
Date: Tue, 3 Oct 2006 12:05:24 +0200
User-Agent: KMail/1.9.3
Cc: Linus Torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com> <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org> <20061002202426.aa3ecb4f.rdunlap@xenotime.net>
In-Reply-To: <20061002202426.aa3ecb4f.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610031205.24815.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> void mxcsr_feature_mask_init(void)
> {
> 	unsigned long mask = 0;
> 	clts();
> 	if (cpu_has_fxsr) {
> 		memset(&current->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
> 		asm volatile("fxsave %0" : : "m" (current->thread.i387.fxsave)); 
> 		mask = current->thread.i387.fxsave.mxcsr_mask;
> 		if (mask == 0) mask = 0x0000ffbf;
> 	}

This just needs an ifdef. I'll fix that thanks.

-Andi
