Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbTHUFxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 01:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbTHUFxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 01:53:08 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:7339 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262484AbTHUFxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 01:53:03 -0400
Message-ID: <3F445EC5.5090107@sbcglobal.net>
Date: Thu, 21 Aug 2003 00:55:17 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm3 reserve IRQ for isapnp
References: <3F440387.5090902@sbcglobal.net>
In-Reply-To: <3F440387.5090902@sbcglobal.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Besides the fact that my IRQs have been re-arranged, there seems to be 
other issues as well.

I thought that if I didn't compile the alsa snd-sb16 driver, but still 
left isapnp enabled, it should not ever try to get IRQ 5 for ISA.  I'm 
not sure if that is the way the kernel works, but just disabling the 
gameport and snd-sb16 parts did not work.  It still hangs where it 
should be saying something about getting IRQ 12 for the mouse on 
2.6.0-test3-mm2 (though I disabled that too since I use a USB mouse, so 
it probably should be saying something about my keyboard port).  
However, I don't ever see that, now I just see "input:" and then the 
cursor stops blinking.  I originally had "mice" clicked but nothing else 
selected in the build menu, but after it locked up showing "input:" I 
thought I might as well knock that off too and see if it helped.  
Obviously not...

I'm recompiling without isapnp now so we'll see how that goes.  Looks 
like that affects everything, so it'll take a while. 

While I was fooling around trying to get the thing to book with mm3, I 
set my BIOS to auto, and that did change the way IRQ's were allocated 
with 2.6.0-test3-mm2.  I had just assumed since it allocated IRQs the 
same since 2.5.69 that things remained consistent between those 
kernels.  This litte test confirmed that.  As soon as I went to auto, it 
dumped an error when trying to setup the snd-sb16 driver on kernel 
2.6.0-test3-mm2.  So I changed it back to manually configured, which 
also includes IRQ's 3 and 4 btw as well as 5 and 7. 

Note that mm3 did not change it's allocation of IRQs when I set the BIOS 
to auto, so apparently it is now ignoring the BIOS.  That is definetly 
new with mm3.

Wes

Wes Janzen wrote:

> So sad...  Ever since I started with kernel 2.5.69, the kernel has 
> been properly reserving IRQ 5 for ISA, as set in my BIOS.
>
> Unfortunately for me, it looks like 2.6.0-test3-mm3 is like 2.4.18 and 
> ignores my BIOS settings, so it locks up trying to ativate my SB16 on 
> boot (since IRQ 5 is used for IDE).  Oddly it doesn't spit out any 
> warnings, just locks up after "pnp: Device 00:01.03 activated".
> I used "pci=irqmask=0xffdf" in 2.4.18, but that doesn't seem to work 
> for 2.6.0-test3-mm3.  I'm not positive I'm giving it the correct value 
> though...so maybe that's the problem.
>
> I'd really like to try out the O17int version of mm3, but I don't want 
> to disable sound either.
>
> Thanks!
>
> Wes
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

