Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSIHW7W>; Sun, 8 Sep 2002 18:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSIHW7W>; Sun, 8 Sep 2002 18:59:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29195 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315454AbSIHW7V>;
	Sun, 8 Sep 2002 18:59:21 -0400
Message-ID: <3D7BD740.8080906@mandrakesoft.com>
Date: Sun, 08 Sep 2002 19:03:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Zwane Mwaikambo <zwane@mwaikambo.name>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
References: <Pine.LNX.4.44.0209081453010.1293-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sun, 8 Sep 2002, Zwane Mwaikambo wrote:
> 
>>Here is a newer (untested) patch incorporating Ingo's suggestions as well 
>>as adding an extra request_irq flag so that isrs can use isr_unmask_irq() 
>>to enable their interrupt lines.
> 
> 
> Hmm.. I really don't get the point of what this is supposed to actually 
> help.
> 
> Clearly, if the device doesn't share the irq line, this doesn't matter. 
> Similarly, it shouldn't matter if there is just one device that is active 
> (ie irq line sharing with some slow device where the interrupt happens 
> fairly seldom).
> 
> As far as I can tell, the only time when this might be an advantage is an 
> SMP machine with multiple devices sharing an extremely busy irq line. Then 
> the per-isr in-progress bit allows multiple CPU's to actively handle 
> several of the devices at the same time.


IMO one should seek to avoid sharing an IRQ line at all.  I dunno that 
you really want to tune for that case, when the user could vastly 
improve the situation by manipulating IRQs in BIOS setup or similar 
IRQ-distribution methods.

On an SMP box you especially want to distribute irqs to take best 
advantage of irq affinity.

	Jeff


