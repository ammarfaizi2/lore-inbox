Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265369AbTL2UFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265372AbTL2UFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:05:40 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:36367 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265369AbTL2UFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:05:02 -0500
Date: Mon, 29 Dec 2003 20:04:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Omkhar Arasaratnam <omkhar@rogers.com>
Cc: axeboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/cdrom/isp16.c check_region() fix
Message-ID: <20031229200459.A31614@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Omkhar Arasaratnam <omkhar@rogers.com>, axeboe@suse.de,
	linux-kernel@vger.kernel.org
References: <20031229194222.GA26019@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031229194222.GA26019@omkhar.ibm.com>; from omkhar@rogers.com on Mon, Dec 29, 2003 at 02:42:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 02:42:23PM -0500, Omkhar Arasaratnam wrote:
> --- /usr/src/linux/drivers/cdrom/isp16.c	2001-09-07 12:28:38.000000000 -0400
> +++ drivers/cdrom/isp16.c	2003-12-29 14:07:24.000000000 -0500
> @@ -121,11 +121,12 @@
>  		return (0);
>  	}
>  
> -	if (check_region(ISP16_IO_BASE, ISP16_IO_SIZE)) {
> +	if (!request_region(ISP16_IO_BASE, ISP16_IO_SIZE,"isp16")) {
>  		printk("ISP16: i/o ports already in use.\n");
>  		return (-EIO);
>  	}
> -
> +	release_region(ISP16_IO_BASE, ISP16_IO_SIZE);

This doesn't really buy you anything.  You must claim the I/O ports as long
as you're possibly using them - i.e. claim them early when probing for
the device, and release them only when you're done with the device.

