Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbUEQTJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUEQTJj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUEQTJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:09:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13290 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262205AbUEQTJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:09:36 -0400
Date: Mon, 17 May 2004 12:09:25 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Sebastien Chaumat <schaumat@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: please apply the old patch from Georg Acher in 2.4 tree
Message-Id: <20040517120925.44ae3af1.zaitcev@redhat.com>
In-Reply-To: <1083011181.982.6.camel@muetdhiver>
References: <1083011181.982.6.camel@muetdhiver>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004 22:26:21 +0200
Sebastien Chaumat <schaumat@free.fr> wrote:

>  I tried the patch from Georg Acher (posted 2001/08). It saved me from a
> lot of troubles with a brand news USB2 hub that refuses to take an
> address with  my nforce2 motherboard.
> 
> @@ -2177,18 +2178,31 @@
>  	dev->epmaxpacketin [0] = 8;
>  	dev->epmaxpacketout[0] = 8;
>  
> -	err = usb_set_address(dev);
> -	if (err < 0) {
> -		err("USB device not accepting new address=%d (error=%d)",
> -			dev->devnum, err);
> -		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
> -		dev->devnum = -1;
> -		return 1;
> -	}
> +	for(m=0;m<2;m++) {
> +		for(n=0;n<2;n++) {			
> +			err = usb_set_address(dev);
> +			if (err>=0)
> +				break;
> +			wait_ms(200);
> +		}

I see this was admitted to 2.6, with nice symbolic constants, too.
But before taking this, I would like someone to do this:
 1. posess a device which flakes like the above
 2. take the 2.6 version rediff and test it
 3. explain to me why he or she cannot just run 2.6 and be content

If Sebastien is willing to clear these hurdles I erected (and mentions the
vendor and device number of his hub), I'll think about it. But it would be
best if someone else came forward.

-- Pete
