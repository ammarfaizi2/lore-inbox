Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030624AbWBIKlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030624AbWBIKlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030626AbWBIKlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:41:21 -0500
Received: from mail.gmx.de ([213.165.64.21]:41886 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030624AbWBIKlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:41:20 -0500
X-Authenticated: #428038
Date: Thu, 9 Feb 2006 11:41:16 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jim@why.dont.jablowme.net, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060209104115.GA15173@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jim@why.dont.jablowme.net, linux-kernel@vger.kernel.org
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43EB0DEB.nail52A1LVGUO@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-09:

> Are you _really_ missing basic know how to understand that fsck is
> using the block layer of a virtual "block device" emulated by UNIX
> while libscg is offering _direct_ acces to _any_ type of device
> allowing you to send _commands_ understood by the device?

The key point that you are missing is that ONE device node allows you to
access the block layer as well as the mid layer. No more jumping hoops
to find out which auxiliary /dev/sr* device is associated with the
/dev/sg* you're talking to. No mapping abominations such as sg_map or
-scanbus are required to talk to the devices.

> fsck is just sending abstract instructions to a virtual device and does 
> not care about 

...what?

> Please explain me:
> 
> -	how to use /dev/hd* in order to scan an image from a scanner
> 
> -	how to use /dev/hd* in order to talk to a CPU device
> 
> -	how to use /dev/hd* in order to talk to a tape device
> 
> -	how to use /dev/hd* in order to talk to a printer
> 
> -	how to use /dev/hd* in order to talk to a jukebox
> 
> -	how to use /dev/hd* in order to talk to a graphical device

Well, you keep asking the question because you don't like the answer
that you've been given. It won't change just because you're asking
again.  The answer is still: You don't do that, and you've been told
several times.

Neither would you fsck a CPU, scan an image from a tape, rewind your CD
or request your scanner to change tapes.

The answer to all of the questions is also still: open the corresponding
/dev/* file and use SG_IO.

Where's the client code for libscg that scans, talks to CPU, printer,
sequential access device, jukebox or graphical device? Perhaps there is
none?

What is the practical device connected to Linux that libscg doesn't talk
to?  You were unable to provide examples where ATAPI tape doesn't work
(which isn't accessed via /dev/hd* BTW).

If you claim libscg is portable to Linux, you will have to accept that.
The kernel developers have decided that's their way to go, and I'm sure
as soon as a practical bug is found in that setup, you'll get the fix
quickly. I sent one fix for libscg that even simplifies the code, yet
you insist on using bugs that have been fixed a week ago as the basis
for your misguided attacks on Linux and Linux users.

This all only matters to you since you are trying to enforce the botched
view from some other OS (MS-Windows perhaps, although I'm not too sure
if it's really Windows or Jörg Schilling who is the problem in this
scenario either, and I'm a long way from defending Microsoft) onto
Linux, which you have been denied for 1½ years now, and from what I've
seen this year, with good reason.

IMO, after observing all this mess, /dev/sg* and other device nodes
should only be provided for devices not claimed by other drivers, and
all drivers should have SG_IO and other interfaces, to resolve
ambiguities in device naming. Having two device nodes for one device
doesn't seem right to me.

-- 
Matthias Andree
