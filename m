Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932898AbWF2L3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbWF2L3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932895AbWF2L3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:29:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46467 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932898AbWF2L3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:29:34 -0400
Subject: Re: [PATCH] i4l:add some checks for valid drvid and driver pointer
From: Arjan van de Ven <arjan@infradead.org>
To: Karsten Keil <kkeil@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060629111629.GB9501@pingi.kke.suse.de>
References: <20060629111629.GB9501@pingi.kke.suse.de>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 13:29:31 +0200
Message-Id: <1151580572.3122.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 13:16 +0200, Karsten Keil wrote:
> If all drivers go away before all ISDN network interfaces are closed we got
> a OOps on removing interfaces, this patch avoid it.
> 
> Signed-off-by: Karsten Keil <kkeil@suse.de>
> 
> diff -ur linux-2.6.4.org/drivers/isdn/i4l/isdn_common.c linux-2.6.4/drivers/isdn/i4l/isdn_common.c
> --- linux-2.6.4.org/drivers/isdn/i4l/isdn_common.c	2004-03-11 03:55:25.000000000 +0100
> +++ linux-2.6.4/drivers/isdn/i4l/isdn_common.c	2004-03-30 18:35:38.000000000 +0200
> @@ -341,6 +341,16 @@
>  		printk(KERN_WARNING "isdn_command command(%x) driver -1\n", cmd->command);
>  		return(1);
>  	}
> +	if (!dev->drv[cmd->driver]) {
> +		printk(KERN_WARNING "isdn_command command(%x) dev->drv[%d] NULL\n",
> +			cmd->command, cmd->driver);
> +		return(1);
> +	}

Hi,

if this is a "legal" condition, you really shouldn't printk about it. If
it's not a normal legal condition, this isn't a fix but a hacky
workaround ;)

Also..  return is not a function, so return 1; is the preferred form,
not return(1)..

Greetings,
   Arjan van de Ven

