Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVJ2BpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVJ2BpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 21:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVJ2BpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 21:45:24 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:47045 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751086AbVJ2BpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 21:45:24 -0400
Message-ID: <4362D420.5040809@m1k.net>
Date: Fri, 28 Oct 2005 21:45:04 -0400
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Stezenbach <js@linuxtv.org>
CC: Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Mauro Carvalho Chehab <mauro_chehab@yahoo.com.br>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org, rbultje@ronald.bitfreak.net,
       middelin@polyware.nl
Subject: Re: Fw: zoran drivers: absense of locking?
References: <20051028163219.340fa347.akpm@osdl.org> <20051029013252.GC15903@linuxtv.org>
In-Reply-To: <20051029013252.GC15903@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach wrote:

>On Fri, Oct 28, 2005 Andrew Morton wrote:
>  
>
>>Alexey, please don't assume that everyone reads lkml.
>>    
>>
>I Cc: the v4l people, maybe they can answer the question.
>
>Johannes
>
>  
>
It's not in our tree... This is what I can see in the MAINTAINERS file:

ZR36067 VIDEO FOR LINUX DRIVER
P:      Ronald Bultje
M:      rbultje@ronald.bitfreak.net
L:      mjpeg-users@lists.sourceforge.net
W:      http://mjpeg.sourceforge.net/driver-zoran/
S:      Maintained

ZR36120 VIDEO FOR LINUX DRIVER
P:      Pauline Middelink
M:      middelin@polyware.nl
W:      http://www.polyware.nl/~middelin/En/hobbies.html
W:      http://www.polyware.nl/~middelin/hobbies.html
S:      Maintained

I can only guess that this falls under ZR36067 ??  (cc's added)

>>Begin forwarded message:
>>
>>Date: Sat, 29 Oct 2005 01:16:47 +0400
>>From: Alexey Dobriyan <adobriyan@gmail.com>
>>To: linux-kernel@vger.kernel.org
>>Subject: zoran drivers: absense of locking?
>>
>>
>>I've tried to read random part of a tree and now scratching my head
>>with a question:
>>
>>	what protects the number and a list of registered codecs in
>>	zoran drivers?
>>
>>Example: drivers/media/video/zr36050.c:
>>
>>	/* amount of chips attached via this driver */
>>	static int zr36050_codecs = 0;
>>
>>Decremented in zr36050_unset().
>>Checked for maximum value, used and incremented in zr36050_setup().
>>
>>[Assigment to 0 in zr36050_init_module is not needed. dprintk() in
>>zr36050_cleanup_module() should be converted to BUG_ON, so I'll ignore
>>them.]
>>
>>	zr36050_codecs
>>		zr36050_unset()	= struct videocodec::unset
>>		zr36050_setup()	= struct videocodec::setup
>>
>>The only place where ->unset and ->setup methods are called is
>>drivers/media/video/videocodec.c:
>>
>>	zr36050_codecs
>>		zr36050_unset()
>>			videocodec_detach()
>>		zr36050_setup()
>>			videocodec_attach()
>>
>>Both videocodec functions are exported.
>>
>>No spinlocks or semaphores in sight.
>>
>>Does anybody know what protects the list of registered codecs in zoran
>>drivers?
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>

