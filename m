Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbSKRV6L>; Mon, 18 Nov 2002 16:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSKRV5Y>; Mon, 18 Nov 2002 16:57:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12813 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265012AbSKRVze>;
	Mon, 18 Nov 2002 16:55:34 -0500
Message-ID: <3DD96358.6050701@pobox.com>
Date: Mon, 18 Nov 2002 17:02:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Tulip driver fails to link (2.5.48)
References: <15833.24514.280850.81268@wombat.chubb.wattle.id.au>
In-Reply-To: <15833.24514.280850.81268@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:

> Hi,
> 	In the tulip driver,  the .remove entry of struct pci_driveris
> declared __devexit_p but the function  is declared __exit.  This
> causes a relocation error when building as a built-in (not a module),
> when CONFIG_HOTPLUG is defined.


Yes...  alan snuck that __devexit_p usage in there ;-)

We need to create __exit_p as the #warning indicates, because this 
driver does not support CONFIG_HOTPLUG intentionally.  For now, I think 
it is better to add #ifdef MODULE to the driver in struct pci_driver 
definition, because using "__devexit" as in your patch is incorrect.

So if you wanted to submit the patch changing __devexit_p to #ifdef 
MODULE, that could probably be applied...

	Jeff



