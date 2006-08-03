Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWHCPcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWHCPcz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWHCPcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:32:53 -0400
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:54983 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S964794AbWHCPcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:32:52 -0400
Date: Thu, 03 Aug 2006 17:32:48 +0200
From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: problems with e1000 and jumboframes
In-reply-to: <20060803142412.GA14997@kvack.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-id: <44D21720.6080202@arndnet.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
X-Enigmail-Version: 0.94.0.0
X-Spam-Report: * -2.8 ALL_TRUSTED Did not pass through any untrusted hosts
References: <44D1FEB7.2050703@arndnet.de> <20060803142412.GA14997@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise schrieb:
> On Thu, Aug 03, 2006 at 03:48:39PM +0200, Arnd Hannemann wrote:
>> However the box is a VIA Epia MII12000 with 1 GB of Ram and 1 GB of swap
>> enabled, so there should be plenty of memory available. HIGHMEM support
>> is off. The e1000 nic seems to be an 82540EM, which to my knowledge
>> should support jumboframes.
> 
>> However I can't always reproduce this on a freshly booted system, so
>> someone else may be the culprit and leaking pages?
>>
>> Any ideas how to debug this?
> 
> This is memory fragmentation, and all you can do is work around it until 
> the e1000 driver is changed to split jumbo frames up on rx.  Here are a 
> few ideas that should improve things for you:
> 
> 	- switch to a 2GB/2GB split to recover the memory lost to highmem
> 	  (see Processor Type and Features / Memory split)
> 	- increase /proc/sys/vm/min_free_kbytes -- more free memory will 
> 	  improve the odds that enough unfragmented memory is available for 
> 	  incoming network packets
> 
> I hope this helps.

:-) Yes it did. I increased /proc/sys/vm/min_free_kbytes to 65000 and
now it works. Thank you!

> 
> 		-ben

Best regards,
Arnd Hannemann



