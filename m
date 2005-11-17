Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161128AbVKQEuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbVKQEuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 23:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbVKQEuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 23:50:10 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:17322 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161128AbVKQEuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 23:50:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BPlfFvb07i+90G9jkkmYIMEd9CekzA+Z38mc92yOeGCHCu4nzd1FTK54qinV6BuN4LxOrpSaenRZU4MAQQiQgCZuxtTTYZM0hzeV7SjA5yExDX2kXp1ukuqj2BLwtY4hUiUK7GJXRdqZvZABKaB55p6XLGpdNDm1ifPApEuPnoI=
Message-ID: <437C0BF2.4010400@gmail.com>
Date: Thu, 17 Nov 2005 12:49:54 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: X and intelfb fight over videomode
References: <20051117000144.GA29144@hardeman.nu> <437BD8D9.9030904@gmail.com> <20051117014558.GA30088@hardeman.nu>
In-Reply-To: <20051117014558.GA30088@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman wrote:
> On Thu, Nov 17, 2005 at 09:11:53AM +0800, Antonino A. Daplas wrote:
>> David Härdeman wrote:
>>> intelfb: Changing the video mode is not supported.
> 
> 
> Suggestions?

Ignore the hack I mentioned in the previous thread.  Try this patch instead.

Tony

--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -1283,6 +1283,14 @@ intelfb_set_par(struct fb_info *info)
 
 	if (FIXED_MODE(dinfo)) {
 		ERR_MSG("Changing the video mode is not supported.\n");
+
+		/* 
+		 * We need to at least initialize the 2D engine even
+		 * if changing the mode is not allowed
+		 */
+		if (ACCEL(dinfo, info))
+			intelfbhw_2d_start(dinfo);
+
 		return -EINVAL;
 	}
 
