Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131756AbRDWUha>; Mon, 23 Apr 2001 16:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131742AbRDWUhV>; Mon, 23 Apr 2001 16:37:21 -0400
Received: from dire.bris.ac.uk ([137.222.10.60]:2781 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S131724AbRDWUhJ>;
	Mon, 23 Apr 2001 16:37:09 -0400
Date: Mon, 23 Apr 2001 21:34:40 +0100 (BST)
From: Matt <madmatt@bits.bris.ac.uk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ioctl arg passing
In-Reply-To: <Pine.LNX.4.33.0104232155230.1417-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0104232120191.7619-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rui.sousa mentioned the following:

| On Mon, 23 Apr 2001, Ingo Oeser wrote:
| 
| > Can you elaborate on the dsp card? Is it freely programmable? I'm
| > working on a project to support this kind of stuff via a
| > dedicated subsystem for Linux.
| 
| Very interesting... The emu10k1 driver (SBLive!) that will appear
| shortly in acXX will support loading code to it's DSP. It's a very
| simple chip with only 16 instructions but it can generate
| hardware interrupts, DMA to host memory, 32 bit math. The maximum
| program size is 512 instructions (64 bits each) and can make use of 256
| registers (32 bits).
| 
| Is there a web page for your project?

I haven't got one for my Linux port, but the company is Motionbase,
http://www.motionbase.com/, which at least has some piccy's of the
hardware in action. (Unless you meant Ingo's project, oops!)

The nature of driver is such that it's "useless" unless you have one of
these platforms, so it's not really for the average chap... :)

As the card offers analog inputs which are commonly used for
joysticks/steering wheels depending on the application being run, I plan
to create a joystick abstraction device that pipes the analog inputs
through the joystick interface too, so that any software can use joysticks
in a standard way regardless of whether they're using the platform or just
a regular PC. I'm developing for 2.2.x, but once that's working I'll adapt
the code for 2.4.x and use the event interface, devfs etc. where
necessary.

| > > copy_from_user( &local, ( struct instruction_t * ) arg, sizeof( struct instruction_t ) );
| > > temp = kmalloc( sizeof( __s16 ) * local.rxlen, GFP_KERNEL );
| > > copy_from_user( temp, arg, sizeof( __s16 ) * local.rxlen );
|                           ^^^ local.rxbuf, no ?

Yup, that's the one, hopefully everyone except me noticed that one! :)

Thanks for the help so far, appreciated.

Matt


