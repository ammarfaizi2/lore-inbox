Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbUKQTDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbUKQTDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbUKQTBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:01:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:51627 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262425AbUKQS4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:56:45 -0500
Message-ID: <419B9BDD.7030805@osdl.org>
Date: Wed, 17 Nov 2004 10:43:41 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Colin Leroy <colin.lkml@colino.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Switch therm_adt746x to new module_param
References: <20041117193416.52a86d03.colin.lkml@colino.net>
In-Reply-To: <20041117193416.52a86d03.colin.lkml@colino.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Leroy wrote:
> Hi Andrew,
> 
> this patch replaces MODULE_PARM to module_param for adt746x.
> 
> Signed-off-by: Colin Leroy <colin@colino.net>
> --- a/drivers/macintosh/therm_adt746x.c	2004-11-17 19:26:16.908413504 +0100
> +++ b/drivers/macintosh/therm_adt746x.c	2004-11-17 19:28:01.193559752 +0100

> @@ -56,11 +57,11 @@
>  		   "Powerbook G4 Alu");
>  MODULE_LICENSE("GPL");
>  
> -MODULE_PARM(limit_adjust,"i");
> +module_param(limit_adjust, int, 0);
>  MODULE_PARM_DESC(limit_adjust,"Adjust maximum temperatures (50 cpu, 70 gpu) "
>  		 "by N degrees.");
>  
> -MODULE_PARM(fan_speed,"i");
> +module_param(fan_speed, int, 64);

The last parameter here (64) is not an init. value nor a
suggested parameter value.
It's a permission for an entry in /sys (sysfs).
0 means not visible there.
If it should be visible there, use something like
0444 (read-only by anyone) or 0644 (read-write by root).

>  MODULE_PARM_DESC(fan_speed,"Specify starting fan speed (0-255) "
>  		 "(default 64)");



-- 
~Randy
