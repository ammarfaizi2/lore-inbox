Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSHAU4G>; Thu, 1 Aug 2002 16:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSHAU4F>; Thu, 1 Aug 2002 16:56:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:37105 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317141AbSHAU4B>; Thu, 1 Aug 2002 16:56:01 -0400
Subject: Re: [PATCH] solved APM bug with -rc5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy TARREAU <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020801203520.GA244@pcw.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
	<20020801121205.GA168@pcw.home.local> <20020801133202.GA200@pcw.home.local>
	<1028213732.14865.50.camel@irongate.swansea.linux.org.uk>
	<20020801135623.GA19879@alpha.home.local>
	<20020801152459.GA19989@alpha.home.local>
	<1028220826.14865.69.camel@irongate.swansea.linux.org.uk> 
	<20020801203520.GA244@pcw.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 23:16:23 +0100
Message-Id: <1028240183.15022.99.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 21:35, Willy TARREAU wrote:

>  
> +#ifdef CONFIG_SMP
> +	/* 2002/08/01 - WT
> +	 * This is to avoid random crashes at boot time during initialization
> +	 * on SMP systems in case of "apm=power-off" mode. Seen on ASUS A7M266D.
> +	 * Some bioses don't like being called from CPU != 0.
> +	 */
> +	while (cpu_number_map(smp_processor_id()) != 0) {
> +		schedule();
> +	}
> +#endif

What guarantees that loop will ever exit ?

