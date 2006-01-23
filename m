Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWAWXIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWAWXIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWAWXIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:08:09 -0500
Received: from kirby.webscope.com ([204.141.84.57]:53410 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S964980AbWAWXII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:08:08 -0500
Message-ID: <43D56174.7000700@linuxtv.org>
Date: Mon, 23 Jan 2006 18:06:28 -0500
From: Mike Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: mchehab@infradead.org, linux-dvb-maintainer@linuxtv.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Michael Krufky <mkrufky@m1k.net>
Subject: Re: [PATCH 10/16] make VP-3054 Secondary I2C Bus Support a Kconfig
 option.
References: <20060123202404.PS66974000000@infradead.org>	<20060123202444.PS83596100010@infradead.org> <20060123221604.GA3590@stusta.de>
In-Reply-To: <20060123221604.GA3590@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Mon, Jan 23, 2006 at 06:24:44PM -0200, mchehab@infradead.org wrote:
>  
>
>>From: Michael Krufky <mkrufky@m1k.net>
>>
>>- make VP-3054 Secondary I2C Bus Support a Kconfig option.
>>
>>Signed-off-by: Michael Krufky <mkrufky@m1k.net>
>>Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
>>---
>>
>> drivers/media/video/cx88/Kconfig  |   11 +++++++++++
>> drivers/media/video/cx88/Makefile |    2 +-
>> 2 files changed, 12 insertions(+), 1 deletions(-)
>>
>>diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
>>index fdf45f7..e99dfbb 100644
>>--- a/drivers/media/video/cx88/Kconfig
>>+++ b/drivers/media/video/cx88/Kconfig
>>@@ -49,6 +49,7 @@ config VIDEO_CX88_DVB_ALL_FRONTENDS
>> 	default y
>> 	depends on VIDEO_CX88_DVB
>> 	select DVB_MT352
>>+	select VIDEO_CX88_VP3054
>> 	select DVB_OR51132
>> 	select DVB_CX22702
>> 	select DVB_LGDT330X
>>@@ -70,6 +71,16 @@ config VIDEO_CX88_DVB_MT352
>> 	  This adds DVB-T support for cards based on the
>> 	  Connexant 2388x chip and the MT352 demodulator.
>> 
>>+config VIDEO_CX88_VP3054
>>+	tristate "VP-3054 Secondary I2C Bus Support"
>>+	default m
>>...
>>    
>>
>This option should be a bool since "m" doesn't make much sense (it's 
>anyways interpreted the same as "y").
>  
>
Adrian,

You have a point - it is a boolean choice yes/no, about whether or not 
to compile support for this module, ... but it is in fact a module, and 
when M is chosen, cx88-vp3054-i2c.ko will build as a module.  When Y is 
chosen, it will be built in-kernel, just as all other tri-states..... 
The difference is that this module depends on DVB_MT352 ... if DVB_MT352 
is M, then this should be M/N ... if  VIDEO_CX88_DVB is Y, then this 
should be Y/N...

This particular menu item is NOT the same as the other submenu items of 
the VIDEO_CX88_DVB_FRONTEND_FOO

This may be why you thought this should be changed to a boolean, but it 
really should remain as a tristate....  Thank you though.

:-)

Regards,

-- 
Michael Krufky


