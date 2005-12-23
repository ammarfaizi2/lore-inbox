Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbVLWCEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVLWCEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 21:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVLWCEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 21:04:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26376 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030255AbVLWCEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 21:04:44 -0500
Date: Fri, 23 Dec 2005 03:04:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] conditionally #ifdef-out unused DiB3000M-C/P functions
Message-ID: <20051223020443.GE27525@stusta.de>
References: <20051221113742.GA5611@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221113742.GA5611@stiffy.osknowledge.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 12:37:43PM +0100, Marc Koschewski wrote:
> The following tiny patch removes the two DiB3000M-C/P functions
> 
> int dibusb_dib3000mc_tuner_attach()
> int dibusb_dib3000mc_frontend_attach()
> 
> that are not needed in case the module is not compiled. The modules a800 as well
> as nova-t-usb2 select DVB_DIB3000MB in Kconfig thus the functions will be
> enabled due to the module being compiled.

In theory, you could add #ifdef's in thousands of places of the kernel 
around functions similarly small to these two ones or sometimes bigger 
functions.

In practice, this would cause breakages in many configurations because 
the #ifdef's might either be wrong (as in your patch) or become wrong 
over time.

> Regards,
> 	Marc

> *** dibusb-common.c-orig	2005-12-21 11:04:49.000000000 +0100
> --- dibusb-common.c	2005-12-21 11:05:32.000000000 +0100
> *************** int dibusb_read_eeprom_byte(struct dvb_u
> *** 168,173 ****
> --- 168,174 ----
>   }
>   EXPORT_SYMBOL(dibusb_read_eeprom_byte);
>   
> + #ifdef CONFIG_DVB_USB_DIBUSB_MC
>...

This breaks with DVB_USB_DIBUSB_MC=m.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

