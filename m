Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310645AbSCMPD3>; Wed, 13 Mar 2002 10:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310648AbSCMPDU>; Wed, 13 Mar 2002 10:03:20 -0500
Received: from waste.org ([209.173.204.2]:11649 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S310645AbSCMPDN>;
	Wed, 13 Mar 2002 10:03:13 -0500
Date: Wed, 13 Mar 2002 09:03:09 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Samuel Hocevar <sam@zoy.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5-dj2: psmouse.c: Lost synchronization
In-Reply-To: <20020313050621.O21836@zoy.org>
Message-ID: <Pine.LNX.4.44.0203130848580.26703-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Samuel Hocevar wrote:

>    Hi, I have a Thinkpad T20 and experienced the same problem as you
> with the 2.5.x series, and I'm trying to understand what's causing it.
> Are you using the preemptive kernel patch?

Yes, and now that I think about it, I was probably running with HZ=1024
too. Switched back to 2.4 due to problems with my wireless.

>    The following simple change worked for me, would you maybe have time
> to test it and tell me whether it works?
>
> --- drivers/input/mouse/psmouse.c.orig	Wed Mar 13 05:04:26 2002
> +++ drivers/input/mouse/psmouse.c	Wed Mar 13 05:04:30 2002
> @@ -200,7 +200,7 @@
>  		return;
>  	}
>
> -	if (psmouse->pktcnt && jiffies - psmouse->last > 2) {
> +	if (psmouse->pktcnt && jiffies - psmouse->last > 10) {
>  		printk(KERN_WARNING "psmouse.c: Lost synchronization, throwing %d bytes away.\n", psmouse->pktcnt);
>  		psmouse->pktcnt = 0;
>  	}

Egads. I never even bothered to look up the code generating that message.
That should be HZ/50 or HZ/10.

Tempting to propose making HZ=HZ*100 and doing jiffies+=100 to ferret out
any code that makes assumptions about what the units of HZ are.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

