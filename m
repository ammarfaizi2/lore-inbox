Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWAXC4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWAXC4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 21:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWAXC4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 21:56:10 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:65218 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1030299AbWAXC4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 21:56:09 -0500
Message-ID: <43D5973A.3000103@linuxtv.org>
Date: Mon, 23 Jan 2006 21:55:54 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       mchehab@infradead.org, linux-dvb-maintainer@linuxtv.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH|BUG-FIX] V4L/DVB: allow tristate build for cx88-vp3054-i2c
References: <20060123202404.PS66974000000@infradead.org> <20060123202444.PS83596100010@infradead.org> <20060123221604.GA3590@stusta.de> <43D56174.7000700@linuxtv.org> <20060124001248.GF3590@stusta.de>
In-Reply-To: <20060124001248.GF3590@stusta.de>
Content-Type: multipart/mixed;
 boundary="------------080107040500060501050804"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080107040500060501050804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:

>On Mon, Jan 23, 2006 at 06:06:28PM -0500, Mike Krufky wrote:
>  
>
>>Adrian Bunk wrote:
>>
>>>On Mon, Jan 23, 2006 at 06:24:44PM -0200, mchehab@infradead.org wrote:
>>>
>>>>@@ -70,6 +71,16 @@ config VIDEO_CX88_DVB_MT352
>>>>	  This adds DVB-T support for cards based on the
>>>>	  Connexant 2388x chip and the MT352 demodulator.
>>>>
>>>>+config VIDEO_CX88_VP3054
>>>>+	tristate "VP-3054 Secondary I2C Bus Support"
>>>>+	default m
>>>>
>>>This option should be a bool since "m" doesn't make much sense (it's 
>>>anyways interpreted the same as "y").
>>>
>>You have a point - it is a boolean choice yes/no, about whether or not 
>>to compile support for this module, ... but it is in fact a module, and 
>>when M is chosen, cx88-vp3054-i2c.ko will build as a module.  When Y is
>>chosen, it will be built in-kernel.
>>    
>>
>I don't see this in your patches.
>
>All your patches do is to define -DHAVE_VP3054_I2C=1 depending on 
>CONFIG_VIDEO_CX88_VP3054.
>
Oops!  I made a mistake, but not the one you thought.  The attached 
patch fixes it.

Mauro, I just applied this to CVS, please apply on v4l-dvb.git

[PATCH] V4L/DVB: allow tristate build for cx88-vp3054-i2c

- allow tristate build for cx88-vp3054-i2c

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

--------------080107040500060501050804
Content-Type: text/plain;
 name="cx88-vp3054-i2c-kconfig-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cx88-vp3054-i2c-kconfig-fix.patch"

Index: linux/drivers/media/video/cx88/Makefile
===================================================================
RCS file: /cvs/video4linux/v4l-dvb/linux/drivers/media/video/cx88/Makefile,v
retrieving revision 1.8
diff -u -p -r1.8 Makefile
--- linux/drivers/media/video/cx88/Makefile	21 Jan 2006 17:52:32 -0000	1.8
+++ linux/drivers/media/video/cx88/Makefile	24 Jan 2006 02:41:07 -0000
@@ -4,8 +4,9 @@ cx8800-objs	:= cx88-video.o cx88-vbi.o
 cx8802-objs	:= cx88-mpeg.o
 
 obj-$(CONFIG_VIDEO_CX88) += cx88xx.o cx8800.o cx8802.o cx88-blackbird.o
-obj-$(CONFIG_VIDEO_CX88_DVB) += cx88-dvb.o cx88-vp3054-i2c.o
+obj-$(CONFIG_VIDEO_CX88_DVB) += cx88-dvb.o
 obj-$(CONFIG_VIDEO_CX88_ALSA) += cx88-alsa.o
+obj-$(CONFIG_VIDEO_CX88_VP3054) += cx88-vp3054-i2c.o
 
 EXTRA_CFLAGS += -I$(src)/..
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core

--------------080107040500060501050804--
