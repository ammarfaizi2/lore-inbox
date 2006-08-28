Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWH1Osc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWH1Osc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWH1Osc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:48:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:53211 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751007AbWH1Osb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:48:31 -0400
Date: Mon, 28 Aug 2006 09:48:29 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com
Subject: Re: [PATCH 1/3] kthread: update s390 cmm driver to use kthread
Message-ID: <20060828144829.GA31293@sergelap.austin.ibm.com>
References: <20060824212241.GB30007@sergelap.austin.ibm.com> <20060825143842.GA27364@infradead.org> <20060825200359.GC13805@sergelap.austin.ibm.com> <20060826063247.GA6928@osiris.boeblingen.de.ibm.com> <20060827185101.GA14976@sergelap.austin.ibm.com> <20060828133755.GC9861@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060828133755.GC9861@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiko Carstens (heiko.carstens@de.ibm.com):
> > AP instructions not installed. 
> > BUG: warning at lib/kref.c:32/kref_get() 
> > 000000000017719a 0000000000000002 0000000000000000 0000000000a03cf0  
> >        0000000000a03c68 000000000037fc2c 000000000037fc2c 0000000000015dfa  
> >        0000000000000000 0000000000000000 000000000043ac30 0000000000000000  
> >        0000000000000000 000000000000000d 0000000000a03c50 0000000000a03cc8  
> >        0000000000362488 0000000000015dfa 0000000000a03c50 0000000000a03ca0  
> > Call Trace: 
> > (Ý<0000000000015d44>¨ show_trace+0x9c/0xb8) 
> >  Ý<0000000000015e18>¨ show_stack+0xb8/0xc8 
> >  Ý<0000000000015e56>¨ dump_stack+0x2e/0x3c 
> >  Ý<0000000000163f70>¨ kref_get+0x50/0x74 
> >  Ý<0000000000162ec6>¨ kobject_get+0x32/0x44 
> >  Ý<0000000000178fd6>¨ get_bus+0x36/0x60 
> >  Ý<0000000000179a12>¨ bus_add_driver+0x3a/0x1f4 
> >  Ý<000000000017ae30>¨ driver_register+0xb0/0xc0 
> >  Ý<000000000021a1fe>¨ ap_driver_register+0x56/0x64 
> >  Ý<00000000004c6ba6>¨ zcrypt_pcicc_init+0x36/0x44 
> >  Ý<000000000001330c>¨ init+0x1bc/0x3a4 
> >  Ý<00000000000184be>¨ kernel_thread_starter+0x6/0xc 
> >  Ý<00000000000184b8>¨ kernel_thread_starter+0x0/0xc 
> 
> This should be fixed with -mm3. In addition you need this one on top of -mm3:
> 
>  arch/s390/kernel/time.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.18-rc4-mm3/arch/s390/kernel/time.c
> ===================================================================
> --- linux-2.6.18-rc4-mm3.orig/arch/s390/kernel/time.c	2006-08-28 10:32:45.000000000 +0200
> +++ linux-2.6.18-rc4-mm3/arch/s390/kernel/time.c	2006-08-28 10:42:33.000000000 +0200
> @@ -85,7 +85,8 @@
>  {
>  	__u64 now;
>  
> -        now = (get_clock() - jiffies_timer_cc) >> 12;
> +	now = (get_clock() - jiffies_timer_cc) >> 12;
> +	now -= (__u64) jiffies * USECS_PER_JIFFY;
>  	return (unsigned long) now;
>  }

This patch appears to be actually in -mm3 (at least the git tree I just
fetched), and is does boot fine now.

thanks,
-serge
