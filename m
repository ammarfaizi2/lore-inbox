Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278695AbRKIJOF>; Fri, 9 Nov 2001 04:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279250AbRKIJNq>; Fri, 9 Nov 2001 04:13:46 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:40217 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S278695AbRKIJNd>; Fri, 9 Nov 2001 04:13:33 -0500
Date: Fri, 9 Nov 2001 04:13:27 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan Van de Ven <arjanv@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] take 2 of the tr-based current
Message-ID: <20011109041327.T4087@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20011108190546.A29741@redhat.com> <20011108211143.A4797@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011108211143.A4797@redhat.com>; from bcrl@redhat.com on Thu, Nov 08, 2001 at 09:11:43PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 09:11:43PM -0500, Benjamin LaHaise wrote:
> On Thu, Nov 08, 2001 at 07:05:46PM -0500, Benjamin LaHaise wrote:
> > If other people could bang on this a bit and post any problems, I'd 
> > appreciate it.  tia,
> 
> Ooops.  A slight typo is fixed below.
> 
> 		-ben (who shouldn't edit patches before hitting send)
> 
> 
> diff -ur ./v2.4.13-ac8/include/asm-i386/smp.h ../toomuch-v2.4.13-ac8+tr/include/asm-i386/smp.h
> --- ./v2.4.13-ac8/include/asm-i386/smp.h	Thu Nov  8 21:07:47 2001
> +++ toomuch-v2.4.13-ac8+tr/include/asm-i386/smp.h	Thu Nov  8 21:06:25 2001
> @@ -102,7 +102,8 @@
>   * so this is correct in the x86 case.
>   */
>  
> -static unsigned get_TR(void) __attribute__ ((pure))
> +static unsigned get_TR(void) __attribute__ ((pure));
> +static unsigned get_TR(void)
>  {
>  	unsigned tr;
>  	__asm__("str %w0" : "=g" (tr));

Why not
static inline unsigned __attribute__ ((const)) get_TR(void)
{
}
?
If TR register only ever changes during cpu_init, I don't see why you
cannot use const. Using pure would mean if you do get_TR, then store
something into global memory and do get_TR again, it will be done twice.
Also, I wonder why you don't inline it.

	Jakub
