Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261976AbREQQSB>; Thu, 17 May 2001 12:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbREQQRw>; Thu, 17 May 2001 12:17:52 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:4041 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261976AbREQQRi>; Thu, 17 May 2001 12:17:38 -0400
Date: Thu, 17 May 2001 09:17:04 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: LANANA: To Pending Device Number Registrants
To: Miles Lane <miles@megapathdsl.net>, Tim Jansen <tim@tjansen.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <0a5401c0deec$d06b1260$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <047801c0dd95$231331e0$6800000a@brownell.org>
 <01051601562302.01000@cookie> <990079966.25105.1.camel@agate>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > At this point of the discussion I would like to point to the Device Registry 
> > patch (http://www.tjansen.de/devreg) that already solves these problems and 
> > offers stable device ids for the identification of devices and finding their 
> > /dev nodes.
> > 
> > The devreg device id has four components: the bus identifier, the location of 
> > the device (for pci bus number and slot number, for usb the bus number and a 
> > list of port numbers), a model (product and device id) and, if available, a 
> > serial number. 
> 
> Hmm.  It's interesting to me that there have been no replies discussing
> Tim's code.  

I'd want to put it in the context of some of the USB work already done,
and also know how it generalizes to other busses ... 

For example, that usb-devname patch of mine, posted to linux-usb-devel
somewhere around 12/6/2000 (2.4.0-test12), which worked the issue
of teaching USB about "stable" identifiers (like pci slot_name, except
it didn't address functions within device configurations since PCI doesn't
have that notion of "configuration").

Or the patch providing a standard API for USB device drivers to report
what major/minor device numbers are associated with a given interface
(I think it was Alan Barnett who provided that).

Or the original (userspace) XML dump of XML tree structure, shown
at  http://jusb.sourceforge.net/?selected=tree ... it's not clear to me which
structural information there is also found in the "devreg" XML syntax
(from the kernel!), and which isn't.  (Class information omitted from
"devreg"?  Interface structure?)  Most of it's known to be needed.

For example, USB "bus numbers" are themselves unstable identifiers;
PCI slot_name fields work better, at least for host controllers (most!)
which use PCI.  If "devreg" uses "bus numbers", that needs to change.

- Dave


