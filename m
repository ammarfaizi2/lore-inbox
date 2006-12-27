Return-Path: <linux-kernel-owner+w=401wt.eu-S964808AbWL0Xu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWL0Xu1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 18:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWL0Xu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 18:50:27 -0500
Received: from rrcs-71-40-84-210.sw.biz.rr.com ([71.40.84.210]:36983 "EHLO
	hamlet.sw.biz.rr.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964808AbWL0Xu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 18:50:26 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: The Input Layer and the Serial Port
Cc: "James, <jsimmons@infradead.org>, loye.young@iycc.net, Simmons"@iycc.net
Message-Id: <20061227235400.358E43FC065@hamlet.sw.biz.rr.com>
Date: Wed, 27 Dec 2006 17:54:00 -0600 (CST)
From: loyeyoung@iycc.net (Loye Young)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nothing is hard if you already know how." -- Unknown

"Nadie nace enseñó." -- Mexican proverb. ("Nobody is born taught.")

>All you need to do is write the device interface.

I wish that I knew how to program in C, and that I knew how to recompile the kernel. But C is Greek to me. Besides, it is a language so holy that it cannot be spoken.

Surely this has been done before. Perhaps you have already, because you say:

>Take for example the AT keyboard which is
>one of the most common keyboards in the world. I have seen and
>used it attached to a PC via parport, serial port and the standard
>PS/2 port. So to handle cases like this the input layer created a
>serio interface. 

If plain ASCII text is coming in the serial port, would the kernel know or even care what device was generating the characters? Could I just use whatever interface you did?

How does the input subsystem and udev know how to populate /dev/input? Does evdev automagically pick up everything in /dev/input?

>I recommend you take a look at sermouse.c 
>in the drivers/input.mouse directory
>for a guide.

I looked, but the source code I have (2.6.17, Debian) doesn't have anything called sermouse.c in the /drivers/input directory.

I'm still Clue Minus One on how to make my scanner work.

[Warning Will Robinson! Danger! Rant mode ON!]

"Cobbler, you have no shoes."

Perhaps I am misunderstanding something, but why does the world need a unique, handwritten, geek-speak device driver for every gadget in the universe? I have to think that writing the device drivers and interfaces for most input devices is a huge exercise in reinventing the wheel all over again. (This is admittedly the luxury of one such as myself, who has never written one.) And, even assuming there are such instances, why should the kernel developers be the only ones writing them. 

(The following was written by someone who doesn't know what he is talking about, to those who do. It is likely that the latter will think the former is ignorant in whole or in part, because such are the facts. Suspension of critical thinking at the micro level is consequently necessary.)

When I read (though not understood) Linux Device Drivers, 3d edition, the question that kept coming to my mind is "Why can't this be automated? Can the Three Wise Men most of LDD3 in C instead of English?" 

The kernel has a discrete, documented set of inputs. Well, they will be documented when OSDL hires that technical writer. Or maybe sometime else. In any event, there are specific, well-known actions that the kernel can be told to do. The King Penguin and his Court know ex ante the complete list of such actions. Code has or can be written for each possible command to the kernel. Let the count of such kernel commands be equal to K.

Likewise, there are a limited number of buses over which the information to and fro all the various devices can be sent. Again, we know ex ante what they are and should be able to code the translations between what comes in from the bus and what commands get issued. Let the count of such buses be equal to B. 

The count of all possible input commands for all buses (let such count be equal to I) is K times B. (K x B = I) "I" may be a large number, but not an insurmountable one.

In particular, input devices such as character generators and pointers have a discrete set of outputs. Engineers of the devices design their widgets with a target set of outputs in mind. They know that the devices will be attached to computers and design the devices for a particular bus. They know the requirements for the bus they are designing for. (Pardon the ending preposition.) Consequently, it must be possible to anticipate the possible universe of outputs from most devices on a particular bus and allow a user to map the device outputs to the appropriate command. In most cases, we know what the device will send, or most of it anyway, so a default list of commands will work just fine. 

All that is remaining is to configure the idiosyncratic events that some engineer felt was way-cool and different. A generic program can be written to listen for what the device sends and map it to one of I commands. There are "snoop" programs available for most, if not all, buses. It must be possible, therefore, to automate the entire process in a user-space program. First, the program would interview the user. It would start off by making an attempt to discover all devices connected and presenting a list to the user. "Which device do you want to configure?" The user would have an "Other Device" option to tell the machine which connection on which bus the device is using. Next, the program would ask for the type of device being configured (character generator, pointer, etc.) and for any relevant information not obtainable via PnP (manufacturer, model, etc.). Now the program knows quite a bit about the device and can narrow the field of likely choices from I to a subset of K. The user then teaches the program the device's lingo. Fire off the device, assign a command. Fire of the device, assign another command. 

At the end of the process, the program can write the source code and documentation for the driver, compile the binary, and even offer to insert the module into the kernel on the fly. And, so that the King Penguin is never surprised by any sharks with lasers, the program will offer to email the driver and binary to someone in a land that vowels forgot or to someone with a hyphen in his name for the benefit of all Penguins. Perhaps the Three Wise Men would be able to tweak the driver for efficiency, but they would have the benefit of a first draft generated by a program they wrote or at least reviewed. 

I'm not the only one who has thought along these lines. A program with similar functionality as what I am describing has been written for USB keyboards. See http://keytouch.sourceforge.net/.

[End Rant Mode]

All this,  is far afield of my original question. How do I tell the input layer to send the information coming in from my serial port barcode scanner to the applications on my box?

Respectfully submitted,

Loye Young
Laredo, Texas


way-cool and different. A generic program can be written to listen for what the device sends and map it to one of I commands. There are "snoop" programs available for most, if not all, buses. It must be possible, therefore, to automate the entire process in a user-space program. First, the program would interview the user. It would start off by making an attempt to discover all devices connected and presenting a list to the user. "Which device do you want to configure?" The user would have an "Other Device" option to tell the machine which connection on which bus the device is using. Next, the program would ask for the type of device being configured (character generator, pointer, etc.) and for any relevant information not obtainable via PnP (manufacturer, model, etc.). Now the program knows quite a bit about the device and can narrow the field of likely choices from I to a subset of K. The user then teaches the program the device's lingo. Fire off the device, assign a command. Fire of the device, assign another command. 

At the end of the process, the program can write the source code and documentation for the driver, compile the binary, and even offer to insert the module into the kernel on the fly. And, so that the King Penguin is never surprised by any sharks with lasers, the program will offer to email the driver and binary to someone in a land that vowels forgot or to someone with a hyphen in his name for the benefit of all Penguins. Perhaps the Three Wise Men would be able to tweak the driver for efficiency, but they would have the benefit of a first draft generated by a program they wrote or at least reviewed. 

I'm not the only one who has thought along these lines. A program with similar functionality as what I am describing has been written for USB keyboards. See http://keytouch.sourceforge.net/.

[End Rant Mode]

All this,  is far afield of my original question. How do I tell the input layer to send the information coming in from my serial port barcode scanner to the applications on my box?

Respectfully submitted,

Loye Young
Laredo, Texas


