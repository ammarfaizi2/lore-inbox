Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267629AbSLFWKD>; Fri, 6 Dec 2002 17:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267630AbSLFWKD>; Fri, 6 Dec 2002 17:10:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28422 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267629AbSLFWKC>;
	Fri, 6 Dec 2002 17:10:02 -0500
Message-ID: <3DF121DD.6070206@pobox.com>
Date: Fri, 06 Dec 2002 17:17:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/pci deprecation?
References: <Pine.LNX.4.33.0212061506060.1010-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0212061506060.1010-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> ISTR /proc/pci being deprecated at one point in the past. It may have only
> been discussed, though. In which case, is it possible to deprecate it?
> lscpi(8) is considered a superior means to derive the same information.
> 
> Elimination of it would eliminate a chunk of code in drivers/pci/proc.c, 
> and obviate the use of struct device::name by the PCI layer. This change 
> would probably allow us to remove the name field altogether, since PCI is 
> the only code that really relies on it (and only for /proc/pci AFAICT).


Historically, this was a Linus call :)

IIRC it was one of (a) deprecated, (b) removed, or (c) almost removed in 
the past, and Linus un-deprecated it.  The logic back then was that it 
provides a quick summary of a lot of useful info, a la /proc/cpuinfo and 
/proc/meminfo.  i.e. you don't need lspci installed, just been /bin/cat.

Personally, I think it would be nice to eliminate /proc/pci -- in favor 
of something that provides similar functionality from sysfs:  "cat 
/sys/all-busses" or somesuch.  I dunno how feasible that is.  The main 
idea is to list as many attached devices as possible in one go, without 
having to cat 40 different files :)  [unfortunately I think this means I 
am disagreeing with you ;)]

I do grant you it would make various __init sections and in-memory 
structures smaller if we eliminated the names...   do we want to?  Sure 
we have lseisa and lspci and lsusb, et. al.  Does that obviate the need 
for a simple summary of attached hardware?

	Jeff



