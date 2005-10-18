Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVJRDCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVJRDCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 23:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVJRDCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 23:02:00 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:50273 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932398AbVJRDB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 23:01:59 -0400
Message-ID: <435465AC.3070506@linuxtv.org>
Date: Mon, 17 Oct 2005 23:02:04 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cyber Dog <cyberdog3k@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why is DVB stuff compiling?
References: <cbb8f04c0510171929j3378220cp48831caa1b8d478@mail.gmail.com>
In-Reply-To: <cbb8f04c0510171929j3378220cp48831caa1b8d478@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cyber Dog wrote:

>I'm a bit confused here.  I have a custom kernel configuration, and
>I've trimmed out most of the multimedia aspects sound/video/etc
>because this is for a server machine.  I was just recompiling, and I
>noticed there was still some media stuff compiling:
>
> LD      drivers/input/serio/built-in.o
>  LD      drivers/media/common/built-in.o
>  LD      drivers/media/dvb/b2c2/built-in.o
>  LD      drivers/media/dvb/bt8xx/built-in.o
>  LD      drivers/media/dvb/cinergyT2/built-in.o
>  LD      drivers/media/dvb/dvb-core/built-in.o
>  LD      drivers/media/dvb/dvb-usb/built-in.o
>  LD      drivers/media/dvb/frontends/built-in.o
>  LD      drivers/media/dvb/pluto2/built-in.o
>  LD      drivers/media/dvb/ttpci/built-in.o
>  LD      drivers/media/dvb/ttusb-budget/built-in.o
>  LD      drivers/media/dvb/ttusb-dec/built-in.o
>  LD      drivers/media/dvb/built-in.o
>  LD      drivers/media/radio/built-in.o
>  LD      drivers/media/video/built-in.o
>  LD      drivers/media/built-in.o
>  LD      drivers/misc/built-in.o
>  CC      drivers/net/Space.o
>
>This confuses me, because as I said, I'm not including multimedia in
>the kernel.  I checked the config and I see the following:
>
>#
># Multimedia devices
>#
># CONFIG_VIDEO_DEV is not set
>
>#
># Digital Video Broadcasting Devices
>#
># CONFIG_DVB is not set
>
>Which is what I would expect.  So why are these things compiling into
>the kernel even if they're not selected? Or am I missing something
>about the process?  Kernel 2.6.13.3 here.  Thanks.
>  
>
If you go look, you will notice that all of those built-in.o are zero 
bytes large.  We've already fixed this in kernel 2.6.14 by preventing 
the build of these empty units with the following patch (you can safely 
apply it to 2.6.13.y):

Don't build empty built-in.o when DVB/V4L is not configured.
Thanks to Sam Ravnborg and Keith Owens.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org <mailto:js@linuxtv.org>>
===================================================================
RCS file: /cvs/linuxtv/dvb-kernel/linux/drivers/media/Makefile,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- dvb-kernel/linux/drivers/media/Makefile	2003/01/09 10:28:42	1.1
+++ dvb-kernel/linux/drivers/media/Makefile	2005/07/24 17:30:02	1.2
@@ -2,4 +2,7 @@
 # Makefile for the kernel multimedia device drivers.
 #
 
-obj-y        := video/ radio/ dvb/ common/
+obj-y := common/
+obj-$(CONFIG_VIDEO_DEV) += video/
+obj-$(CONFIG_VIDEO_DEV) += radio/
+obj-$(CONFIG_DVB)       += dvb/




Regards,

Michael Krufky

