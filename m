Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263842AbUE1Tyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbUE1Tyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbUE1Tyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:54:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:33239 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263842AbUE1Ty3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:54:29 -0400
Message-ID: <40B7984E.7040208@us.ibm.com>
Date: Fri, 28 May 2004 12:51:42 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
References: <7F740D512C7C1046AB53446D372001730182BAE2@scsmsx402.amr.corp.intel.com> <40B7797F.2090204@pobox.com> <17750000.1085766378@flay> <20040528175724.GC9898@devserv.devel.redhat.com>
In-Reply-To: <20040528175724.GC9898@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> On Fri, May 28, 2004 at 10:46:18AM -0700, Martin J. Bligh wrote:
> 
>>Personally, I find the argument that it's hardware-specific control code
>>a much better reason for it to belong in the kernel. 
> 
> 
> Is it really hardware specific ??

I have limited knowledge on this, but a great deal of interest.
So, please forgive some stupid questions and wrong assumptions.

The irqbalanced is a user space daemon that attempts to
balance irqs across CPUs. It keeps track of the current
irq counts on the CPUs, and at regular intervals applies
changes to irq binding in order to implement the desired
policy. It achieves a high-level long term balance of irqs
across CPUs.

This is a fairly expensive but generally arch independent
(as long as they support cpu binding of irqs) method to
achieve long term distribution of interrupts.

I think this is best used for fairly balanced (over time)
long running workloads. For short workloads which demonstrate
intense activity in bursts, this won't be as effective.

For fine grained balancing of interrupts, I don't see how
you can avoid implementing something in hw/fw/low level
kernel.

I see networking interrupts requiring fine granularity
balancing, to avoid the potential for dropped packets and
long latencies.  That is, given a busy server that is
seeing a lot of interrupts, fair distribution of the
interrupts is required within a very small amount of time,
and we cannot require a user space daemon that parses the /proc
file system and applies a policy and then rebinds irqs
to different CPUs to run with that frequency.

I would like (with my very limited knowledge) something
that would automatically on every interrupt send it to
the optimum CPU (one that was idle, or least loaded)..
This might involve too much overhead to keep track of,
but some improvement over round robining of the interrupts
coming in should be possible..

Does this make sense?

thanks,
Nivedita

