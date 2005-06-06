Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVFFIRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVFFIRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 04:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVFFIRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 04:17:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61913 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261218AbVFFIQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 04:16:56 -0400
Date: Mon, 6 Jun 2005 10:16:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] struct thread_struct, asm-i386/processor.h: wrong datatype?
Message-ID: <20050606081626.GA15699@elte.hu>
References: <200506041543.j54Fh7xv018234@wildsau.enemy.org> <200506041601.j54G1nrq022039@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506041601.j54G1nrq022039@wildsau.enemy.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Herbert Rosmanith <kernel@wildsau.enemy.org> wrote:

> 
> or better: 
> 
> > -       unsigned long   fs;
> > -       unsigned long   gs;
> > +       unsigned short  fs;
> > +       unsigned short  gs;
> >  /* Hardware debugging registers */
> >         unsigned long   debugreg[8];  /* %%db0-7 debug registers */
> >  /* fault info */
> 
> + unsigned short fs, __fsh; 
> + unsigned short gs, __gsh; 
> 
> which is also done this way the structure above, the TSS. I don't know 
> why it's done this way, but I guess it's probably better pad with 16 
> bits to avoid potential problems with 32bit movl which might overwrite 
> portions of the next field.

no. 'struct thread_struct' is the 'soft' thread-state structure. We 
store data in the most convenient (and best performing) format - word 
size in this case. The 'hard' data structure is 'struct tss_struct' - 
where we of course define things in the way the CPU expects it.

	Ingo
