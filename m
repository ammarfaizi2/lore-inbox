Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVCABFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVCABFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVCABFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:05:19 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:52890 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261157AbVCABEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:04:15 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [2.6 patch] drivers/usb/gadget/config.c: make a function static
Date: Mon, 28 Feb 2005 17:02:48 -0800
User-Agent: KMail/1.7.1
Cc: Adrian Bunk <bunk@stusta.de>, gregkh@suse.de, linux-kernel@vger.kernel.org
References: <20050301003428.GZ4021@stusta.de>
In-Reply-To: <20050301003428.GZ4021@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502281702.48495.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 February 2005 4:34 pm, Adrian Bunk wrote:
> This patch makes a needlessly global function static.

You sent this before, and time hasn't improved it.  This function
is exported to support composite (multi-function) devices, which
need to assemble config descriptors in chunks (config + N* function)
instead of all-at-once (config + single function).


> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/usb/gadget/config.c |    2 +-
>  include/linux/usb_gadget.h  |    6 ------
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> --- linux-2.6.11-rc4-mm1-full/include/linux/usb_gadget.h.old	2005-02-28 23:15:09.000000000 +0100
> +++ linux-2.6.11-rc4-mm1-full/include/linux/usb_gadget.h	2005-02-28 23:15:24.000000000 +0100
> @@ -854,12 +854,6 @@
>  
>  /*-------------------------------------------------------------------------*/
>  
> -/* utility to simplify managing config descriptors */
> -
> -/* write vector of descriptors into buffer */
> -int usb_descriptor_fillbuf(void *, unsigned,
> -		const struct usb_descriptor_header **);
> -
>  /* build config descriptor from single descriptor vector */
>  int usb_gadget_config_buf(const struct usb_config_descriptor *config,
>  	void *buf, unsigned buflen, const struct usb_descriptor_header **desc);
> --- linux-2.6.11-rc4-mm1-full/drivers/usb/gadget/config.c.old	2005-02-28 23:15:34.000000000 +0100
> +++ linux-2.6.11-rc4-mm1-full/drivers/usb/gadget/config.c	2005-02-28 23:15:49.000000000 +0100
> @@ -39,7 +39,7 @@
>   * as part of configuring a composite device; or in other cases where
>   * sets of descriptors need to be marshaled.
>   */
> -int
> +static int
>  usb_descriptor_fillbuf(void *buf, unsigned buflen,
>  		const struct usb_descriptor_header **src)
>  {
> 
> 
> 
>
