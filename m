Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWEPRjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWEPRjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWEPRjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:39:10 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:15206 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932177AbWEPRjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:39:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=daUaJji/ZR275JIGK4CKxq9tViIboz4rAilSPeO9Jh/A59pLNdDY3R5riAAH+G8wztbsKeRvfM/L0oFn06jI+n6uONGPrV/8Lfn0Cfv8+bGTzTw9a+WZOxXczt4hYSisGoyWw43NkvtVbm2/QHVJ87SF+GhS+uSaKIDGoVEt1pM=
Message-ID: <446A0E36.5060505@gmail.com>
Date: Wed, 17 May 2006 02:39:02 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Kevin Radloff <radsaq@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Fix broken PIO with libata
References: <1147790393.2151.62.camel@localhost.localdomain>	 <3b0ffc1f0605160833k5f6355c5n3f2a9ab1b211a95@mail.gmail.com>	 <1147794791.2151.71.camel@localhost.localdomain> <3b0ffc1f0605161019j7149f72bv309db19eb9d12dd8@mail.gmail.com> <446A0B6C.8050901@garzik.org>
In-Reply-To: <446A0B6C.8050901@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Kevin Radloff wrote:
>> On 5/16/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>> On Maw, 2006-05-16 at 11:33 -0400, Kevin Radloff wrote:
>>> > However, I still have a problem with pata_pcmcia (that I actually
>>> > experienced also with the ide-cs driver) where sustained reading or
>>> > writing to the CF card spikes the CPU with nearly 100% system time.
>>>
>>> That is normal. The PCMCIA devices don't support DMA. As a result of
>>> this the processor has to fetch each byte itself over the ISA speed
>>> PCMCIA bus link.
>>
>> Hrm, as I recall that only started happening with ide-cs sometime in
>> the single digits of 2.6.x.. And note that it's only maxing out at
>> about 1.5MB/s. Should that saturate my laptop's 1.1GHz Pentium M
>> processor?
> 
> Doing data xfer using PIO rather than DMA definitely eats tons of CPU 
> cycles.

Yeap, in addition, if doing real PIO (unbuffered by the HBA), the time 
it takes is soley determined by what PIO mode is in use.  It doesn't 
matter how fast the CPU is.  Faster CPUs only end up wasting more 
cycles.  :-(

-- 
tejun
