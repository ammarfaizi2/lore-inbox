Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276718AbRJKSxo>; Thu, 11 Oct 2001 14:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276707AbRJKSxd>; Thu, 11 Oct 2001 14:53:33 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:56241 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S276709AbRJKSxZ>;
	Thu, 11 Oct 2001 14:53:25 -0400
Date: Thu, 11 Oct 2001 20:53:27 +0200
From: David Weinehall <tao@acc.umu.se>
To: Thierry Coutelier <Thierry.Coutelier@linux.lu>
Cc: lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org, Kuznet@Ms2.Inr.Ac.Ru
Subject: Re: Kernel patch for cls_u32.c
Message-ID: <20011011205327.F25701@khan.acc.umu.se>
In-Reply-To: <3BC439AB.B9B83B65@linux.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BC439AB.B9B83B65@linux.lu>; from Thierry.Coutelier@linux.lu on Wed, Oct 10, 2001 at 02:06:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 02:06:03PM +0200, Thierry Coutelier wrote:
> To solve a problem while listing filters you may add this patch.
> It works for all kernel versions from  2.4.6 to 2.4.11
> It wold be cool to have it in the next kernel release.
> 
> ---
> diff -ur 2.4.6/linux/net/sched/cls_u32.c linux/net/sched/cls_u32.c
> --- 2.4.6/linux/net/sched/cls_u32.c Thu Feb  1 23:06:10 2001
> +++ linux/net/sched/cls_u32.c Wed Jul 11 23:55:23 2001
> @@ -613,7 +613,8 @@
> 
>   for (ht = tp_c->hlist; ht; ht = ht->next) {
>    if (arg->count >= arg->skip) {
> -   if (arg->fn(tp, (unsigned long)ht, arg) < 0) {
> +   if (ht == tp->root &&
> +       arg->fn(tp, (unsigned long)ht, arg) < 0) {
>      arg->stop = 1;
>      return;
>     }
> @@ -625,7 +626,8 @@
>       arg->count++;
>       continue;
>      }
> -    if (arg->fn(tp, (unsigned long)n, arg) < 0) {
> +    if (ht == tp->root &&
> +        arg->fn(tp, (unsigned long)n, arg) < 0) {
>       arg->stop = 1;
>       return;
>      }

Yeuch! The author of this code REALLY needs to read
Documentation/CodingStyle

Indentation by 1 (!) single space is by far the ugliest thing I've seen
so far.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
