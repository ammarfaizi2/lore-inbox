Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317598AbSGEXhh>; Fri, 5 Jul 2002 19:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317599AbSGEXhh>; Fri, 5 Jul 2002 19:37:37 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:49572 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317598AbSGEXhg>; Fri, 5 Jul 2002 19:37:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: Device Model Docs
Date: Sat, 6 Jul 2002 03:36:54 +0200
User-Agent: KMail/1.4.2
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0207051101520.8496-100000@geena.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33.0207051101520.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207060336.55075.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 July 2002 20:10, Patrick Mochel wrote:
> This is similar to the input layer. Initially, I had grouped specific
> devices into subclasses. But, I learned that a device really belongs to
> multiple subclasses (e.g. evdev and mouse). Hence the concept of one class
> with multiple interfaces...

I think this network device is a bit different. While AFAICS the mouse has 
both interfaces at the same time, an lcs adapter always has exactly one
interface, but depending on some device properties, the interface can be 
called _either_ 'eth0' or 'tr0' (or probably something else for fddi).

A possible class model to represent this might be:
- each device_driver belongs to one device_class
- a device_class has one or more subclasses
- a device belongs to one subclass of its drivers class
- a subclass has one or more interfaces that are implemented for
  every device of this subclass

This is of course more complicated than your single class - multiple
interfaces solution but could be closer to what the drivers do today.
The tradeoff probably depends on how many drivers are as broken
as lcs and on how fine-grained you want your classes to be.

Arnd <><
