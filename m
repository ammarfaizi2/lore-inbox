Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267642AbSLFWZ7>; Fri, 6 Dec 2002 17:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267638AbSLFWZ7>; Fri, 6 Dec 2002 17:25:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:37052 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267642AbSLFWZZ>;
	Fri, 6 Dec 2002 17:25:25 -0500
Date: Fri, 6 Dec 2002 16:13:15 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Jeff Garzik <jgarzik@pobox.com>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/pci deprecation?
In-Reply-To: <3DF121DD.6070206@pobox.com>
Message-ID: <Pine.LNX.4.33.0212061601550.1010-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Dec 2002, Jeff Garzik wrote:

> Patrick Mochel wrote:
> > ISTR /proc/pci being deprecated at one point in the past. It may have only
> > been discussed, though. In which case, is it possible to deprecate it?
> > lscpi(8) is considered a superior means to derive the same information.
> > 
> > Elimination of it would eliminate a chunk of code in drivers/pci/proc.c, 
> > and obviate the use of struct device::name by the PCI layer. This change 
> > would probably allow us to remove the name field altogether, since PCI is 
> > the only code that really relies on it (and only for /proc/pci AFAICT).
> 
> 
> Historically, this was a Linus call :)

Yeah, Randy said that about 30s before I got this. :)

> IIRC it was one of (a) deprecated, (b) removed, or (c) almost removed in 
> the past, and Linus un-deprecated it.  The logic back then was that it 
> provides a quick summary of a lot of useful info, a la /proc/cpuinfo and 
> /proc/meminfo.  i.e. you don't need lspci installed, just been /bin/cat.

Ok, I can see that. But, are there really many systems that do not come 
with lspci(8) pre-installed? I would expect that most distributions do; at 
least the one I use does..

But, look the usage model. Who queries PCI information from the system? I 
would argue a) developers, b) power users, and c) users hitting a bug. 

a) are going to use lspci, since it's much more powerful. b) may use 
either text format, but it's also likely they'll use a graphical tool. 
Looking at my gnome setup, I do not find anything that lists PCI devices 
(besides a file browser in sysfs :).  And, c) are most likely going to use 
lspci becaus a developer asks for it. I do not remember the last time I 
saw someone ask for the output of /proc/pci. :)

> Personally, I think it would be nice to eliminate /proc/pci -- in favor 
> of something that provides similar functionality from sysfs:  "cat 
> /sys/all-busses" or somesuch.  I dunno how feasible that is.  The main 
> idea is to list as many attached devices as possible in one go, without 
> having to cat 40 different files :)  [unfortunately I think this means I 
> am disagreeing with you ;)]

I totally agree with you. But, I don't think the answer is in 
consolidating files; I think it's in writing intelligent and efficient 
tools to grok that data. 

> I do grant you it would make various __init sections and in-memory 
> structures smaller if we eliminated the names...   do we want to?  Sure 
> we have lseisa and lspci and lsusb, et. al.  Does that obviate the need 
> for a simple summary of attached hardware?

IMO, yes, since those tools provide the summary, and exist almost purely 
in userspace. I forgot to mention in the orginal email that we could 
also drop the PCI names database, right? This would save a considerable 
amount in the kernel image alone..

	-pat


