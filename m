Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVCDHWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVCDHWJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVCDHTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:19:06 -0500
Received: from fire.osdl.org ([65.172.181.4]:29615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262501AbVCDHRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:17:49 -0500
Date: Thu, 3 Mar 2005 23:17:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net, linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: 2.6.11 vs DVB cx88 stuffs
Message-Id: <20050303231716.14a48f5f.akpm@osdl.org>
In-Reply-To: <20050303224438.2952f63e.akpm@osdl.org>
References: <200503032119.04675.gene.heskett@verizon.net>
	<20050303224438.2952f63e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  >
>  > I've a new pcHDTV-3000 card, and I thought maybe it would
>  >  be a good idea to build the cx88 stuff in the DVB section
>  >  of a make xconfig.
>  > 
>  >  It doesn't build, spitting out this bailout:
>  > 
>  >    CC [M]  drivers/media/video/cx88/cx88-cards.o
>  >  drivers/media/video/cx88/cx88-cards.c: In function `hauppauge_eeprom_dvb':
>  >  drivers/media/video/cx88/cx88-cards.c:694: error: `PLLTYPE_DTT7595' undeclared (first use in this function)
>  >  drivers/media/video/cx88/cx88-cards.c:694: error: (Each undeclared identifier is reported only once
>  >  drivers/media/video/cx88/cx88-cards.c:694: error: for each function it appears in.)
>  >  drivers/media/video/cx88/cx88-cards.c:698: error: `PLLTYPE_DTT7592' undeclared (first use in this function)
>  >  drivers/media/video/cx88/cx88-cards.c: In function `cx88_card_setup':
>  >  drivers/media/video/cx88/cx88-cards.c:856: error: `PLLTYPE_DTT7579' undeclared (first use in this function)
> 
>  OK, this is one for Gerd.  Those identifiers just aren't anywhere in the tree.
>

<googles>

OK, the below should get you going again.  It fixes up a warning too.
 
>  The reason this wasn't picked up is that neither `make allyesconfig' or
>  `make allmodconfig' enables CONFIG_VIDEO_CX88_DVB or
>  CONFIG_VIDEO_CX88_DVB_MODULE.
>
>  For coverage purposes it would be excellent to fix that up too, please.

Wise words, those.



diff -puN drivers/media/dvb/frontends/cx22702.h~c8xx-cards-build-fix drivers/media/dvb/frontends/cx22702.h
--- 25/drivers/media/dvb/frontends/cx22702.h~c8xx-cards-build-fix	2005-03-03 23:13:59.000000000 -0800
+++ 25-akpm/drivers/media/dvb/frontends/cx22702.h	2005-03-03 23:14:17.000000000 -0800
@@ -30,6 +30,10 @@
 
 #include <linux/dvb/frontend.h>
 
+#define PLLTYPE_DTT7592 1
+#define PLLTYPE_DTT7595 2
+#define PLLTYPE_DTT7579 3
+
 struct cx22702_config
 {
 	/* the demodulator's i2c address */
diff -puN drivers/media/video/cx88/cx88-cards.c~c8xx-cards-build-fix drivers/media/video/cx88/cx88-cards.c
--- 25/drivers/media/video/cx88/cx88-cards.c~c8xx-cards-build-fix	2005-03-03 23:15:09.000000000 -0800
+++ 25-akpm/drivers/media/video/cx88/cx88-cards.c	2005-03-03 23:15:35.000000000 -0800
@@ -707,6 +707,7 @@ static int hauppauge_eeprom_dvb(struct c
 
 	core->pll_addr = 0x61;
 	core->demod_addr = 0x43;
+	return 0;
 }
 #endif
 
_

