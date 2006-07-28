Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161295AbWG1Uoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161295AbWG1Uoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbWG1Uoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:44:44 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:42129 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1161295AbWG1Uon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:44:43 -0400
Message-ID: <44CA7738.4050102@bootc.net>
Date: Fri, 28 Jul 2006 21:44:40 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: [RFC] Proposal: common kernel-wide GPIO interface
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

More and more devices these days come with some sort of GPIO interface, and more 
and more drivers within the kernel could make use of a common way of accessing 
pins on such an interface, not to mention userspace apps. For example, we have 
the I2C, LED, and SPI subsystems that each could drive a device that's actually 
connected to some GPIO pins somewhere.

I propose to develop a common way of registering and accessing GPIO pins on 
various devices. Now I'm no hardware expert, but I do like to dabble a bit and 
would love to see such a system be developed. Most people tend to attach stuff 
like LCD displays to their parallel ports, but GPIOs are much better suited to 
such a purpose than a parallel port. Some (out of tree) drivers even emulate a 
parallel interface in order that userspace software can be fooled to use the 
GPIO pins as a parallel port. In my view, this is ugly.

As far as I can tell, GPIO interfaces all share the following attributes:
- One or more ports made up of one or more individual pins
- Value on input or output depending on configuration
- Various configuration bits might be available to influence the pin's behaviour
   - Direction
   - Push-pull / Open drain
   - Pull-up enable
   - Possibly others

We'll need some way of assigning pins to different functions I'm guessing as 
well, especially when we come to write drivers for the interface. It might not 
fit right into the GPIO driver, but as far as I can see the I2C, LED, and SPI 
subsystem drivers would need such a method to create generic 
GPIO<=>{I2C,LED,SPI} drivers.

As well as a kernel interface I propose a userspace interface of some kind. I'm 
not entirely sure what might be the most efficient way of doing this, but the 
current standard way seems to be to create a sysfs class interface, although an 
old-fashioned device interface with IOCTLs and so on might be the best way 
forward. Any suggestions?

As for drivers, to start with I suggest a parallel port driver as well as 
drivers for the NSC SCx200 and PC8736x (since I own a board with both of those).

So, if anyone likes this idea and/or has some comments, please voice your 
opinions! With a little guidance from the masters, I'm willing to put the effort 
in to code such a system, but I'd really like to hear what people involved both 
in the hardware side and software side of GPIOs and the kernel have to say about 
such an interface.

Many thanks,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
