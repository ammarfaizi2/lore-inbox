Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUJHUJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUJHUJY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUJHUJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:09:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16133 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263778AbUJHUJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:09:22 -0400
Date: Fri, 8 Oct 2004 22:08:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Ganesh.Venkatesan@intel.com
Cc: linux-kernel@vger.kernel.org, cramerj@intel.com, john.ronciak@intel.com
Subject: 2.4.28-pre4: e1000_main.c gcc 3.4 compile error
Message-ID: <20041008200849.GS5227@stusta.de>
References: <20041008112135.GG16028@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008112135.GG16028@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 08:21:35AM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.28-pre3 to v2.4.28-pre4
> ============================================
>...
> Ganesh Venkatesan:
>...
>   o e1000 - white space corrections, other cleanups
>...


The "other cleanups" are moving 
e1000_irq_enable/e1000_irq_disable/e1000_rx_checksum around resulting in 
at least the following compile error with gcc 3.4:


<--  snip  -->

...
gcc-3.4 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre4-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
-fno-unit-at-a-time   -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=e1000_main  -c -o e1000_main.o e1000_main.c
e1000_main.c: In function `e1000_up':
e1000_main.c:132: sorry, unimplemented: inlining failed in call to 
'e1000_irq_enable': function body not available
e1000_main.c:277: sorry, unimplemented: called from here
make[4]: *** [e1000_main.o] Error 1
make[4]: Leaving directory 
`/home/bunk/linux/kernel-2.4/linux-2.4.28-pre4-full/drivers/net/e1000'

<--  snip  -->


Please drop this changeset.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

