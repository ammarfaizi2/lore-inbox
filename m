Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVCDJHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVCDJHJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVCDJHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:07:08 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:15076 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S262711AbVCDJD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:03:29 -0500
Date: Fri, 04 Mar 2005 04:03:27 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11 vs DVB cx88 stuffs
In-reply-to: <20050303231716.14a48f5f.akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503040403.27646.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503032119.04675.gene.heskett@verizon.net>
 <20050303224438.2952f63e.akpm@osdl.org> <20050303231716.14a48f5f.akpm@osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 March 2005 02:17, Andrew Morton wrote:
>Andrew Morton <akpm@osdl.org> wrote:
>>  > I've a new pcHDTV-3000 card, and I thought maybe it would
>>  >  be a good idea to build the cx88 stuff in the DVB section
>>  >  of a make xconfig.
[...]
>>  OK, this is one for Gerd.  Those identifiers just aren't anywhere
>> in the tree.
>
><googles>
>
>OK, the below should get you going again.  It fixes up a warning
> too.
>
>>  The reason this wasn't picked up is that neither `make
>> allyesconfig' or `make allmodconfig' enables CONFIG_VIDEO_CX88_DVB
>> or
>>  CONFIG_VIDEO_CX88_DVB_MODULE.
>>
>>  For coverage purposes it would be excellent to fix that up too,
>> please.
>
>Wise words, those.
>
Applied, building.  Thanks a bunch.

Humm, unforch, its not quite complete:

-----------------
  CC [M]  drivers/media/video/cx88/cx88-dvb.o
drivers/media/video/cx88/cx88-dvb.c: In function `dvb_register':
drivers/media/video/cx88/cx88-dvb.c:190: warning: implicit declaration 
of function `cx22702_create'
drivers/media/video/cx88/cx88-dvb.c:193: warning: assignment makes 
pointer from integer without a cast
drivers/media/video/cx88/cx88-dvb.c:225: error: too few arguments to 
function `videobuf_dvb_register'
make[4]: *** [drivers/media/video/cx88/cx88-dvb.o] Error 1
make[3]: *** [drivers/media/video/cx88] Error 2
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2
-----------------------

>diff -puN drivers/media/dvb/frontends/cx22702.h~c8xx-cards-build-fix
> drivers/media/dvb/frontends/cx22702.h ---
> 25/drivers/media/dvb/frontends/cx22702.h~c8xx-cards-build-fix 2005-
>03-03 23:13:59.000000000 -0800 +++
> 25-akpm/drivers/media/dvb/frontends/cx22702.h 2005-03-03
> 23:14:17.000000000 -0800 @@ -30,6 +30,10 @@
>
> #include <linux/dvb/frontend.h>
>
>+#define PLLTYPE_DTT7592 1
>+#define PLLTYPE_DTT7595 2
>+#define PLLTYPE_DTT7579 3
>+
> struct cx22702_config
> {
> 	/* the demodulator's i2c address */
>diff -puN drivers/media/video/cx88/cx88-cards.c~c8xx-cards-build-fix
> drivers/media/video/cx88/cx88-cards.c ---
> 25/drivers/media/video/cx88/cx88-cards.c~c8xx-cards-build-fix	2005-
>03-03 23:15:09.000000000 -0800 +++
> 25-akpm/drivers/media/video/cx88/cx88-cards.c	2005-03-03
> 23:15:35.000000000 -0800 @@ -707,6 +707,7 @@ static int
> hauppauge_eeprom_dvb(struct c
>
> 	core->pll_addr = 0x61;
> 	core->demod_addr = 0x43;
>+	return 0;
> }
> #endif
>
>_

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
