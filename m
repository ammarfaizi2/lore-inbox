Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTFIVZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTFIVZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:25:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:29323 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262127AbTFIVZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:25:27 -0400
Date: Mon, 9 Jun 2003 14:40:33 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
In-Reply-To: <20030609212348.GB508@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306091428470.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The deviation is *not* trivial, and because I can not give you example
> does not mean it does not exist.

I removed one parameter from two methods because every use of it tested 
for it to be a certain value. Other values of that parameter were simply 
not used. I've explicitly stated why; how those methods are called. As a 
result, the code is simpler and the semantics for suspending/resuming 
system devices are simpler. 

And, because you cannot provide me a counter-example does mean that 
alternative values of the paramter 'level' are not used and therefore do 
not exist. 

> Well, can you be a little more concrete? I do not see any description
> about what is system device and what is not.
> 
> Keyboard controller is very deeply integrated into the system. If it
> is not system device, what is it?

I apologize that the description of system devices is not in the driver 
model documentation. From the linux.conf.au paper:

System-level devices are devices that are integral to the routine
operation of the system. This includes devices such as processors,
interrupt controllers, and system timers. System devices do not follow
normal read/write semantics. Because of this, they are not typically
regarded as I/O devices, and are not represented in any standard
way. 

They do have an internal representation, since the kernel does
communicate with them, and does expose a means to exert control over
some attributes of some system devices to users. They are also
relevant in topological representations. System power management
routines must suspend and resume system devices, as well as normal I/O
devices. And, it is useful to define affinities to instances of system
devices in systems where there are multiple instances of the same type
of system device.

These features can happen in architecture-specific code. But, the
driver model's generic representation of devices provides an
opportunity to consolidate, at least partially, the representations
into architecture-independent ones. 


-------------------

Keyboard fall into the other non-traditional device category - system 
devices, which are devices that do not appear to reside on a peripheral 
bus, but are still represented in the device hierarchy as regular devices.


	-pat

