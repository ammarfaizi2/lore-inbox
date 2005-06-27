Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVF0TGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVF0TGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVF0TGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:06:32 -0400
Received: from kirby.webscope.com ([204.141.84.57]:32182 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S261592AbVF0TE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:04:28 -0400
Message-ID: <42C04D82.9000108@m1k.net>
Date: Mon, 27 Jun 2005 15:03:30 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: fix silly config option.
References: <20050627053928.GA9759@redhat.com>
In-Reply-To: <20050627053928.GA9759@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>CONFIG_CONFIG_TUNER_MULTI_I2C probably isn't what the
>author meant to create.
>
>Signed-off-by: Dave Jones <davej@redhat.com>
>
>--- linux-2.6.12/drivers/media/video/Kconfig~	2005-06-27 01:37:39.000000000 -0400
>+++ linux-2.6.12/drivers/media/video/Kconfig	2005-06-27 01:37:56.000000000 -0400
>@@ -7,7 +7,7 @@ menu "Video For Linux"
> 
> comment "Video Adapters"
> 
>-config CONFIG_TUNER_MULTI_I2C
>+config TUNER_MULTI_I2C
> 	bool "Enable support for multiple I2C devices on Video Adapters (EXPERIMENTAL)"
> 	depends on VIDEO_DEV && EXPERIMENTAL
> 	---help---
>  
>
Dave-

If you do:

grep TUNER_MULTI_I2C < patch-2.6.12-git9

you will get:

+config CONFIG_TUNER_MULTI_I2C
+#define CONFIG_TUNER_MULTI_I2C /**/
+#ifdef CONFIG_TUNER_MULTI_I2C
+#ifdef CONFIG_TUNER_MULTI_I2C
+#ifdef CONFIG_TUNER_MULTI_I2C
+#ifndef CONFIG_TUNER_MULTI_I2C
+#ifdef CONFIG_TUNER_MULTI_I2C

... So in fact, after applying your patch above,  NOW it is a silly 
config option, which in effect, removed all functionality of 
CONFIG_TUNER_MULTI_I2C alltogether.  It so happens that this has been 
completely removed in the current -mm, and I've confirmed with Mauro 
Chehab (video4linux maintainer) that nothing will be broken after 
applying your patch, so there is nothing to worry about.  After the 
current tuner patches in -mm get merged, this whole thing will be a moot 
point.

-- 
Michael Krufky


