Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVDAXrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVDAXrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVDAXrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:47:04 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:52827 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262803AbVDAXq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:46:58 -0500
Message-ID: <424DDD6D.3010204@tls.msk.ru>
Date: Sat, 02 Apr 2005 03:46:53 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] quiet ide-cd warning
References: <20050401201111.GH15453@waste.org>
In-Reply-To: <20050401201111.GH15453@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> This shuts up a potential uninitialized variable warning.

Potential warning or potential uninitialized use?
The code was right before the change, and if the compiler
generates such a warning on it, it's the compiler who
should be fixed, not the code: it's obvious the variable
can't be used uninitialized here, and moving the things
around like that makes the code misleading and hard to
understand...

/mjt

> Signed-off-by: Matt Mackall <mpm@selenic.com>
> 
> Index: af/drivers/ide/ide-cd.c
> ===================================================================
> --- af.orig/drivers/ide/ide-cd.c	2005-04-01 11:17:37.000000000 -0800
> +++ af/drivers/ide/ide-cd.c	2005-04-01 11:55:09.000000000 -0800
> @@ -430,7 +430,7 @@ void cdrom_analyze_sense_data(ide_drive_
>  #if VERBOSE_IDE_CD_ERRORS
>  	{
>  		int i;
> -		const char *s;
> +		const char *s = "bad sense key!";
>  		char buf[80];
>  
>  		printk ("ATAPI device %s:\n", drive->name);
> @@ -445,8 +445,6 @@ void cdrom_analyze_sense_data(ide_drive_
>  
>  		if (sense->sense_key < ARY_LEN(sense_key_texts))
>  			s = sense_key_texts[sense->sense_key];
> -		else
> -			s = "bad sense key!";
>  
>  		printk("%s -- (Sense key=0x%02x)\n", s, sense->sense_key);
>  
> 

