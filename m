Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVF1I60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVF1I60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVF1Iye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:54:34 -0400
Received: from znsun1.ifh.de ([141.34.1.16]:48299 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S261424AbVF1Iwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:52:40 -0400
Date: Tue, 28 Jun 2005 10:51:45 +0200 (CEST)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub5.ifh.de
To: Johannes Stezenbach <js@linuxtv.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [DVB patch 17/51] flexcop: add big endian register definitions
In-Reply-To: <20050627231430.GA8701@linuxtv.org>
Message-ID: <Pine.LNX.4.61.0506281041090.12435@pub5.ifh.de>
References: <20050627120600.739151000@abc> <20050627121412.899787000@abc>  
   <20050627155046.1c44bbdd.akpm@osdl.org> <20050627231430.GA8701@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 28 Jun 2005, Johannes Stezenbach wrote:
>>> +	struct {
>>> +		u32 dma_address0                   :30;
>>> +		u32 dma_0No_update                 : 1;
>>> +		u32 dma_0start                     : 1;
>>> +	} dma_0x0;
>>> ...
>>> +
>>> +	struct {
>>> +		u32 dma_0start                     : 1;
>>> +		u32 dma_0No_update                 : 1;
>>> +		u32 dma_address0                   :30;
>>> +	} dma_0x0;
>>
>> Oh dear.  This is a good demonstration of the downside of trying to use
>> compiler bitfields to represent hardware registers.  I have vague memories
>> of writing BFINS and BFEXT in 3c59x to stomp this problem.
>>
>> I don't think there's any guarantee that the code you have there will work
>> on all architectures/compiler versions btw.
>>
>> Also...  The code appears to be assuming that BE architectures will
>> bit-reverse their bitfields.  Is that right?  I'd expect them to only
>> byte-reverse them?
>
> Probably the code should use __BIG_ENDIAN_BITFIELD /
> __LITTLE_ENDIAN_BITFIELD instead of __BIG_ENDIAN / __LITTLE_ENDIAN?
> Anyway, the comment from the CVS commit suggests that it was tested.

According to the user, it is tested and it is running flawlessly for
2 weeks now.

> I completely agree that this code is ugly as hell. It was the obvious, 
> simple fix to make the driver work on PowerPC (and a few users happy), 
> though. Rewriting the driver not to use bitfields seems to be quite a 
> bit of work. Blame me for not paying enough attention when the initial 
> flexcop driver was submitted ;-(

It's my fault. The driver (skystar2) which has been replaced by the 
flexcop-driver was so complicated to read, because of an IMHO abuse of 
bitmask and bit-shifting. I absolutely wanted to bring more readability to 
that driver without having the endian-issue in mind (rewrite was possible 
after the vendor released the data sheets). Sorry for that.

regards,
Patrick.

--
   Mail: patrick.boettcher@desy.de
   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
