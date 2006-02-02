Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWBBLus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWBBLus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWBBLus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:50:48 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:15146 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750720AbWBBLur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:50:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tejZx7OdX6KChxlfNPjBQ9ul4W+k/akNp8j98AyvUShLc7Ra3yo3tyTabYNbaSAEF+/03WIHQJvA2pzVPA5qxLImg2UQztpilESAmX4TZC8mUFNXGeRuiUzKjl8Fuos/NDatqbdRVneAe1IYf0pzpKZWRTQDvpeM0FxsIBa+JxQ=
Message-ID: <43E1F211.8030507@gmail.com>
Date: Thu, 02 Feb 2006 20:50:41 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <43E13F57.40808@gmail.com> <20060201231911.GA5463@tentacle.sectorb.msk.ru> <43E145B8.6090404@gmail.com> <20060202114429.GA3035@tentacle.sectorb.msk.ru>
In-Reply-To: <20060202114429.GA3035@tentacle.sectorb.msk.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir B. Savkin wrote:
> On Thu, Feb 02, 2006 at 08:35:20AM +0900, Tejun Heo wrote:
> 
>>Your BMDMA controller is reporting raised interrupt (0x4) and your drive 
>>is saying that it's ready for the next command, yet interrupt handler of 
>>sata_via hasn't run and thus the timeout.  It looks like some kind of 
>>IRQ routing problem to me although I have no idea how the problem 
>>doesn't affect the boot process.
>>
>>Can you try to boot with boot parameter pci=noacpi?
> 
> 
> That did not help.
> 
> And yes, irqbalance is running, as Kenneth suggested.
> 

Sadly, I'm pretty much ignorant with that part of the kernel.  However, 
if it's really because interrupts are lost when sent to one of the 
processors, one of the following should keep the system going while the 
other cause the problem immediately.

echo 1 > /proc/irq/your_IRQ_number/smp_affinity

or...

echo 2 > /proc/irq/your_IRQ_number/smp_affinity

-- 
tejun
