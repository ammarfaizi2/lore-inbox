Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUFLNuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUFLNuS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 09:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUFLNuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 09:50:18 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:50612 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S264781AbUFLNuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 09:50:09 -0400
Message-ID: <40CB0A0A.1010104@ThinRope.net>
Date: Sat, 12 Jun 2004 22:50:02 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: timer + fpu stuff locks my console race
References: <1404.83.109.11.80.1087046920.squirrel@nepa.nlc.no>
In-Reply-To: <1404.83.109.11.80.1087046920.squirrel@nepa.nlc.no>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stian@nixia.no wrote:
> Forgot to update the diff file after I fixed some bogus stuff. This patch
> file compiles. Please report if it works or not for 2.4.26 (I'm lacking
> that damn Internett connection on my linux box). So much for vaccation.
> 
> Stian Skjelstad
> 
> diff -ur linux-2.4.26/kernel/signal.c linux-2.4.26-fpuhotfix/kernel/signal.c
> --- linux-2.4.26/kernel/signal.c        2004-02-18 14:36:32.000000000 +0100
> +++ linux-2.4.26-fpuhotfix/kernel/signal.c      2004-06-12
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

Does this work for 2.6.{6,7} ?

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
