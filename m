Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267171AbSLEBPD>; Wed, 4 Dec 2002 20:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267172AbSLEBPD>; Wed, 4 Dec 2002 20:15:03 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:42633 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267171AbSLEBPC>; Wed, 4 Dec 2002 20:15:02 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 4 Dec 2002 17:21:04 -0800
Message-Id: <200212050121.RAA03254@adam.yggdrasil.com>
To: jgarzik@pobox.com
Subject: Re: [RFC] generic device DMA implementation
Cc: davem@redhat.com, david@gibson.dropbear.id.au,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       miles@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
>On Wed, Dec 04, 2002 at 11:47:14AM -0600, James Bottomley wrote:
[...]
>> The new DMA API allows a driver to advertise its level of consistent memory 
>> compliance to dma_alloc_consistent.  There are essentially two levels:
>> 
>> - I only work with consistent memory, fail if I cannot get it, or
>> - I can work with inconsistent memory, try consistent first but return 
>> inconsistent if it's not available.
>
>Do you have an example of where the second option is useful?

	From a previous discussion, I understand that there are some
PCI bus parisc machines without consistent memory.

>Off hand
>the only places I can think of where you'd use a consistent_alloc()
>rather than map_single() and friends is in cases where the hardware's
>behaviour means you absolutely positively have to have consistent
>memory.

	That would result in big rarely used branches in device
drivers or lots of ifdef's and the equivalent.  With James's approach,
porting a driver to support those parisc machines (for example) would
involve sprinkling in some calls to macros that would compile to
nothing on the other machines.

	Compare the code clutter involved in allowing those
inconsistent parisc machines to run, say, the ten most popular
ethernet controllers and the four most popular scsi controllers.  I
think the difference in the resulting source code size would already
be in the hundreds of lines.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."



