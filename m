Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVBQStn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVBQStn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 13:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVBQStn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 13:49:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29868 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262289AbVBQStg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 13:49:36 -0500
Message-ID: <4214E728.3030501@pobox.com>
Date: Thu, 17 Feb 2005 13:49:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Christophe Lucas <c.lucas@ifrance.com>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH] drivers/char/watchdog/* : pci_request_regions
References: <20050214150111.GH20620@rhum.iomeda.fr> <20050214151244.GF29917@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050214151244.GF29917@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Mon, Feb 14, 2005 at 04:01:11PM +0100, Christophe Lucas wrote:
> 
>>If PCI request regions fails, then someone else is using the
>>hardware we wish to use. For that one case, calling
>>pci_disable_device() is rather rude.
>>See : http://www.ussg.iu.edu/hypermail/linux/kernel/0502.1/1061.html
> 
> 
> Actually, that isn't necessarily true.  If the request_regions call fails,
> that can mean there's a resource conflict.  If so, leaving the device
> enabled is the worst possible thing to do as we'll now have two devices
> trying to respond to the same io accesses.

Incorrect.  If request_region() fails, drivers are coded to _not_ touch 
the hardware.  That's the entire purpose of the whole charade: to avoid 
having two devices responding to the same io accesses.

If your driver is talking to the hardware after request_region() fails, 
it is BROKEN plain and simple.

	Jeff



