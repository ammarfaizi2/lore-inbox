Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153878AbPGGXRz>; Wed, 7 Jul 1999 19:17:55 -0400
Received: by vger.rutgers.edu id <S153861AbPGGXRo>; Wed, 7 Jul 1999 19:17:44 -0400
Received: from mea.tmt.tele.fi ([194.252.70.162]:2533 "EHLO mea.tmt.tele.fi") by vger.rutgers.edu with ESMTP id <S153680AbPGGXRE>; Wed, 7 Jul 1999 19:17:04 -0400
Date: Thu, 8 Jul 1999 02:16:45 +0300
From: Matti Aarnio <matti.aarnio@sonera.fi>
To: Jim Nance <jlnance@sailboat.mis.uncwil.edu>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: IBM Mainframe Support
Message-ID: <19990708021645.F26016@mea.tmt.tele.fi>
References: <199907070645.BAA05227@shadygrove.linas.org> <19990707182336.A26917@sailboat.mis.uncwil.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <19990707182336.A26917@sailboat.mis.uncwil.edu>; from Jim Nance on Wed, Jul 07, 1999 at 06:23:36PM -0400
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, Jul 07, 1999 at 06:23:36PM -0400, Jim Nance wrote:
> On Wed, Jul 07, 1999 at 01:45:10AM -0500, Linas Vepstas wrote:
> > Hi,
> > 
> > I have patches to the Linux kernel that add support for the IBM
> > mainframe ESA/390 series of computers (and clones e.g. Hitachi
> 
> This is great!  I glanced at the web page, but its not clear to me if the
> kernel will run in a VM, of if you need the entire machine.  I sort of
> got the idea that it would not run in a VM.

	Add some extra privilege bits to your VM account, and you
	will be able to run guest operating systems just fine.

	It is so long since I have ran IX/370 at an 3033 complex, that
	I don't remember details anymore :-(  --  but my library contains
	bound copy of IX/370 manuals :-)  ( Compacts them from about two
	meters of binders to half a meter of books. )
	( I collect odd computer manuals for possible reference use.. )

	A problem at IX/370 time (and still, I think) is that IBM
	mainframes don't have asynchronous serial ports, nor any
	equivalent interfaces. Mega-IO-throughput, and async serial
	interfaces don't really mix...  Back then a Series/1 computer
	was hooked into a channel attachment, and it acted as serial
	port multiplexor processor.  ( IBM mainframes are like any
	other computer, just that all interfaces they have are alike
	SCSI ...  Attachment to network/terminals/disks/whatnot goes
	via attachment units. )

	Installation guide has these notes for the IX370 virtual machine:

	"IX/370 Entry in the VM/SP Directory"

	USER IX370 password 4M 16M G  # Start with 4 MB memory, max 16 MB
	IPL CMS			  # Do IPL to CMS
	ACCOUNT nnnnnn
	OPTION ECMODE BMX SVCACCL # For running guest operating-systems
				  # in VM/SP, SVCACCL is for use of
				  # "VM/SP Handshaking" facility (optional)
	CONSOLE ... 
	IUCV ALLOW		# allows incoming IUCV messages
	OPTION MAXCONN  nn	# how many concurrent IUCV sessions

	+++ DASD defines, SPOOL defines, etc +++

	There is then an EXEC3 script for a set of CP commands to be
	executed at the virtual machine boot, then doing another
	IPL from a disk where the real IX/370 boot loader image is
	resident.

	At IBM mainframes there is *no* BIOS, *NOTHING*.
	Also, there are no initial filesystems from which to pull
	anything, there are just device interface addresses to which
	you speak with archaic IO commands.

	You tell the VM/CP program at first to attach certain parts
	of physical disks to your virtual machine, and activate them.
	Then you do Initial Program Load (IPL) from any of loadable
	devices (including your virtual card reader), and the program
	you want to use comes up.

	Because you usually want to do something more convenient, than
	IPL from hard/virtualized devices, VM/SP users usually have
	(had) their IPL as CMS - Conversational Monitor(ing) System.
	If you compare CMS with anything more widely known, it was
	back then "CP/M Done Right".  (Filenames were 8+8, no stupid
	8+3 things.  But no directories either!)


	I am afraid running Linux at "Big Iron" will be a curiousity
	issue... ... but i you get it up, I would love to have a guest
	account :)

> Jim

/Matti Aarnio <matti.aarnio@sonera.fi> -- these days using silicon instead
					  of iron :)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
