Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVIAQCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVIAQCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbVIAQCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:02:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:37855 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030220AbVIAQCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:02:30 -0400
Date: Thu, 1 Sep 2005 08:59:15 -0700
From: Greg KH <greg@kroah.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: i2c via686a.c: save at least 0.5k of space by long v[256] -> u16 v[256]
Message-ID: <20050901155915.GB1235@kroah.com>
References: <200509010910.14824.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509010910.14824.vda@ilport.com.ua>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 09:10:14AM +0300, Denis Vlasenko wrote:
> Not tested, but it's rather obvious.

Except you forgot a "Signed-off-by:" line...

> --- linux-2.6.12.src/drivers/i2c/chips/via686a.c.orig	Sun Jun 19 16:10:10 2005
> +++ linux-2.6.12.src/drivers/i2c/chips/via686a.c	Tue Aug 30 00:21:39 2005
> @@ -205,7 +205,7 @@ static inline u8 FAN_TO_REG(long rpm, in
>   but the function is very linear in the useful range (0-80 deg C), so 
>   we'll just use linear interpolation for 10-bit readings.)  So, tempLUT 
>   is the temp at via register values 0-255: */
> -static const long tempLUT[] =
> +static const int16_t tempLUT[] =

int16_t is not a proper kernel type.  Do you really mean s16 instead?
Care to redo this?

thanks,

greg k-h
