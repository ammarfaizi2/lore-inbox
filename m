Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSLBQQ1>; Mon, 2 Dec 2002 11:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSLBQQ0>; Mon, 2 Dec 2002 11:16:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62737 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264631AbSLBQQ0>;
	Mon, 2 Dec 2002 11:16:26 -0500
Message-ID: <3DEB8916.6090901@pobox.com>
Date: Mon, 02 Dec 2002 11:23:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Ashley <dash@xdr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18 8139too.c driver fix for mii-tool
References: <200212021611.gB2GBqD00707@xdr.com>
In-Reply-To: <200212021611.gB2GBqD00707@xdr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ashley wrote:
> mii-tool doesn't work with the 8139too.c driver (RTL8139 based network cards).
> Internally the driver uses phy ID #'s 32+, but when ioctls are used to
> access the phy registers, the ID is masked down to 0-0x1f, so none of them
> work properly, and mii-tool fails.
> 
> The fix is to change the masking done in the top of netdev_ioctl:
> 	if (cmd != SIOCETHTOOL) {
> 		/* With SIOCETHTOOL, this would corrupt the pointer.  */
> 		data->phy_id &= 0x3f; // was 0x1f (DA) 20021202
> 		data->reg_num &= 0x1f;
> 	}


Already fixed in the latest stable kernel, 2.4.20.

But thanks for testing though!

