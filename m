Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbRALVVX>; Fri, 12 Jan 2001 16:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRALVVM>; Fri, 12 Jan 2001 16:21:12 -0500
Received: from mail.zmailer.org ([194.252.70.162]:17416 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129595AbRALVVG>;
	Fri, 12 Jan 2001 16:21:06 -0500
Date: Fri, 12 Jan 2001 23:20:44 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Shawn Starr <Shawn.Starr@Home.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CONT PROBLEM] 2.4.1-pre3 - Undefined symbol `__buggy_fxsr_alignment'
Message-ID: <20010112232044.L25659@mea-ext.zmailer.org>
In-Reply-To: <3A5E4B1D.5EF1B0EB@Home.net> <3A5E7DB2.A7126A68@Home.net> <3A5E7EC4.39CC7298@Home.net> <3A5F62C6.FF3EE6B1@Home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A5F62C6.FF3EE6B1@Home.net>; from Shawn.Starr@Home.net on Fri, Jan 12, 2001 at 03:02:15PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 03:02:15PM -0500, Shawn Starr wrote:
> Nope, its not ;/
> 
> Im on a Intel Pentium 200Mhz PC, 64MB RAM,
> 
> init/main.o: In function `check_fpu':
> init/main.o(.text.init+0x53): undefined reference to `__buggy_fxsr_alignment'
> make: *** [vmlinux] Error 1
> 
> same fatal error. Where is this function defined in the i386 asm header?

	It should not be present at all in the objects.
	The compiler optimizer should remove that call,
	which is just an example of similar kind of "if
	optimizer fails, here is cannon-fodder to alert
	users about it."

> If so, I could fix this and submit a patch.
 
> /* Enable FXSR and company _before_ testing for FP problems. */
>         /*
>          * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
>          */
>         if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
>                 extern void __buggy_fxsr_alignment(void);
>                 __buggy_fxsr_alignment();
> 
> Where is this function? Where is it defined? When i grep the whole dir
> i dont see this function anywhere?

	See the comment above the  offsetof()  call.
	Now think.   Figure out why things are at wrong offset.
	Has something been added into   task_struct  lately ?
	Or to  thread_struct,  which actually is processor context
	data where this 'thread.i386.fxsave' thing resides ?

	Oh yes,  if compilation DOES NOT happen with  -O  flag,
	this will also happen..

> Shawn.

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
