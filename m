Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbTEGF6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTEGF6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:58:37 -0400
Received: from franka.aracnet.com ([216.99.193.44]:17103 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262234AbTEGF6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:58:36 -0400
Date: Tue, 06 May 2003 20:56:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Mannthey <kmannth@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][Patch] fix for irq_affinity_write_proc v2.5
Message-ID: <2770000.1052279813@[10.10.2.4]>
In-Reply-To: <1052250874.1202.162.camel@dhcp22.swansea.linux.org.uk>
References: <1052247789.16886.261.camel@dyn9-47-17-180.beaverton.ibm.com> <1052250874.1202.162.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   irq_affinity_write_proc currently directly calls set_ioapic_affinity
>> which writes to the ioapic.  This undermines the work done by kirqd by
>> writing a cpu mask directly to the ioapic. I propose the following patch
>> to tie the /proc affinity writes into the same code path as kirqd. 
>> Kirqd will enforce the affinity requested by the user.   
> 
> Why should the kernel be enforcing policy here. You have to be root to 
> do this, and root should have the ability to configure apparently stupid
> things because they may find them useful.

Whilst in general, I'd agree, in this case it makes no sense - there are
two masks set: the irqbalance mask, and the apicid mask. If irqbalance
is on, setting the apicid mask doesn't really do anything, because 
irqbalance is going to reset it dynamically very shortly afterwards
anyway. It's hard to imagine how that might be useful ;-)

It might conceivably be useful to disable irqbalance dynamically, if that's
what you mean, but that shouldn't be the default behaviour, I think. 
Keith already a nice simple patch to make it a config option ... doing it 
dynamically is a different project, IMHO, and one of questionable utility 
to anyone not capable of coding it themselves ;-)

M.

