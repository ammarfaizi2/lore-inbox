Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265564AbUBFSBy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265583AbUBFSBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:01:53 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9433 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265564AbUBFSBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:01:51 -0500
Date: Fri, 6 Feb 2004 19:01:44 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, info@formula-n.de,
       kronos@kronoz.cjb.net
Cc: linux-kernel@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux
Subject: [patch] 2.4.25-rc1: amd7930_fn doesn't compile
Message-ID: <20040206180144.GF26093@fs.tum.de>
References: <Pine.LNX.4.58L.0402051037190.9788@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402051037190.9788@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 10:44:31AM -0200, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.25-pre8 to v2.4.25-rc1
> ============================================
>...
> Luca Tettamanti:
>...
>   o Fix amd7930_fn.h compilation warning
>...

This causes the following compile error when trying to compile this 
driver statically into a kernel with CONFIG_HOTPLUG=n :

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.25-rc1-full-no-hotplug/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 
-march=athlon  -DHISAX_MAX_CARDS=8 -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=amd7930_fn  -c -o amd7930_fn.o amd7930_fn.c
amd7930_fn.c: In function `Amd7930_init':
amd7930_fn.c:752: error: Amd7930_init causes a section type conflict
{standard input}: Assembler messages:
{standard input}:2: Warning: setting incorrect section attributes for .text.init
make[4]: *** [amd7930_fn.o] Error 1
make[4]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.25-rc1-full-no-hotplug/drivers/isdn/hisax'

<--  snip  -->


The fix is obvious:


--- linux-2.4.25-rc1-full-no-hotplug/drivers/isdn/hisax/amd7930_fn.c.old	2004-02-06 00:37:28.000000000 +0100
+++ linux-2.4.25-rc1-full-no-hotplug/drivers/isdn/hisax/amd7930_fn.c	2004-02-06 00:37:56.000000000 +0100
@@ -61,7 +61,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
-static WORD initAMD[] __devinit = {
+static WORD initAMD[] __devinitdata = {
 	0x0100,
 
 	0x00A5, 3, 0x01, 0x40, 0x58,				// LPR, LMR1, LMR2


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

