Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265659AbRF1Mfl>; Thu, 28 Jun 2001 08:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbRF1Mfb>; Thu, 28 Jun 2001 08:35:31 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:51787 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265655AbRF1MfK>; Thu, 28 Jun 2001 08:35:10 -0400
Date: Thu, 28 Jun 2001 07:35:06 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106281235.HAA84447@tomcat.admin.navo.hpc.mil>
To: acmay@acmay.homeip.net, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: What is the best way for multiple net_devices
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Wed, Jun 27, 2001 at 06:04:02PM -0400, Jeff Garzik wrote:
> > andrew may wrote:
> > > 
> > > Is there a standard way to make multiple copies of a network device?
> > > 
> > > For things like the bonding/ipip/ip_gre and others they seem to expect
> > > insmod -o copy1 module.o
> > > insmod -o copy2 module.o
> > 
> > The network driver should provide the capability to add new devices.
> 
> I am planning to write or patch some drivers to do this as well as other
> things. 
> 
> I would want to add things at run time after the module is alreaded loaded.
> So options to the module won't work.
> 
> I don't know how to use ifconfig to create a new device.

Ifconfig doesn't create the new device, when the driver module is loaded
it looks for all devices on the bus and creates the table with those
entries. To locat them, an "ifconfig -a" will do

> Any examples of drivers and apps that do this cleanly. The ones I have
> seen are not.

The only one I've seen are SCSI ( I believe it was done with
"echo 1 >/proc/.... ". If a new device is present (turned on) the new
entry is appended.

Another one (similar) is the parport. Loading parport_probe rescans, and
defines the new devices.

Another is a module version of IDE. unload/loading ide-probe rescans
the IDE devices.

These ARE clumsy because you have to unload them to do a rescan, also
I think the tables are contained inside the probe module. I don't think
you can unload the probe module if one of the devices is busy (though the
SCSI version might be closer to what you want, it is also the most complex).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
