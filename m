Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWF3AHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWF3AHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWF3AHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:07:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8674 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751339AbWF3AHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:07:12 -0400
Date: Thu, 29 Jun 2006 17:07:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, mst@mellanox.co.il, openib-general@openib.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 28 of 39] IB/ipath - Fixes a bug where our delay for
 EEPROM no longer works due to compiler reordering
Message-Id: <20060629170711.757a97d2.akpm@osdl.org>
In-Reply-To: <5f3c0b2d446d78e3327f.1151617279@eng-12.pathscale.com>
References: <patchbomb.1151617251@eng-12.pathscale.com>
	<5f3c0b2d446d78e3327f.1151617279@eng-12.pathscale.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
> The mb() prevents the compiler from reordering on this function, with some versions
> of gcc and -Os optimization.   The result is random failures in the EEPROM read
> without this change.
> 
> 
> Signed-off-by: Dave Olson <dave.olson@qlogic.com>
> Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>
> 
> diff -r 7d22a8963bda -r 5f3c0b2d446d drivers/infiniband/hw/ipath/ipath_eeprom.c
> --- a/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Jun 29 14:33:26 2006 -0700
> +++ b/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Jun 29 14:33:26 2006 -0700
> @@ -186,6 +186,7 @@ bail:
>   */
>  static void i2c_wait_for_writes(struct ipath_devdata *dd)
>  {
> +	mb();
>  	(void)ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
>  }
>  

That's a bit weird.  I wouldn't have expected the compiler to muck around
with a readl().

