Return-Path: <linux-kernel-owner+w=401wt.eu-S932691AbWLNMpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWLNMpX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWLNMpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:45:23 -0500
Received: from www.osadl.org ([213.239.205.134]:38421 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932691AbWLNMpW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:45:22 -0500
From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Date: Thu, 14 Dec 2006 13:45:16 +0100
User-Agent: KMail/1.9.5
References: <20061213195226.GA6736@kroah.com> <200612141056.03538.hjk@linutronix.de> <20061214115105.GA8742@dspnet.fr.eu.org>
In-Reply-To: <20061214115105.GA8742@dspnet.fr.eu.org>
Organization: Linutronix
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612141345.18103.hjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2006 12:51 schrieb Olivier Galibert:
> On Thu, Dec 14, 2006 at 10:56:03AM +0100, Hans-Jürgen Koch wrote:
> > A small German manufacturer produces high-end AD converter cards. He sells
> > 100 pieces per year, only in Germany and only with Windows drivers. He would
> > now like to make his cards work with Linux. He has two driver programmers
> > with little experience in writing Linux kernel drivers. What do you tell him?
> > Write a large kernel module from scratch? Completely rewrite his code 
> > because it uses floating point arithmetics?
> 
> Write a small kernel module which:

What you suggest is not a "small kernel module". It's what we have now,
writing a complete driver.

> - create a device node per-card

That's what UIO does, plus some standard sysfs files, that tell you e.g.
the size of the cards memory you can map. There are standard file names
that allow you e.g. to automatically search for all registered uio 
drivers and their properties.

> - read the data from the A/D as fast as possible and buffer it in main
>   memory without touching it

If the card already has that data in its dual port RAM, you do an
unneccessary copy.

> - implements a read interface to read data from the buffer

Here you do the next unneccessary copy.

> - implement ioctls for whatever controls you need

Implementing ioctls for everything is bad coding style and a has bad
performance. I said "high-end AD card", that means you have a 
signal processor on that board, want to download firmware to it 
and so on. You end up copying lots of data between user space
and kernel space.

> 
> And that's it.  

Yes, that's a complete kernel driver that you'd never get into
a mainline kernel. Furthermore, the card manufacturer would have to
employ at least two experienced Linux _kernel_ programmers. That's
too much for a small company who's business is something different.

> All the rest can be done in userspace, safely, with 
> floating point, C++ and everything.  If the driver programmers are
> worth their pay, their driver is probably already split logically at
> where the userspace-kernel interface would be.
> 
> And small means small, like 200 lines or so, more if you want to have
> fun with sysfs, poll, aio and their ilk, but that's not a necessity.

You can achieve 100 lines with uio, including sysfs and poll. What you
describe would never fit in 200 lines for a non-trivial card.

Hans

