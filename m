Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSCDDOK>; Sun, 3 Mar 2002 22:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291110AbSCDDOC>; Sun, 3 Mar 2002 22:14:02 -0500
Received: from mnh-1-19.mv.com ([207.22.10.51]:35850 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S291102AbSCDDNy>;
	Sun, 3 Mar 2002 22:13:54 -0500
Message-Id: <200203040316.WAA04739@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Sun, 03 Mar 2002 23:48:56 GMT."
             <E16hfiq-0005qg-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Mar 2002 22:16:40 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> Like randomly killing another process off ? If you want to dirty the
> pages pray and catch the sigbus then see memset(3). If you want to be
> told "sorry you can't have that" and write a simple loop to pick a
> good memory size, you need the address space accounting.

OK, this sounds right if the machine is short of memory.  Random
hacks to do something reasonable if a SIGBUS manages to gets through aren't
the way to go when random process deaths are what happen if it doesn't.

However, the host wasn't under a global memory shortage.  The UML hit the 
tmpfs size limit.

Does address space accounting enforce tmpfs limits (and other limits, like
RSS, when it happens)?  Or is it enforcing a global limit?

When the host isn't in a memory shortage and UML is running under a sub-limit
(as with tmpfs), either of those gives me worse behavior than I get by being
able to trap the SIGBUS.  It will arrive reliably without accompanying process
deaths.  The first case means that the UML won't get off the ground even
though it would be able to deal semi-gracefully with tmpfs running out of room.
The second means that the mmap will succeed and I'm back to SIGBUS anyway.

> Nothing of the sort. Sitting in a gnome desktop I'm showing a 41200Kb
> worst case swap requirement, but it appears under half of that is
> used. 

This I don't get.  I'm assuming that the vast majority of the time when a
set of pages is returned by __alloc_pages, they all are going to be written
pretty soon.  This being the case, how can it possibly affect anything to
touch them at the end of __alloc_pages?

				Jeff

