Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVA0OB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVA0OB1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 09:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVA0OB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 09:01:27 -0500
Received: from sd291.sivit.org ([194.146.225.122]:44423 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262621AbVA0OBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 09:01:22 -0500
Date: Thu, 27 Jan 2005 15:02:50 +0100
From: Stelian Pop <stelian@popies.net>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] use misc dynamic minor for sonypi driver
Message-ID: <20050127140250.GB3739@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20050127134640.GA25549@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127134640.GA25549@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 02:46:40PM +0100, Olaf Hering wrote:

> 
> Whats the reason for using -1 as minor number?
> No idea if that works well, it probably does.
> Maybe add a comment if -1 is supposed to work.
> 
> 
> --- ../linux-2.6.11-rc2/drivers/char/sonypi.c	2005-01-22 02:48:34.000000000 +0100
> +++ ./drivers/char/sonypi.c	2005-01-27 14:40:47.873882682 +0100
> @@ -649,7 +649,7 @@
>  };
>  
>  struct miscdevice sonypi_misc_device = {
> -	.minor		= -1,
> +	.minor		= MISC_DYNAMIC_MINOR,
>  	.name		= "sonypi",
>  	.fops		= &sonypi_misc_fops,
>  };

It works because sonypi_misc_device.minor get overridden later:

662         sonypi_misc_device.minor = (minor == -1) ?
663                 MISC_DYNAMIC_MINOR : minor;

This test could be simplified too in addition to your patch.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
