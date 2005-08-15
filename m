Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVHOFuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVHOFuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 01:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVHOFuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 01:50:08 -0400
Received: from fsmlabs.com ([168.103.115.128]:55468 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751082AbVHOFuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 01:50:07 -0400
Date: Sun, 14 Aug 2005 23:55:44 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Russ Weight <rweight@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][2.6.12.3] IRQ compression/sharing patch
In-Reply-To: <200508141957.53396.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0508142347550.6740@montezuma.fsmlabs.com>
References: <200507260012.41968.jamesclv@us.ibm.com> <200508040005.50817.jamesclv@us.ibm.com>
 <20050804092221.GL8266@wotan.suse.de> <200508141957.53396.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005, James Cleverdon wrote:

> > > +static int next_irq = 16;
> >
> > Won't this need a lock for hotplug later?
> 
> That's what I thought originally, but maybe not.  We initialize all RTEs 
> and assign IRQs+vectors fairly early in boot, plus store the results in 
> arrays.  Thereafter the functions just return the preallocated values.
> 
> Hmmm...  Since the I/O APIC init comes after the other CPUs are brought 
> online, and since I don't understand all that the MSI driver is trying 
> to accomplish, it might be safer to use a spin lock anyway.

With respect to vector allocation, the MSI driver locks around 
assign_irq_vector, it doesn't look like next_irq is used in that path so 
you shouldn't need a lock if it's only used in single threaded init. This 
of course would change if IOAPICs were added after boot.

