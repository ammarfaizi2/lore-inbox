Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRLQN4i>; Mon, 17 Dec 2001 08:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279778AbRLQN42>; Mon, 17 Dec 2001 08:56:28 -0500
Received: from thor.bi.teuto.net ([212.8.197.25]:61702 "HELO thor.bi.teuto.net")
	by vger.kernel.org with SMTP id <S279313AbRLQN40>;
	Mon, 17 Dec 2001 08:56:26 -0500
Date: Mon, 17 Dec 2001 14:55:52 +0100
From: Jan-Benedict Glaw <jbglaw@microdata-pos.de>
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xchg and GCC's optimisation:-(
Message-ID: <20011217145551.B518@microdata-pos.de>
In-Reply-To: <20011217134526.A31801@microdata-pos.de> <87wuzmq91m.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <87wuzmq91m.fsf@fadata.bg>; from velco@fadata.bg on Mon, Dec 17, 2001 at 03:18:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 03:18:45PM +0200, Momchil Velikov wrote:
> >>>>> "Jan-Benedict" == Jan-Benedict Glaw <jbglaw@microdata-pos.de> writes:
> Jan-Benedict> I've looked at ./include/asm-i386/system.h which does some black
> Jan-Benedict> magic with it, and I don't really understand that. However, the
> Jan-Benedict> result is that the xchg gets optimized away, rendering at least
> 
> Can you try with this patch ...
> 
> --- system.h.orig.0	Mon Dec 17 15:03:38 2001
> +++ system.h	Mon Dec 17 15:16:58 2001
> @@ -205,21 +205,15 @@ static inline unsigned long __xchg(unsig
>  	switch (size) {
>  		case 1:
>  			__asm__ __volatile__("xchgb %b0,%1"
> -				:"=q" (x)
> -				:"m" (*__xg(ptr)), "0" (x)
> -				:"memory");
> +				     :"+q" (x),"=m" (*__xg(ptr)));
[...]

The patch fixes the problem. Please also send it for inclusion
in 2.2.x, 2.4.x and 2.5.x, because these kernel version will behave
exactly the same (system.h looks very similar between all these
versions...)

MfG, JBG

