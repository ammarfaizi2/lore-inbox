Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVCOFWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVCOFWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVCOFV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:21:59 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31468 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262259AbVCOFVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:21:31 -0500
Date: Mon, 14 Mar 2005 23:20:59 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Awful long timeouts for flash-file-system
In-reply-to: <3I8gq-gw-23@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <423670BB.2090107@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3I8gq-gw-23@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> 
> Hello IDE experts.
> 
> I am trying to use a SanDisk SDCFB-256, CFA DISK drive. This
> is supposed to emulate an IDE drive and does (sort of). However,
> upon boot, the boot-code keeps trying and trying and trying to
> do SOMETHING that aparently isn't even necessary because the
> virtual disk is accessible and can be written/read and I can
> even boot from it.

> hdb: max request size: 128KiB
> hdb: 501760 sectors (256 MB) w/1KiB Cache, CHS=980/16/32, DMA
> hdb: cache flushes not supported
>  hdb:<4>hdb: dma_timer_expiry: dma status == 0x61

I'm assuming you're using a CF-to-IDE adapter to hook up the card. Most 
likely your CompactFlash card is indicating that it supports DMA and the 
kernel is trying to use it. However, many CF-to-IDE adapters don't hook 
up the DMA control lines properly so the requests all time out until the 
  kernel gives up using DMA.

We use some Mesa Electronics CF-IDE adapters at work - some of the newer 
ones have some jumpers with positions NOR and DMA, DMA works if the 
jumpers are set to the DMA position. I don't think we've tried using any 
DMA-supporting CF cards on the older ones without these jumpers.

If the adapter you're using doesn't do DMA, I believe that if you use 
options like hdb=nodma or ide1=nodma, etc. that will get the kernel to 
not try and use it.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

