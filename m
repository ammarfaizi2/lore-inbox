Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSGESN3>; Fri, 5 Jul 2002 14:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317528AbSGESN2>; Fri, 5 Jul 2002 14:13:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:47778 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317525AbSGESN0>;
	Fri, 5 Jul 2002 14:13:26 -0400
Date: Fri, 5 Jul 2002 11:10:21 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Device Model Docs
In-Reply-To: <200207041754.26986.arnd@bergmann-dalldorf.de>
Message-ID: <Pine.LNX.4.33.0207051101520.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Jul 2002, Arnd Bergmann wrote:

> On Wednesday 03 July 2002 18:46, Patrick Mochel wrote:
> 
> > However, in any class, there may be multiple interfaces available for a
> > particular device. It's these interfaces that userspace sees. A driver may
> > implement some or all of those interfaces, and they may or may not be
> > present based on the configuration of the kernel.
> 
> Ah, that's the missing bit, at least the tape driver is no problem then. There 
> is still a slightly different case that I'm not sure about. In the case of 
> CTC, the type of a device is determined during probe (depending on what's on 
> the other side, but the driver handles both tty and network ctc devices. It 
> seems logical if this type maps to a device class, not an interface, as there 
> is no network device that ever implements a tty interface or vice versa (in 
> ppp, you have a parent-child relationship between these, not identity).
> I suppose then, the ctc module should actually implement two drivers, one
> for each class and handle detection in the two probe methods, right?

Yes, exactly. 

> A similar example is the 'lcs' network driver, whose devices can be either
> ethernet, token ring or fddi NICs. You said that these would be subclasses
> of the network class, but could lcs also be simply belong to a non-specific 
> network driver class and not put each device in the respective sub class?
> Or would it make more sense to have special subclass just for network
> drivers with more than one layer-2 protocol?

Thinking about it some more, I'm wondering if we treat them only as 
belonging to the top-level networking class and have the layer-2 protocols 
be interfaces to those devices. For most devices, there would be only one 
interface, but it would also cover the case in which a device supports 
multiple prototcols. 

This is similar to the input layer. Initially, I had grouped specific 
devices into subclasses. But, I learned that a device really belongs to 
multiple subclasses (e.g. evdev and mouse). Hence the concept of one class 
with multiple interfaces...

	-pat

