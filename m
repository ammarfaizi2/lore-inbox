Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRDYTht>; Wed, 25 Apr 2001 15:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbRDYThk>; Wed, 25 Apr 2001 15:37:40 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:22954 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S131480AbRDYTh3>; Wed, 25 Apr 2001 15:37:29 -0400
Date: Wed, 25 Apr 2001 14:37:06 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104251937.OAA27702@tomcat.admin.navo.hpc.mil>
To: tim@tjansen.de, Dan Kegel <dank@kegel.com>
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
In-Reply-To: <01042520555600.00849@cookie>
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Wednesday 25 April 2001 19:10, you wrote:
> > The command
> >   more foo/* foo/*/*
> > will display the values in the foo subtree nicely, I think.
> 
> Unfortunately it displays only the values. Dumping numbers and strings 
> without knowing their meaning (and probably not even the order) is not very 
> useful.
> 
> > Better to factor the XML part out to a userspace library...
> 
> But the one-value per file approach is MORE work. It would be less work to 
> create XML and factor out the directory structure in user-space :)
> Devreg collects its data from the drivers, each driver should contribute the 
> information that it can provide about the device.
> Printing a few values in XML format using the functions from xmlprocfs is as 
> easy as writing
> proc_printf(fragment, "<usb:topology port=\"%d\" portnum=\"%d\"/>\n",
>                 get_portnum(usbdev), usbdev->maxchild);
> 
> Extending the devreg output with driver-specific data means registering a 
> callback function that prints the driver's data. The driver should use its 
> own XML namespace, so whatever the driver adds will not break any 
> (well-written) user-space applications. The data is created on-demand, so the 
> values can be dynamic and do not waste any space when devreg is not used. 
> 
> The code is easy to read and not larger than a solution that creates static 
> /proc entries, and holding the data completely static would take much more 
> memory. And it takes less code than a solution that would create the values 
> in /proc dynamically because this would mean one callback per file or a 
> complicated way to specify several values with a single callback. 

Personally, I think

	proc_printf(fragment, "%d %d",get_portnum(usbdev), usbdev->maxchild);

(or the string "dddd ddd" with d representing a digit)

is shorter (and faster) to parse with

	fscanf(input,"%d %d",&usbdev,&maxchild);

Than it would be to try parsing

	<usb:topology port="ddddd" portnum="dddd">

with an XML parser.

Sorry - XML is good for some things. It is not designed to be a
interface language between a kernel and user space.

I am NOT in favor of "one file per value", but structured data needs
to be written in a reasonable, concise manner. XML is intended for
communication between disparate systems in an exreemly precise manner
to allow some self documentation to be included when the communication
fails.

Even Lisp S expressions are easier :-)

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
