Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVBNTzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVBNTzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 14:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVBNTzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 14:55:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43473 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261546AbVBNTzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 14:55:11 -0500
Message-ID: <42110210.6030900@pobox.com>
Date: Mon, 14 Feb 2005 14:54:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: avoiding pci_disable_device()...
References: <4210021F.7060401@pobox.com>	<20050214190619.GA9241@kroah.com>	<s5h7jlbc5ci.wl@alsa2.suse.de>	<20050214193413.GA10231@kroah.com> <s5h650udiqb.wl@alsa2.suse.de>
In-Reply-To: <s5h650udiqb.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Mon, 14 Feb 2005 11:34:13 -0800,
> Greg KH wrote:
> 
>>On Mon, Feb 14, 2005 at 08:24:29PM +0100, Takashi Iwai wrote:
>>
>>>At Mon, 14 Feb 2005 11:06:19 -0800,
>>>Greg KH wrote:
>>>
>>>>>As a result, I have committed the attached patch to libata-2.6.  In many 
>>>>>cases, it is a "semantic fix", addressing the case
>>>>>
>>>>>	* pci_request_regions() indicates hardware is in use
>>>>>	* we rudely disable the in-use hardware
>>>>>
>>>>>that would not occur in practice.
>>>>>
>>>>>But better safe than sorry.  Code cuts cut-n-pasted all over the place.
>>>>>
>>>>>I'm hoping one or two things will happen now:
>>>>>* janitors fix up the other PCI drivers along these lines
>>>>>* improve the PCI API so that pci_request_regions() is axiomatic
>>>>
>>>>Do you have any suggestions for how to do this?
>>>
>>>How about to add an exclusiveness check in pci_enable_device()?
>>>Most drivers suppose that the given pci resources are exclusively
>>>available.
>>
>>You mean only allow pci_enable_device() to work for the first caller of
>>it?  I don't see how that would help this issue out.
> 
> 
> Well, for example, add a new pointer to indicate the driver accessing
> exclusively.  And pci_enable_device() (maybe a new variant would be
> better for compatibility) checks whether this is free.
> 
> The second caller wouldn't reach even to pci_request_regions() because
> of this check.  So, no side-effect of pci_disable_device() in the
> error path.

This doesn't work with a driver that is properly using 
request_resource(), but not using the PCI API.

	Jeff



