Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVFOJbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVFOJbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 05:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVFOJby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 05:31:54 -0400
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:34208 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S261374AbVFOJbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 05:31:00 -0400
Message-ID: <42AFF53A.5060107@cogweb.net>
Date: Wed, 15 Jun 2005 02:30:34 -0700
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Michael Schimek <mschimek@gmx.at>
Subject: Re: [PATCH3/5] Synchronize patch for SAA7134 cards
References: <42ABBE6F.8080406@brturbo.com.br> <42ABC3C4.4050406@brturbo.com.br> <20050614170137.690e0328.akpm@osdl.org>
In-Reply-To: <20050614170137.690e0328.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
>  
>
>>--- linux-2.6.12/drivers/media/video/saa7134/saa7134-video.c	2005-06-07 15:39:55.000000000 -0300
>>+++ linux/drivers/media/video/saa7134/saa7134-video.c	2005-06-12 01:22:34.000000000 -0300
>>@@ -1,5 +1,5 @@
>> /*
>>...
>> 		.h_start       = 0,
>> 		.h_stop        = 719,
>>- 		.video_v_start = 23,
>>- 		.video_v_stop  = 262,
>>- 		.vbi_v_start_0 = 10,
>>- 		.vbi_v_stop_0  = 21,
>>- 		.vbi_v_start_1 = 273,
>>- 		.src_timing    = 7,
>>-
>>+		.video_v_start = 22,
>>+  		.video_v_start = 23,
>>    
>>
>
>That doesn't compile.  I'll assume it's supposed to be 22.
>  
>
Wrong, use 23. In fact don't apply this patch; it's a dud.

Michael Schimek's vbi changes got messed up somewhere along the line.
It should be 23, not 22 as you understandably assume -- Michael included this note in his patch:

+/* mhs 2005-05-14: Properly video capturing should start in line 22,
+   but for some reason video task A will not execute without a one
+   line gap after vbi task A/B ends, if that is enabled. */

With 22, turning on ntsc closed captioning on saa7134 cards will block the video.

Dave

>--
>video4linux-list mailing list
>Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
>https://www.redhat.com/mailman/listinfo/video4linux-list
>  
>
