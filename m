Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266580AbUFRTZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266580AbUFRTZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266587AbUFRTXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:23:46 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:21725 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S266578AbUFRTVR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:21:17 -0400
Message-ID: <40D34078.5060909@pacbell.net>
Date: Fri, 18 Jun 2004 12:20:24 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Ian Molton <spyro@f2s.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
References: <1087582845.1752.107.camel@mulgrave>	<20040618193544.48b88771.spyro@f2s.com>	<1087584769.2134.119.camel@mulgrave> <20040618195721.0cf43ec2.spyro@f2s.com>
In-Reply-To: <20040618195721.0cf43ec2.spyro@f2s.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Molton wrote:
> On 18 Jun 2004 13:52:46 -0500
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> 
> 
>>You still haven't explained what you want to do though.  Apart from the
>>occasional brush with usbstorage, I don't have a good knowledge of the
>>layout of the USB drivers.  I assume you simply want to persuade the
>>ohci driver to use your memory area somehow, but what do you actually
>>want the ohci driver to do with it?  And how much leeway do you get to
>>customise the driver.

A fair amount, so long as drivers above it don't need to
change much at all (this is "stable").  That includes
usbcore and all the usb drivers.

> 
> In *theory* the OHCI driver is doing everything right - its asking for DMAable memory and using it. if the DMA api simply understood the device in question, and alocated accordingly, it would just work.
> 
> there are two solutions:
> 
> 1) Break up the OHCI driver and make it into a chip driver as you describe

It's heading that way already ... breaking along the lines
where standard APIs solve problems, such as this.

> 2) Make the DMA API do the right thing with these devices
> 
> 1) means everyone gets to write their own allocator - not pretty
> 2) means we get to share code and it all just works.
> 

For example, if usbaudio uses usb_buffer_alloc to stream data,
that eliminates dma bouncing.  That's dma_alloc_coherent at
its core ... it should allocate from that 32K region.

- Dave




