Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318300AbSIKEeD>; Wed, 11 Sep 2002 00:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSIKEeD>; Wed, 11 Sep 2002 00:34:03 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1920 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318300AbSIKEeC>;
	Wed, 11 Sep 2002 00:34:02 -0400
Date: Tue, 10 Sep 2002 21:38:24 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Nicholas Miell <nmiell@attbi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: the userspace side of driverfs
In-Reply-To: <1031707119.1396.30.camel@entropy>
Message-ID: <Pine.LNX.4.44.0209102122520.1057-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Sep 2002, Nicholas Miell wrote:

> I see documentation describing the kernel interface for driverfs, but
> not much is available describing the userspace interface to driverfs --
> i.e. the format of all those files that driverfs exports.
> 
> In order to prevent driverfs from becoming the maze of twisted files,
> all different that is /proc, these details need to be specified now,
> before it's too late.

I agree. There has been a lot of talk on this topic, but I don't think 
much has gotten down on paper, though there might be some in the 
archives...

The main ideal that we're shooting for is to have one ASCII value per
file. The ASCII part is mandatory, but there will definitely be exceptions
where we will have an array of or multiple values per file. We want to
minimize those instances, though. Both for the sake of easy parsing, but
also for easy formatting within the drivers.


> Some issues I can think of off the top of my head:
> 
> - Can I safely assume that, for all normal files named X in driverfs,
> that they have the exact same format and purpose?

Yes. One of the pipe dreams I have, which will hopefully become a reality 
in the future is to document the attributes when they're defined with a 
docbook-like comment. These can then be extracted and inserted into a 
database. 

We're working on a utility that abstracts the layout of driverfs from the
user. This will allow you do things like list all the devices and drivers
of a particular bus or class type, as well as display their attributes. 
With a database of attribute descriptions, you can provide desciptive 
context along with the value of the attribute.

> - The "resource" files export resource structs, however the flags member
> of the struct uses bits that aren't exported by the kernel and are
> likely to change in the future. Also, some of the flags bits are
> reserved for use by the bus that the resource lives on, but the bus type
> isn't specified by the resource file, which requires the app to parse
> the path name in order to figure out which bus the resource refers to.

The flags bit is a good point, and should probably be removed. 

Taking a step back, I would like to note that it would be nice to do 
something at a higher level with the resource structures; i.e. put them in 
struct device and deal with them in the driver model core. This is ways 
out, though if it happens, it will likely have repercussions in their 
driverfs representation..

> - "name" isn't particularly consistent. Sometimes it requires parsing to
> be useful ("PCI device 1234:1234", "USB device 1234:1234", etc.",
> sometimes it's the actual device name, sometimes it's something strange
> like "Hub/Port Status Changes".

'name' is better referred to as 'description'. It's a bus-specified string  
that describes the device. The bus is allowed to do as it pleases with it.

	-pat

