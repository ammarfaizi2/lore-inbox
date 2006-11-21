Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031092AbWKUQfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031092AbWKUQfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031073AbWKUQfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:35:05 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:5061 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1031176AbWKUQfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:35:04 -0500
Message-ID: <45632AB0.60507@lwfinger.net>
Date: Tue, 21 Nov 2006 10:34:56 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Ray Lee <ray-lk@madrabbit.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problem with DMA on x86_64 with 3 GB RAM
References: <455B63EC.8070704@madrabbit.org> <20061118112438.GB15349@nineveh.rivenstone.net> <1163868955.27188.2.camel@johannes.berg> <455F3D44.4010502@lwfinger.net> <455F4271.1060405@madrabbit.org> <455FF672.4070502@lwfinger.net> <456282DE.1000407@madrabbit.org> <20061121112829.19a9c043@localhost.localdomain>
In-Reply-To: <20061121112829.19a9c043@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>> Confused. As in, once the bcm43xx module initcall happens? Or without bcm43xx
>> at all? If the former, is the behavior different when built as a module versus
>> built-in? (ie, are there ordering problems.)
> 
> The pci_dma code on the x86_64 platform is broken for the case of PCI
> devices with < 32bit DMA. Has been forever, this is a problem with
> various devices, although most of the others are obsolete except for the
> bcm43xx and b44 (the latter has hacks to work around the x86-64
> brokenness).
> 
> At the very least the pci_set_dma_mask should error in this situation or
> switch to using GFP_DMA (24bit) memory spaces. Having it error isn't the
> whole solution as you still need some way to handle the "what do I do
> next". 

I agree that pci_set_dma_mask should at least return an error. That will protect the ignorant!

Thanks for the pointer to the b44 code. I'll try to fix bcm43xx the same way.

Larry
