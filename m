Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268626AbUHLRa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268626AbUHLRa6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268628AbUHLRa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:30:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20692 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268626AbUHLRay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:30:54 -0400
Message-ID: <411BA940.5000300@pobox.com>
Date: Thu, 12 Aug 2004 13:30:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux SATA RAID FAQ
References: <E1BvFmM-0007W5-00@calista.eckenfels.6bone.ka-ip.net> <1092315392.21994.52.camel@localhost.localdomain> <411BA7A1.403@pobox.com>
In-Reply-To: <411BA7A1.403@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Alan Cox wrote:
> 
>> end devices (eg aacraid sata boards). There are also some low end
>> devices with part of the raid logic in hardware (some promise) although
>> I don't believe we use that to the full yet.
> 
> 
> Nope.  My SATA RAID FAQ mentions the Promise "RAID accelerator" stuff. 

Clarification:  "nope" == "nope, we don't use that to the full yet"


> The SX4 has an on-board DIMM (128M - 2G), through which all data _must_ 
> pass.  The data transfer between host and on-board DIMM is a separate 
> DMA engine and separate interrupt event from the four ATA DMA engines 
> (one per SATA port).  There are several possibilities that are worth 
> exploring on this card:
> 
> * Caching
> * Eliminate PCI bus traffic by sending RAID1/5 writes a _single_ time to 
> the card, and then multiplex to multiple attached drives from there
> * Offload RAID5 XOR calculations, which becomes quite useful in 
> combination with these other features
> * Execute RAID1/5 resyncs and parity checks completely on the card

And one more:  the Promise hardware allows multiple disk transactions to 
be chained together in a sequence, such that, you only receive an 
interrupt when the full sequence is complete (or there is an error). 
You can look at it as either interrupt coalescing, or simply coalescing 
of multiple low-level disk transactions into a single "RAID transaction."

	Jeff


