Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132229AbRCWAjJ>; Thu, 22 Mar 2001 19:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132286AbRCWAjA>; Thu, 22 Mar 2001 19:39:00 -0500
Received: from jalon.able.es ([212.97.163.2]:29597 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132229AbRCWAir>;
	Thu, 22 Mar 2001 19:38:47 -0500
Date: Fri, 23 Mar 2001 01:38:00 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.0 warnings
Message-ID: <20010323013800.A1918@werewolf.able.es>
In-Reply-To: <20010323011140.A1176@werewolf.able.es> <E14gFRT-0003f4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14gFRT-0003f4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 23, 2001 at 01:28:32 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.23 Alan Cox wrote:
> >  	page_cache_release(page);
> > -out:
> 
> out:;
> 

Yes, a null sentence can shut up the compiler. But what is the purpose of
a jump to the end instead of a return ? Some optimization ?

> does that trick
> 
> > -	default:
> > +	default:;
>

Same, I have not tested if gcc-3 will complain about a switch that not
covers all values (ie, no default:). But the logic thing would be to kill
the default: completely. Mmmm, and older compilers will eat it with no
default: ?

> 
> The aic7xxx change looks right too. Someone with the hardware handy needs to
> check that one though.
>

It work on my 7880.

> As to the asm - I'll apply it to -ac if you can verify the asm after changes
> goes happily through the older gcc/binutils (should do) and send me a nice
> clean diff of just those changes
> 

Is there a non-written standard for coding that asm's ?
For example:
"      adcl 12(%1), %0\n"
"1:    adcl 16(%1), %0\n"
"      lea 4(%1), %1\n"

or

"adcl 12(%1), %0\n\t"
"1:  adcl 16(%1), %0\n\t"
"lea 4(%1), %1\n\t"

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.2-ac21 #5 SMP Thu Mar 22 23:47:26 CET 2001 i686

