Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933268AbWKSUuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268AbWKSUuw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933271AbWKSUuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:50:51 -0500
Received: from h155.mvista.com ([63.81.120.155]:9902 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S933268AbWKSUuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:50:51 -0500
Message-ID: <4560C409.9030709@ru.mvista.com>
Date: Sun, 19 Nov 2006 23:52:25 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
 type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>	 <1163966437.5826.99.camel@localhost.localdomain>	 <20061119200650.GA22949@elte.hu>	 <1163967590.5826.104.camel@localhost.localdomain>	 <4560BDF5.400@ru.mvista.com>	 <1163968376.5826.110.camel@localhost.localdomain>	 <4560C121.30403@ru.mvista.com> <1163968885.5826.116.camel@localhost.localdomain>
In-Reply-To: <1163968885.5826.116.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Benjamin Herrenschmidt wrote:

>>>EOI is a more "high level" thing that some "intelligent" PICs that
>>>automatically raise the priority do to restore the priority to what it
>>>was before the interrupt occured.

>>    Thank you, I know. Even 8259 has the notion of priority and EOI works the 
>>same way here.

> Ok, so why would you need an ack there then while eoi is just what you
> need ? :-)

    Don't ask me, ask the genirq authors. :-)

> Also, that's interesting what you are saying about 8259... I should be
> able to convert ppc's i8259 to use fasteoi too...

    I'm not sure it's feasible. The idea behind level/edge flows is to 
eliminate the interrupt priority I think. That's why they EOI ASAP (with the 
level handler masking IRQ before that) -- this way the other interrupts may 
come thru.
    I used to think that fasteoi was intended for SMP PICs which are 
intelligent enough to mask off the interrupts pending delivery or handling on 
CPUs and unmask them upon receiving EOI -- just like x86 IOAPIC does. This 
way, the acceptance of the lower priority interrupts shouldn't be hindered on 
the other CPUs. Maybe the scheme is different for OpenPIC (I know it has the 
different interrupt distribution scheme from IOAPIC)?

> Ben.

WBR, Sergei
