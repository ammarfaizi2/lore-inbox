Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUBKKkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 05:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUBKKkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 05:40:16 -0500
Received: from gamma.utc.fr ([195.83.155.32]:13493 "EHLO gamma.utc.fr")
	by vger.kernel.org with ESMTP id S262078AbUBKKkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 05:40:10 -0500
Message-ID: <1076496008.402a0688ad0aa@mailetu.utc.fr>
Date: Wed, 11 Feb 2004 11:40:08 +0100
From: eric.piel@tremplin-utc.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Erdfelt <johannes@erdfelt.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Slight optimisation of the uhci-hcd init code
References: <Pine.LNX.4.44L0.0402091657520.871-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0402091657520.871-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Spam-Checked-By: localhost
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Stern <stern@rowland.harvard.edu>:

> It's a nice idea.  I was planning to alter the logic behind that nested
> "if" anyway, and I'll keep your recommendation in mind when I do it.
Great

> > PS: still, I'm not sure it's normal to see ffffffff as "bus master
> activity" in
> > /proc/acpi/processor/CPU0/power as soon as uhci-hcd is loaded. In
> particular, it
> > prevents the processor to go to C3 state. Could you give me your pint of
> view?
> 
> I'm not sure exactly what the ffffffff value means -- maximum utilization?
Yes, more exactly it means that the last 64 times the idle task was called the
bus master was detected as being used.


> Anyway, a UHCI host controller is a bus master and it can generate a lot
> of activity depending on what USB devices are plugged in.  If no USB
> devices are plugged, the controller will be suspended after 1 second.  
> Of course then it shouldn't be accessing the PCI bus at all.
> 
> There is one exception to this.  Some manufacturers try to disable unused
> USB ports on their motherboards by tying the overcurrent input permanently
> high.  (This seems to be particularly common among laptops.)  With some
> Intel controllers this strategy generates "device-connected" interrupts,
> so the driver doesn't try to suspend the controller.  There's a patch to
> fix this behavior currently being tested.
Well, my laptop seems fine. When I unplug the mouse the bus master activity goes
to 0000000. I've very little idea about how the bus master has to be used and
even less about the uhci host controller. However, at a first glance I thought
it was weird to see full bus master activity when all that is connected is a
mouse not being used. Do you think it's normal? 

Eric

