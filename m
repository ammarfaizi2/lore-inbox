Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265685AbSJSV4O>; Sat, 19 Oct 2002 17:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265686AbSJSV4N>; Sat, 19 Oct 2002 17:56:13 -0400
Received: from [195.39.17.254] ([195.39.17.254]:12548 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265685AbSJSV4M>;
	Sat, 19 Oct 2002 17:56:12 -0400
Date: Sun, 20 Oct 2002 00:01:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hu Gang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch: make software suspend speedup in vmware virtual machine.
Message-ID: <20021019220140.GA332@elf.ucw.cz>
References: <20021016195141.653ec380.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016195141.653ec380.hugang@soulinfo.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hello all:
> 
> With this patch 2.5.43 can resume only need ~5sec.
> without this patch 2.5.43 also can resume, but need ~240sec.
> 
> This patch also can work in normal machine. But need more test.

You probably can move __flush_tlb() out of both loops, it is there
only to aid debugging. _But_ I'd like to keep it as is. __flush_tlb()
is there to prevent heisenbugs.
								Pavel

> --------------------------------------------------
> --- arch/i386/kernel/suspend.c~old	Wed Oct 16 19:39:42 2002
> +++ arch/i386/kernel/suspend.c	Wed Oct 16 19:38:21 2002
> @@ -290,8 +290,8 @@
>  		for (loop2=0; loop2 < PAGE_SIZE; loop2++) {
>  			*(((char *)((pagedir_nosave+loop)->orig_address))+loop2) =
>  				*(((char *)((pagedir_nosave+loop)->address))+loop2);
> -			__flush_tlb();
>  		}
> +		__flush_tlb();
>  	}
>  
>  	restore_processor_context();
> 
> 
> -- 
> 		- Hu Gang



-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
