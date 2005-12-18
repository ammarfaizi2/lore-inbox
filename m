Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965289AbVLRWlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbVLRWlv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbVLRWlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:41:51 -0500
Received: from [85.8.13.51] ([85.8.13.51]:49076 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S965289AbVLRWlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:41:50 -0500
Message-ID: <43A5E5A6.4050505@drzeus.cx>
Date: Sun, 18 Dec 2005 23:41:42 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
References: <437C40AE.2020309@drzeus.cx> <20051117085432.GY7787@suse.de> <437C4728.9060205@drzeus.cx> <20051117091308.GZ7787@suse.de> <437C4D14.1030101@drzeus.cx> <20051117093848.GA7787@suse.de>
In-Reply-To: <20051117093848.GA7787@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Revisiting a dear old thread. :)

After some initial tests, some more questions popped up. See below.

Jens Axboe wrote:
> On Thu, Nov 17 2005, Pierre Ossman wrote:
>   
>> Since there is no guarantee this will be mapped down to one segment
>> (that the hardware can accept), is it expected that the driver iterates
>> over the entire list or can I mark only the first segment as completed
>> and wait for the request to be reissued? (this is a MMC driver, which
>> behaves like the block layer)
>>     
>
> Ah MMC, that explains a few things :-)
>
> It's quite legal (and possible) to partially handle a given request, you
> are not obliged to handle a request as a single unit. See how other
> block drivers have an end request handling function ala:
>
>   

After testing this it seems the block layer never gives me more than
max_hw_segs segments. Is it being clever because I'm compiling for a
system without an IOMMU?

The hardware should (haven't properly tested this) be able to get new
DMA addresses during a transfer. In essence scatter gather with some CPU
support. Since I avoid MMC overhead this should give a nice performance
boost. But this relies on the block layer giving me more than one
segment. Do I need to lie in max_hw_segs to achieve this?

Rgds
Pierre

