Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWCVL3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWCVL3x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 06:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWCVL3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 06:29:53 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:51161 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750731AbWCVL3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 06:29:53 -0500
In-Reply-To: <1143016607.2955.14.camel@laptopd505.fenrus.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063758.453555000@sorel.sous-sol.org> <1143016607.2955.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <280dfa6948b4c3321e4630d75fa9f5b5@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 23/35] Add support for Xen event channels.
Date: Wed, 22 Mar 2006 11:30:09 +0000
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 08:36, Arjan van de Ven wrote:

>> +#include <linux/interrupt.h>
>> +#include <linux/sched.h>
>> +#include <linux/kernel_stat.h>
>> +#include <linux/version.h>
>
> this highly looks that it's not possible to be used outside the linux
> kernel so the license is odd

It can't be used directly, but other OS ports steal fairly directly 
from this file (and others). For example OpenSolaris and the BSDs.

>> +static int find_unbound_irq(void)
>> +{
>> +	int irq;
>> +
>> +	for (irq = 0; irq < NR_IRQS; irq++)
>> +		if (irq_bindcount[irq] == 0)
>> +			break;
>> +
>> +	if (irq == NR_IRQS) {
>> +		printk(KERN_ERR "No available IRQ to bind to: increase 
>> NR_IRQS!\n");
>
> there is no way to share interrupts? A shame

256 allocatable IRQs seems plenty to be getting on with. Shared IRQs 
can certainly be added later -- there are no hidden gotchas I'm pretty 
sure.

  -- Keir

