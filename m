Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266301AbUA2TXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUA2TXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:23:14 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:11927 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266301AbUA2TXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:23:06 -0500
Subject: Re: [TRIVIAL PATCH] 2.4.25pre7 warning fix
From: john stultz <johnstul@us.ibm.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m3wu7azp46.fsf@defiant.pm.waw.pl>
References: <m3u12hcc9f.fsf@defiant.pm.waw.pl>
	 <Pine.LNX.4.58L.0401280939400.1311@logos.cnet>
	 <m3wu7azp46.fsf@defiant.pm.waw.pl>
Content-Type: text/plain
Message-Id: <1075404151.1592.97.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 29 Jan 2004 11:22:31 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-29 at 08:38, Krzysztof Halasa wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> 
> > Btw, why do we need cyclone_setup() for !CONFIG_X86_SUMMIT ?
> >
> > /* No-cyclone stubs */
> > #ifndef CONFIG_X86_SUMMIT
> > int __init cyclone_setup(char *str)
> > {
> >         printk(KERN_ERR "cyclone: Kernel not compiled with
> > CONFIG_X86_SUMMIT, cannot use the cyclone-timer.\n");
> >         return 1;
> > }

This is needed because cyclone_setup() is called by
detect_clustered_apic(), which may or may not be done on a kernel w/
CONFIG_X86_SUMMIT enabled. 

> 
> After having a closer look at it I think we should:
> 
> 1. if CONFIG_X86_TSC is set:
>    - make calibrate_tsc() failure a fatal error
>    - assume use_tsc = 1 and x86_udelay_tsc = 1 and optimize them out
>      with preprocessor

Sounds fair. 


> 
> 2. if CONFIG_X86_SUMMIT is _not_ set:
>    - assume use_cyclone = 0 and optimize it out as well.

We already do this. 

>    - cyclone_setup() etc should go out.

cyclone_setup() is still needed. 

> 3. I would rename CONFIG_X86_TSC to something like CONFIG_X86_TSC_FORCE
>    - the current name is misleading. It wouldn't affect .config.

Agreed. 


thanks
-john


