Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVADFgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVADFgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVADFgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 00:36:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:33463 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261542AbVADFgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 00:36:10 -0500
Message-ID: <41DA29D6.3020001@osdl.org>
Date: Mon, 03 Jan 2005 21:29:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Smith <the.pond@dsl.pipex.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 - problem with cx88-cards.c
References: <41D5585E.6040201@dsl.pipex.com>
In-Reply-To: <41D5585E.6040201@dsl.pipex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Smith wrote:
> I am trying to get a Hauppauge Nova-T working.  The chip IDs are 
> cx22702-15 and cx23882-19.
> 
> Relevant configs:
> 
> CONFIG_VIDEO_CX88_DVB=m
> CONFIG_DVB=y
> CONFIG_DVB_CORE=m
> CONFIG_DVB_AV7110=m
> # CONFIG_DVB_AV7110_OSD is not set
> CONFIG_DVB_BUDGET=m
> CONFIG_DVB_BUDGET_CI=m
> CONFIG_DVB_BUDGET_AV=m
> CONFIG_DVB_BUDGET_PATCH=m
> CONFIG_DVB_TTUSB_BUDGET=m
> CONFIG_DVB_TTUSB_DEC=m
> # CONFIG_DVB_DIBUSB is not set
> # CONFIG_DVB_CINERGYT2 is not set
> CONFIG_DVB_B2C2_SKYSTAR=m
> # CONFIG_DVB_B2C2_USB is not set
> CONFIG_DVB_BT8XX=m
> # Supported DVB Frontends
> # Customise DVB Frontends
> # DVB-S (satellite) frontends
> CONFIG_DVB_STV0299=m
> # CONFIG_DVB_CX24110 is not set
> CONFIG_DVB_TDA8083=m
> # CONFIG_DVB_TDA80XX is not set
> CONFIG_DVB_MT312=m
> CONFIG_DVB_VES1X93=m
> # DVB-T (terrestrial) frontends
> CONFIG_DVB_SP8870=m
> CONFIG_DVB_SP887X=m
> CONFIG_DVB_CX22700=m
> CONFIG_DVB_CX22702=m
> CONFIG_DVB_L64781=m
> CONFIG_DVB_TDA1004X=m
> # CONFIG_DVB_NXT6000 is not set
> CONFIG_DVB_MT352=m
> # CONFIG_DVB_DIB3000MB is not set
> # CONFIG_DVB_DIB3000MC is not set
> # DVB-C (cable) frontends
> # CONFIG_DVB_ATMEL_AT76C651 is not set
> CONFIG_DVB_VES1820=m
> CONFIG_DVB_TDA10021=m
> CONFIG_DVB_STV0297=m
> CONFIG_VIDEO_BUF_DVB=m
> 
> Problem is the kernel build fails (nb. this is with a completely 
> pristine source tree):
> 
> Kernel: arch/i386/boot/bzImage is ready
> make[1]: Leaving directory `/usr/src/linux-2.6.10'
> /usr/bin/make    ARCH=i386 \
>                      modules
> make[1]: Entering directory `/usr/src/linux-2.6.10'
>   CHK     include/linux/version.h
> make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CC [M]  drivers/media/video/cx88/cx88-cards.o
> drivers/media/video/cx88/cx88-cards.c: In function `hauppauge_eeprom_dvb':
> drivers/media/video/cx88/cx88-cards.c:694: error: `PLLTYPE_DTT7595' 
> undeclared (first use in this function)
> drivers/media/video/cx88/cx88-cards.c:694: error: (Each undeclared 
> identifier is reported only once
> drivers/media/video/cx88/cx88-cards.c:694: error: for each function it 
> appears in.)
> drivers/media/video/cx88/cx88-cards.c:698: error: `PLLTYPE_DTT7592' 
> undeclared (first use in this function)
> drivers/media/video/cx88/cx88-cards.c: In function `cx88_card_setup':
> drivers/media/video/cx88/cx88-cards.c:856: error: `PLLTYPE_DTT7579' 
> undeclared (first use in this function)
> make[5]: *** [drivers/media/video/cx88/cx88-cards.o] Error 1
> make[4]: *** [drivers/media/video/cx88] Error 2
> make[3]: *** [drivers/media/video] Error 2
> make[2]: *** [drivers/media] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.10'
> make: *** [stamp-build] Error 2
> 
> Hope someone can shed some light on this - patches welcomed.  BTW I am 
> not subscribed, but I will be monitoring the archives so no need to cc 
> if you can't be bothered ;)

Well, apparently you enabled 'BROKEN' file builds:
config VIDEO_CX88_DVB
         tristate "DVB Support for cx2388x based TV cards"
         depends on VIDEO_CX88 && DVB_CORE && BROKEN

so my suggestion is that you ask the DVB people about it.
 From the MAINTAINTERS file:

DVB SUBSYSTEM AND DRIVERS
P:	LinuxTV.org Project
M: 	linux-dvb-maintainer@linuxtv.org
L: 	linux-dvb@linuxtv.org (subscription required)
W:	http://linuxtv.org/developer/dvb.xml
S:	Supported

-- 
~Randy
