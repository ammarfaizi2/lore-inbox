Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291377AbSBMFDa>; Wed, 13 Feb 2002 00:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291374AbSBMFDV>; Wed, 13 Feb 2002 00:03:21 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:9464 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S291373AbSBMFDD>; Wed, 13 Feb 2002 00:03:03 -0500
Message-ID: <3C69F385.5050207@linuxhq.com>
Date: Wed, 13 Feb 2002 00:03:01 -0500
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020206
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 sound module problem
In-Reply-To: <fa.f4gi5iv.1ikenrc@ifi.uio.no> <fa.fo94urv.167g1q5@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> On Tuesday 12 February 2002 19:51, Albert Cranford wrote:
> 
>>Not sure if this was the same message I received. but here
>>is the patch I used to get around my sound problem in
>>2.5.4.
>>
> 
> Are you sure this is correct?  include/asm/io.h seems to indicate that i/o 
> addresses for PCI may not map correctly.  The sound card I am using is PCI, 
> not ISA.

You should not use isa_virt_to_bus.  IIRC someone on this list worried 
about this exact thing happening.


> Documentation/DMA-mapping.txt says that virt_to_bus is completly depreciated 
> and nothing should be using it.  Well, grepping the kernel source shows that 
> quite a bit still uses it.

This is on the kernel janitor TODO, and we (janitors) will be tackling 
this shortly.  But your instinct is right, virt_to_bus shouldn't be 
everywhere.

> What it looks like, on first glance, is that virt_to_bus  was changed for pci 
> devices to give this error message.  (Since that symbol goes nowhere.)  That 
> effects a number of things, not just sound. (A whole bunch of cardbus drivers 
> I would guess...)

This is correct.  It has been a policy to use pci_alloc_consistent 
instead of kmalloc/getfreepages and virt_to_bus, 2.5 is enforcing it now.

It is boring work to change this in many drivers, but I don't know any 
better so I think it quite fun to go in and help :).  I'll start sending 
patches to the relevant maintainers shortly.

By the way, anyone know who the maintainer is for the persistent DMA 
buffer code?

-- 
(o- j o h n   e   w e b e r
//\  http://www.linuxhq.com/people/weber/
v_/_ john.weber@linuxhq.com

