Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUDSQkH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUDSQkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:40:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25485 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261443AbUDSQj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:39:57 -0400
Message-ID: <408400CF.6010203@pobox.com>
Date: Mon, 19 Apr 2004 12:39:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: baycom_par dereference before check.
References: <20040416212004.GO20937@redhat.com> <20040416212541.GH24997@parcelfarce.linux.theplanet.co.uk> <20040416212738.GQ20937@redhat.com> <408054C9.5070202@pobox.com> <20040416215319.GW20937@redhat.com>
In-Reply-To: <20040416215319.GW20937@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Apr 16, 2004 at 05:48:57PM -0400, Jeff Garzik wrote:
> 
>  > >Good point. Still doesn't strike me as particularly nice though.
>  > I would rather just remove the checks completely.  The success of any of 
>  > those checks is a BUG() condition that should never occur.
> 
> That works for me too. How about this?
> 
> 		Dave
> 
> --- linux-2.6.5/drivers/net/hamradio/baycom_par.c~	2004-04-16 22:52:35.000000000 +0100
> +++ linux-2.6.5/drivers/net/hamradio/baycom_par.c	2004-04-16 22:52:53.000000000 +0100
> @@ -274,8 +274,8 @@
>  	struct net_device *dev = (struct net_device *)dev_id;
>  	struct baycom_state *bc = netdev_priv(dev);
>  
> -	if (!dev || !bc || bc->hdrv.magic != HDLCDRV_MAGIC)
> -		return;
> +	BUG_ON(!bc);
> +	BUG_ON(bc->hdrv.magic != HDLCDRV_MAGIC);


I applied a patch which simplied removed the checks.

	Jeff



