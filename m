Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSGDNwI>; Thu, 4 Jul 2002 09:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317416AbSGDNwH>; Thu, 4 Jul 2002 09:52:07 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:61426 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S317415AbSGDNwH>; Thu, 4 Jul 2002 09:52:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: Device Model Docs
Date: Thu, 4 Jul 2002 17:54:26 +0200
User-Agent: KMail/1.4.2
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0207030924010.8496-100000@geena.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33.0207030924010.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207041754.26986.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 July 2002 18:46, Patrick Mochel wrote:

> However, in any class, there may be multiple interfaces available for a
> particular device. It's these interfaces that userspace sees. A driver may
> implement some or all of those interfaces, and they may or may not be
> present based on the configuration of the kernel.

Ah, that's the missing bit, at least the tape driver is no problem then. There 
is still a slightly different case that I'm not sure about. In the case of 
CTC, the type of a device is determined during probe (depending on what's on 
the other side, but the driver handles both tty and network ctc devices. It 
seems logical if this type maps to a device class, not an interface, as there 
is no network device that ever implements a tty interface or vice versa (in 
ppp, you have a parent-child relationship between these, not identity).
I suppose then, the ctc module should actually implement two drivers, one
for each class and handle detection in the two probe methods, right?

A similar example is the 'lcs' network driver, whose devices can be either
ethernet, token ring or fddi NICs. You said that these would be subclasses
of the network class, but could lcs also be simply belong to a non-specific 
network driver class and not put each device in the respective sub class?
Or would it make more sense to have special subclass just for network
drivers with more than one layer-2 protocol?

	Arnd <><
