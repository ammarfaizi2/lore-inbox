Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269133AbUJKTu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269133AbUJKTu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269205AbUJKTu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:50:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:18836 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269133AbUJKTu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:50:26 -0400
Date: Mon, 11 Oct 2004 12:54:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 HPET compile problems on AMD64
Message-Id: <20041011125421.106eff07.akpm@osdl.org>
In-Reply-To: <1097509362.12861.334.camel@dyn318077bld.beaverton.ibm.com>
References: <1097509362.12861.334.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> I get following error while linking kernel on 2.6.9-rc4-mm1.
> x86_64/kernel/time.c seems to have a dependency on char/hpet.c
> driver. Its forcing me to use CONFIG_HPET. 
> 
>  LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o(.init.text+0x2071): In function
> `late_hpet_init':
> arch/x86_64/kernel/entry.S:259: undefined reference to `hpet_alloc'
> make: *** [.tmp_vmlinux1] Error 1
> 
> ...
> 
> [hpet_alloc_fix.patch  text/plain (638 bytes)]
> --- linux.org/arch/x86_64/kernel/time.c	2004-10-11 09:17:15.613107488 -0700
> +++ linux/arch/x86_64/kernel/time.c	2004-10-11 09:14:05.983935504 -0700
> @@ -727,6 +727,7 @@ static unsigned int __init pit_calibrate
>  	return (end - start) / 50;
>  }
>  
> +#ifdef	CONFIG_HPET
>  static __init int late_hpet_init(void)
>  {
>  	struct hpet_data	hd;
> @@ -773,6 +774,7 @@ static __init int late_hpet_init(void)
>  	return 0;
>  }
>  fs_initcall(late_hpet_init);
> +#endif

I assume you have CONFIG_HPET=n and CONFIG_HPET_TIMER=n?

Andi, what's going on here?  Should the hpet functions in
arch/x86_64/kernel/time.c be inside CONFIG_HPET_TIMER?

