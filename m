Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbSLFRCn>; Fri, 6 Dec 2002 12:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbSLFRCn>; Fri, 6 Dec 2002 12:02:43 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:38627 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264934AbSLFRCm>; Fri, 6 Dec 2002 12:02:42 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 6 Dec 2002 09:07:16 -0800
Message-Id: <200212061707.JAA22194@baldur.yggdrasil.com>
To: James.Bottomley@steeleye.com
Subject: Re: [RFC] generic device DMA implementation
Cc: david@gibson.dropbear.id.au, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Dec 2002, James Bottomley wrote:
>adam@yggdrasil.com said:
>> 	I like your term DMA_CONSISTENT better than DMA_CONFORMANCE_CONSISTANT
>> .  I think the word "conformance" in there does not reduce the time
>> that it takes to figure out what the symbol means.  I don't think any
>> other facility will want to use the terms DMA_{,IN}CONSISTENT, so I
>> prefer that we go with the more medium sized symbol. 

>I'm not so keen on this.  The idea of this parameter is not to tell the 
>allocation routine what type of memory you would like, but to tell it what 
>type of memory the driver can cope with.  I think for the inconsistent case, 
>DMA_INCONSISTENT looks like the driver is requiring inconsistent memory, and 
>expecting to get it.  I'm open to changing the "CONFORMANCE" part, but I'd 
>like to name these parameters something that doesn't imply they're requesting 
>a type of memory.

	How about renaming DMA_INCONSISTENT to DMA_MAYBE_CONSISTENT?

	By the way, I previously suggested a flags field to indicate
what the driver could cope with.  0 would mean consistent memory, 1's
would indicate other things that the driver could cope with that would
be added if and when a real need for them arises (read caching, write
back cachine, cpu-cpu consistency, cache line size smaller than 2**n
bytes, etc.).  Regarding the debugging capability of
DMA_CONFORMANCE_NONE, I don't think that will be as useful in the way
that DMA_DIRECTION_NONE is, because transfer direction is often passed
through the io path of a device driver and errors in doing so are a
common.  In comparison, I think the calls to dma_malloc will typically
have this argument specified as a constant where the call is made,
with the possible exception of some allocation being consolidated in
the generic device layer.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
