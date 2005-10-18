Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVJRUxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVJRUxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 16:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVJRUxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 16:53:39 -0400
Received: from mail.dvmed.net ([216.237.124.58]:33434 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932103AbVJRUxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 16:53:39 -0400
Message-ID: <435560D0.8050205@pobox.com>
Date: Tue, 18 Oct 2005 16:53:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rolandd@cisco.com>
CC: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: What is struct pci_driver.owner for?
References: <52sluymu26.fsf@cisco.com>
In-Reply-To: <52sluymu26.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> I just noticed that at some point, struct pci_driver grew a .owner
> member.  However, only a handful of drivers set it:
> 
>     $ grep -r -A10 pci_driver drivers/ | grep owner
>     drivers/block/sx8.c-    .owner          = THIS_MODULE,
>     drivers/ieee1394/pcilynx.c-     .owner =           THIS_MODULE,
>     drivers/net/spider_net.c-       .owner          = THIS_MODULE,
>     drivers/video/imsttfb.c-        .owner          = THIS_MODULE,
>     drivers/video/kyro/fbdev.c-     .owner          = THIS_MODULE,
>     drivers/video/tridentfb.c-      .owner  = THIS_MODULE,
> 
> Should all drivers be setting .owner = THIS_MODULE?  Is this a good
> kernel janitors task?

In theory its for module refcounting.  With so many PCI drivers and so 
few pci_driver::owner users, it makes me wonder how needed it is.

If it is needed (I've done no analysis, even though I am sx8.c author), 
then it should be applied uniformly.

	Jeff


