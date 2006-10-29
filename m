Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWJ2CGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWJ2CGW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 22:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWJ2CGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 22:06:22 -0400
Received: from xenotime.net ([66.160.160.81]:53908 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932118AbWJ2CGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 22:06:21 -0400
Date: Sat, 28 Oct 2006 19:01:57 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall
 levels
Message-Id: <20061028190157.55ae67b5.rdunlap@xenotime.net>
In-Reply-To: <1162078498.29146.11.camel@localhost.localdomain>
References: <20061026191131.003f141d@localhost.localdomain>
	<20061027170748.GA9020@kroah.com>
	<20061027172219.GC30416@elf.ucw.cz>
	<20061027113908.4a82c28a.akpm@osdl.org>
	<20061027114144.f8a5addc.akpm@osdl.org>
	<20061027114237.d577c153.akpm@osdl.org>
	<1161989970.16839.45.camel@localhost.localdomain>
	<20061027160626.8ac4a910.akpm@osdl.org>
	<20061028050905.GB5560@colo.lackof.org>
	<20061027221925.1041cc5e.akpm@osdl.org>
	<20061028060833.GC5560@colo.lackof.org>
	<4543C22A.2060203@s5r6.in-berlin.de>
	<1162078498.29146.11.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2006 00:34:57 +0100 Alan Cox wrote:

> Ar Sad, 2006-10-28 am 22:48 +0200, ysgrifennodd Stefan Richter:
> > I hear network interfaces can be selected by their MACs, which are
> > globally unique and persistent. Most SCSI hardware has globally unique
> > and persistent unit properties too, and udev indeed uses them these days.
> 
> You hear incorrectly. The MAC address is only required to be *machine
> unique*, please see the 802.1/2 specification documents for more detail.
> Distinguishing by card MAC is a hack that works on some systems only.

I would have expected "most" instead of "some", but you have
different experiences than I do.  What spec requires a MAC address
to be machine-unique?

IEEE "makes it possible for organizations to employ unique individual 
LAN MAC addresses, group addresses, and protocol identifiers."

IEEE 802 goes on to say:
"The concept of universal addressing is based on the 
idea that all potential members of a network need to
have a unique identifier (if they are going to coexist 
in the network). The advantage of a universal address is
that a station with such an address can be attached to any 
LAN in the world with an assurance that the address is unique."

and then "recommended" (but not required):

"The recommended approach is for each device associated 
with a distinct point of attachment to a LAN to
have its own unique MAC address. Typically, therefore, 
a LAN adapter card (or, e.g., an equivalent chip or
set of chips on a motherboard) should have one unique 
MAC address for each LAN attachment that it can
support at a given time.

and then this part seems contrary to the machine-unique quality
that you mentioned (I guess--don't know--that this is what
Sun used to do ?):

"NOTE—It is recognized that an alternative approach has 
gained currency in some LAN implementations, in which the
device is interpreted as a complete computer system, 
which can have multiple attachments to different LANs. Under this
interpretation, a single LAN MAC address is used to 
identify all of the system’s points of attachment to the LANs in
question. This approach, unlike the recommended one, does 
not automatically meet the requirements of
IEEE Std 802.1D-1998 MAC bridging."


> SCSI is also unreliable for serial numbers because of USB, brain-dead
> raid controllers and other devices that fake the same ident for many
> devices.
> 
> There is another ugly too - many driver/library layers "know" that
> during boot the code is not re-entered so has no locking. Before you can
> go multi-probe you also have to fix all the locking in the drivers that
> have boot time specific functionality (eg IDE).

---
~Randy
