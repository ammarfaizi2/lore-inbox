Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWE2XK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWE2XK1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 19:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWE2XK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 19:10:26 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:34159 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932083AbWE2XK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 19:10:26 -0400
Message-ID: <447B83EB.4020700@gentoo.org>
Date: Tue, 30 May 2006 00:29:47 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060509)
MIME-Version: 1.0
To: toralf.foerster@gmx.de
CC: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org
Subject: Should DVB depend on I2C?
References: <200605292214.10378.toralf.foerster@gmx.de>
In-Reply-To: <200605292214.10378.toralf.foerster@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Got the following compile error :
> 
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `tda8083_writereg':
> drivers/media/dvb/frontends/tda8083.c:69: undefined reference to `i2c_transfer'
> drivers/built-in.o: In function `tda8083_readregs':
> drivers/media/dvb/frontends/tda8083.c:84: undefined reference to `i2c_transfer'
> drivers/built-in.o: In function `l64781_writereg':
> drivers/media/dvb/frontends/l64781.c:60: undefined reference to `i2c_transfer'
> drivers/built-in.o: In function `l64781_readreg':
> drivers/media/dvb/frontends/l64781.c:75: undefined reference to `i2c_transfer'
> drivers/built-in.o: In function `reset_and_configure':
> drivers/media/dvb/frontends/l64781.c:119: undefined reference to `i2c_transfer'
> drivers/built-in.o:drivers/media/dvb/frontends/l64781.c:524: more undefined references to `i2c_transfer' follow
> make: *** [.tmp_vmlinux1] Error 1
> 
> .config is attached

Still waiting on a response at 
http://marc.theaimsgroup.com/?l=linux-video&m=114787670927881&w=2

Oh wait, there was one, but apparently I wasn't CC'd. Adding the right 
list now.

DVB people:

Attila Stehr in a Gentoo bug report pointed out that the DVB frontends
do not link without CONFIG_I2C, and there is no dependency listed in the
Kconfig files.

e.g.:
drivers/built-in.o: In function `stv0299_readregs':
stv0299.c:(.text+0xa4d8a): undefined reference to `i2c_transfer'

I checked and I see this is the case for other DVB components too, such
as the dvb-usb drivers.

I'm happy to patch this, but I'm not sure which approach should be best. 
Should I make CONFIG_DVB or CONFIG_DVB_CORE depend on I2C, or should I 
modify the config blocks for all of the individual options which use I2C 
stuff?

Thanks,
Daniel

