Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314269AbSDRIWh>; Thu, 18 Apr 2002 04:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314270AbSDRIWg>; Thu, 18 Apr 2002 04:22:36 -0400
Received: from ns.suse.de ([213.95.15.193]:44805 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314269AbSDRIWf>;
	Thu, 18 Apr 2002 04:22:35 -0400
Date: Thu, 18 Apr 2002 10:22:34 +0200
From: Andi Kleen <ak@suse.de>
To: Doug Ledford <dledford@redhat.com>, jh@suse.cz,
        linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de, ak@suse.de,
        pavel@atrey.karlin.mff.cuni.cz
Subject: Re: SSE related security hole
Message-ID: <20020418102234.B7931@wotan.suse.de>
In-Reply-To: <20020417194249.B23438@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- i387.c.save	Wed Apr 17 19:22:47 2002
> +++ i387.c	Wed Apr 17 19:28:27 2002
> @@ -33,8 +33,26 @@
>  void init_fpu(void)
>  {
>  	__asm__("fninit");
> -	if ( cpu_has_xmm )
> +	if ( cpu_has_mmx )

Shouldn't that be cpu_has_mmx && !cpu_has_sse2  ?


-Andi

> +		asm volatile("xorq %%mm0, %%mm0;
> +			      xorq %%mm1, %%mm1;
> +			      xorq %%mm2, %%mm2;

