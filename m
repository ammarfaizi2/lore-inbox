Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUIUUkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUIUUkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUIUUkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:40:31 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:28907 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S268043AbUIUUk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:40:28 -0400
Subject: Re: [ACPI] Re: [PATCH/RFC] exposing ACPI objects in sysfs
From: Alex Williamson <alex.williamson@hp.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921195802.GF30425@elf.ucw.cz>
References: <1095716476.5360.61.camel@tdi>
	 <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi>
	 <20040921172625.GA30425@elf.ucw.cz> <20040921190606.GE18938@wotan.suse.de>
	 <1095794035.24751.54.camel@tdi> <20040921191826.GF18938@wotan.suse.de>
	 <1095795954.24751.74.camel@tdi>  <20040921195802.GF30425@elf.ucw.cz>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 21 Sep 2004 14:40:48 -0600
Message-Id: <1095799248.24751.103.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 21:58 +0200, Pavel Machek wrote:
> Hi!
> 
> > > >    All pointers are actually interpreted as offsets into the buffer for
> > > > this interface.  They are not actually pointers.  I believe the 32bit
> > > > emulation problem is limited to an ILP32 application generating data
> > > > structures appropriate for an LP64 kernel.  While difficult, it can be
> > > > done.
> > > 
> > > If this involves patching the application - no it cannot be done.
> > > The 64bit kernel is supposed to run vanilla 32bit user land.
> > > 
> > > Please find some other solution for this. An ioctl doesn't sound that bad.
> > 
> >    Please read the rest of my response to Pavel, I don't think we're on
> > the same page as to the extent of this problem.  There is no application
> > yet, we're in the process of architecting the interface to it right now.
> > Is it impossible to expect an ILP32 application to generate LP64 data
> > structures?  Perhaps the LP64 kernel interface could be made smart
> > enough to digest ILP32 data structures as Arjan suggests.
> 
> You can be pretty sure someone, somewhere will bypass that library,
> hardcode types into application, and break it on 64-bit platform.

   Ok, I'll try to prototype something that uses data model independent
structures.  Using the kernel headers was convenient, but probably not
advisable.

> If I were you, I'd just replace read and write with ioctl, and leave
> the rest of design as it was. If we find that someone who bypasses
> your userspace library, at least we have a way to deal with it. (And
> "cat a file and kill machine" issue is gone, too).

   Again, I don't think that solves the problem (and there's no ioctl
support in sysfs).  The pointer in the command structure is easy to work
around, nothing uses it and data could easily be stuffed after the
architected entries.  Switching to an ioctl would not solve the problem
of passing ACPI data back and forth.  We don't just want to execute
methods, we want to be able to provide arguments and get data back.
That data is where I see the biggest 32/64 bit issue.  I'll switch to an
evaluate on write model, but I'm not sold that an ioctl would solve
enough problems to be worth it.  Is anyone even open to adding ioctls to
sysfs bin files?  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

