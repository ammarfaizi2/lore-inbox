Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263672AbTEEQug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTEEQsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:48:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35464 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263759AbTEEQrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:47:46 -0400
Date: Mon, 5 May 2003 10:02:02 -0700
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Mike Anderson <andmike@us.ibm.com>
Subject: Re: [RFC] support for sysfs string based properties for SCSI (1/3)
Message-ID: <20030505170202.GA1296@kroah.com>
References: <1051989099.2036.7.camel@mulgrave> <1051989565.2036.14.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051989565.2036.14.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 03, 2003 at 02:19:23PM -0500, James Bottomley wrote:
> diff -Nru a/drivers/base/core.c b/drivers/base/core.c
> --- a/drivers/base/core.c	Sat May  3 14:18:21 2003
> +++ b/drivers/base/core.c	Sat May  3 14:18:21 2003
> @@ -42,6 +42,8 @@
>  
>  	if (dev_attr->show)
>  		ret = dev_attr->show(dev,buf);
> +	else if (dev->bus->show)
> +		ret = dev->bus->show(dev, buf, attr);
>  	return ret;

Can't you do this by using the class interface instead?

This also forces you to do a lot of string compares within the bus show
function (as your example did) which is almost as unwieldy as just
having individual show functions, right?  :)

thanks,

greg k-h
