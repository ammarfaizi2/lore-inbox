Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268452AbUJDTRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268452AbUJDTRG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUJDTQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:16:30 -0400
Received: from hera.cwi.nl ([192.16.191.8]:11912 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S268487AbUJDTOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:14:31 -0400
Date: Mon, 4 Oct 2004 21:14:10 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Andries.Brouwer@cwi.nl
Subject: Re: sddr09: don't hide real errors in debug prints
Message-ID: <20041004191410.GA22683@apps.cwi.nl>
References: <20041004161351.GA4757@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004161351.GA4757@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 06:13:51PM +0200, Pavel Machek wrote:

> sddr09 hides in debug prints. That seems wrong and this fixes
> it. Please apply,
> 									Pavel
> 
> --- tmp/linux/drivers/usb/storage/sddr09.c	2004-10-01 00:30:20.000000000 +0200
> +++ linux/drivers/usb/storage/sddr09.c	2004-10-01 00:47:53.000000000 +0200
> @@ -370,7 +371,7 @@
>  	result = sddr09_send_scsi_command(us, command, 12);
>  
>  	if (result != USB_STOR_TRANSPORT_GOOD) {
> -		US_DEBUGP("Result for send_control in sddr09_read2%d %d\n",
> +		printk(KERN_WARNING "Error in send_control in sddr09_read2%d %d\n",
>  			  x, result);
>  		return result;
>  	}

Hmm. I have no serious objections -- this is just a little kernel bloat,
but on the other hand, I don't see the point. Why do you want a printk
when some intermediate routine passes an error from a lower level
to a higher level?

When debugging that may be useful. But otherwise?


Andries
