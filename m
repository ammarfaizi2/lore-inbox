Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSGCQtr>; Wed, 3 Jul 2002 12:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSGCQto>; Wed, 3 Jul 2002 12:49:44 -0400
Received: from air-2.osdl.org ([65.172.181.6]:417 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317184AbSGCQtK>;
	Wed, 3 Jul 2002 12:49:10 -0400
Date: Wed, 3 Jul 2002 09:46:04 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Device Model Docs
In-Reply-To: <200207031226.g63CQND76592@d12relay01.de.ibm.com>
Message-ID: <Pine.LNX.4.33.0207030924010.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Jul 2002, Arnd Bergmann wrote:

> Patrick Mochel wrote:
>  
> > Everyone is encouraged to have a look. Feel free to send me comments,
> > corrections, or patches.
> 
> In binding.txt, you write:
> > Upon the successful completion of probe, the device is registered with
> > the class to which it belongs. Device drivers belong to one and only
> > class, and that is set in the driver's devclass field.
> 
> I have two drivers (drivers/s390/char/tape.c and drivers/s390/net/ctcmain.c)
> that might have problems with this. S390 tapes are available through two
> interfaces, a character device implementing the standard tape interface
> and a block device that allows you to mount a filesystem written to a tape 
> (unlike most tape drives, they allow random access reads).

There are actually several types of devices that have several interfaces. 
In fact, I wouldn't be suprised if the majority of devices were like this. 

Like a SCSI disk - you have a SCSI generic interface, a disk interface, 
and possibly a raw interface. 

All input devices have at least two interfaces: the general event 
interface and the device specific interface (e.g. keyboard, mouse, etc). 

A device is really of only one type, though. A disk is a disk, regardless 
of how you access it. It's the device type that device classes are 
representative of, so I maintain the assertion in the document holds true.

However, in any class, there may be multiple interfaces available for a
particular device. It's these interfaces that userspace sees. A driver may
implement some or all of those interfaces, and they may or may not be
present based on the configuration of the kernel.

I never considered distinguishing between classes and interfaces until 
just before OLS, and there I realized it was absolutely necessary. The 
interfaces userspace sees are device nodes, and it's the interfaces in the 
kernel that are tied to major number allocation, rather than the class 
itself (which I had thought). 

The device model doesn't provide for multiple interfaces...yet. It's 
really not that difficult of a problem; it's more a matter of taste in how 
to declare and reference them (which has a lot of bearing on the success 
of the solution). 

	-pat

