Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVBOCGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVBOCGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 21:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVBOCGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 21:06:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28804 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261594AbVBOCGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 21:06:18 -0500
Message-ID: <42115906.3040003@pobox.com>
Date: Mon, 14 Feb 2005 21:05:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: avoiding pci_disable_device()...
References: <4210021F.7060401@pobox.com> <20050214190619.GA9241@kroah.com>	 <4211013E.6@pobox.com> <1108411352.5994.27.camel@localhost.localdomain>
In-Reply-To: <1108411352.5994.27.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>No.  You also need to consider situations such as out-of-tree drivers 
>>for the same hardware (might not use PCI API), and situations where you 
>>have peer devices discovered and used (PCI API doesn't have "hey, <this> 
>>device is associated with <current driver>, too" capability)
> 
> 
> 
> there's not a lot you or anyone else can do about such broken (and often
> proprietary) drivers.... if a device doesn't use the kernel API's its
> end of game basically. Adding more new API's isn't going to help you ...


This specific instance isn't about adding a new API, but using an 
existing one correctly.

If pci_request_regions() fails, that implies another driver is using the 
kernel API to let you know the region is unavailable.  You should honor 
that, by not disabling the hardware in that case.

	Jeff


