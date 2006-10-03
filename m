Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWJCQWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWJCQWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWJCQWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:22:16 -0400
Received: from xenotime.net ([66.160.160.81]:912 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750902AbWJCQWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:22:15 -0400
Date: Tue, 3 Oct 2006 09:23:39 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
Message-Id: <20061003092339.999d0011.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0610030805490.3952@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	<p73venk2sjw.fsf@verdi.suse.de>
	<9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
	<Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
	<20061002191638.093fde85.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
	<20061002213809.7a3f995f.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0610030805490.3952@g5.osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 08:10:07 -0700 (PDT) Linus Torvalds wrote:

> 
> 
> On Mon, 2 Oct 2006, Randy Dunlap wrote:
> > 
> > OK, how about something more direct and less obtrusive, like this?
> 
> I think this is fine, but I also think it's a bit hacky.
> 
> Wouldn't it make more sense to make the whole "nofxsr" thing just clear 
> the capability, ie just a diff like the appended...
> 
> Does that work for you? If so, we should _also_ make sure that "no387" 
> calls this function too, so that you don't have to do _both_ no387 and 
> nofxsr, which is clearly silly. Once you do no387, the kernel should do 
> the nofxsr for you, methinks..

Yes, that works.

> ---
> diff --git a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
> index 2799baa..7ac3c9e 100644
> --- a/arch/i386/kernel/cpu/common.c
> +++ b/arch/i386/kernel/cpu/common.c
> @@ -185,6 +185,7 @@ static void __cpuinit get_cpu_vendor(str
>  static int __init x86_fxsr_setup(char * s)
>  {
>  	disable_x86_fxsr = 1;
> +	clear_bit(X86_FEATURE_FXSR, boot_cpu_data.x86_capability);
>  	return 1;
>  }
>  __setup("nofxsr", x86_fxsr_setup);

---
~Randy
