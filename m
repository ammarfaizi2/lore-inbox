Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423033AbWBAXf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423033AbWBAXf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 18:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423035AbWBAXf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 18:35:26 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:18833 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423033AbWBAXfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 18:35:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IGnvRb+Lvj84GRGgJSIm1Udk8G7geC3jpf1Qd9p981S/ADtGgDsbgPpZ0RjsGEmVV8VcxfJQ0xXIZBREE1cayAlRq/zvrhu9zockD4kch1FKeJNk+f75X5/cgfmA+tA2D3mLPrXaXSph/GUjXBSe8tL9QbGboSkq6+LHzviel38=
Message-ID: <43E145B8.6090404@gmail.com>
Date: Thu, 02 Feb 2006 08:35:20 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <43E13F57.40808@gmail.com> <20060201231911.GA5463@tentacle.sectorb.msk.ru>
In-Reply-To: <20060201231911.GA5463@tentacle.sectorb.msk.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir B. Savkin wrote:
> On Thu, Feb 02, 2006 at 08:08:07AM +0900, Tejun Heo wrote:
> 
>>Vladimir B. Savkin wrote:
>>
>>>Hello!
>>>
>>>My system based on Asus A8V (VIA chipset) works fine with 2.6.13.3,
>>>but after upgrading (kernels 2.6.14.7 and 2.6.15.1 tried) it
>>>gaves error messages some minutes after boot.
>>>
>>>The messages are as following:
>>> ata2: command 0xXX timeout, stat 0x50 host_stat 0x4
>>>where XX gets different values from time to time, 0x25 mostly.
>>>I/O to this controller halts after that.
>>>
>>>Attached are boot dmesg log and lspci output.
>>>
>>
>>How reproducible is the problem?  With how much certainty can you say 
>>the problem is introduced by newer kernels?  e.g. If the problem occurs 
>>most of the time with 2.5.15.1 but it stops happending after switching 
>>back to 2.6.13.3, you can be pretty sure.
> 
> 
> Highly reproducible: months vs. minutes of uptime.
> 
> 

Your BMDMA controller is reporting raised interrupt (0x4) and your drive 
is saying that it's ready for the next command, yet interrupt handler of 
sata_via hasn't run and thus the timeout.  It looks like some kind of 
IRQ routing problem to me although I have no idea how the problem 
doesn't affect the boot process.

Can you try to boot with boot parameter pci=noacpi?

-- 
tejun
