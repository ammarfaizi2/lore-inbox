Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUFLN6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUFLN6U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 09:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUFLN6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 09:58:20 -0400
Received: from zulo.virutass.net ([62.151.20.186]:9938 "EHLO mx.larebelion.net")
	by vger.kernel.org with ESMTP id S264795AbUFLN6P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 09:58:15 -0400
From: Manuel Arostegui Ramirez <manuel@todo-linux.com>
To: stian@nixia.no, linux-kernel@vger.kernel.org
Subject: Re: timer + fpu stuff locks my console race
Date: Sat, 12 Jun 2004 15:45:08 +0200
User-Agent: KMail/1.5
References: <1404.83.109.11.80.1087046920.squirrel@nepa.nlc.no>
In-Reply-To: <1404.83.109.11.80.1087046920.squirrel@nepa.nlc.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406121545.08651.manuel@todo-linux.com>
X-Virus: by Larebelion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sábado 12 Junio 2004 15:28, stian@nixia.no escribió:
> Forgot to update the diff file after I fixed some bogus stuff. This patch
> file compiles. Please report if it works or not for 2.4.26 (I'm lacking
> that damn Internett connection on my linux box). So much for vaccation.
>
> Stian Skjelstad
>
> diff -ur linux-2.4.26/kernel/signal.c
> linux-2.4.26-fpuhotfix/kernel/signal.c --- linux-2.4.26/kernel/signal.c    
>    2004-02-18 14:36:32.000000000 +0100 +++
> linux-2.4.26-fpuhotfix/kernel/signal.c      2004-06-12
> 15:26:10.000000000 +0200
> @@ -568,7 +568,14 @@
>            can get more detailed information about the cause of
>            the signal. */
>         if (sig < SIGRTMIN && sigismember(&t->pending.signal, sig))
> +       {
> +               if (sig==8)
> +               {
> +                       printk("Attempt to exploit known bug, process=%s
> pid=%d uid=%d\n", t->comm, t->pid, t->uid);
> +                       do_exit(0);
> +               }
>                 goto out;
> +       }
>
>         ret = deliver_signal(sig, info, t);
>  out:

I'm going to try the patch on a 2.4.20-8 in about one hour.
Thanks

-- 
Manuel Arostegui Ramirez #Linux Registered User 200896

