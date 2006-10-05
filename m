Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWJEKz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWJEKz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWJEKz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:55:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21212 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751669AbWJEKzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:55:25 -0400
Message-ID: <4524E49B.2060101@pobox.com>
Date: Thu, 05 Oct 2006 06:55:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: Don't believe bogus claims in the older PIO mode
 register
References: <1159550807.13029.43.camel@localhost.localdomain>
In-Reply-To: <1159550807.13029.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/ata/libata-core.c linux-2.6.18-mm2/drivers/ata/libata-core.c
> --- linux.vanilla-2.6.18-mm2/drivers/ata/libata-core.c	2006-09-28 14:33:46.000000000 +0100
> +++ linux-2.6.18-mm2/drivers/ata/libata-core.c	2006-09-29 17:33:53.000000000 +0100
> @@ -870,7 +870,11 @@
>  		 * the PIO timing number for the maximum. Turn it into
>  		 * a mask.
>  		 */
> -		pio_mask = (2 << (id[ATA_ID_OLD_PIO_MODES] & 0xFF)) - 1 ;
> +		u8 mode = id[ATA_ID_OLD_PIO_MODES] & 0xFF;
> +		if( mode < 5)	/* Valid PIO range */
> +                	pio_mask = (2 << mode) - 1 ;
> +		else
> +			pio_mask = 1;

applied to #upstream-fixes, after fixing up stuff like "if( "


