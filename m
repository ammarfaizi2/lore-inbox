Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUIUTpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUIUTpk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUIUTpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:45:40 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:21409 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S268028AbUIUTpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:45:33 -0400
Subject: Re: [ACPI] Re: [PATCH/RFC] exposing ACPI objects in sysfs
From: Alex Williamson <alex.williamson@hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921191826.GF18938@wotan.suse.de>
References: <1095716476.5360.61.camel@tdi>
	 <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi>
	 <20040921172625.GA30425@elf.ucw.cz> <20040921190606.GE18938@wotan.suse.de>
	 <1095794035.24751.54.camel@tdi>  <20040921191826.GF18938@wotan.suse.de>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 21 Sep 2004 13:45:54 -0600
Message-Id: <1095795954.24751.74.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 21:18 +0200, Andi Kleen wrote:
> >    All pointers are actually interpreted as offsets into the buffer for
> > this interface.  They are not actually pointers.  I believe the 32bit
> > emulation problem is limited to an ILP32 application generating data
> > structures appropriate for an LP64 kernel.  While difficult, it can be
> > done.
> 
> If this involves patching the application - no it cannot be done.
> The 64bit kernel is supposed to run vanilla 32bit user land.
> 
> Please find some other solution for this. An ioctl doesn't sound that bad.

   Please read the rest of my response to Pavel, I don't think we're on
the same page as to the extent of this problem.  There is no application
yet, we're in the process of architecting the interface to it right now.
Is it impossible to expect an ILP32 application to generate LP64 data
structures?  Perhaps the LP64 kernel interface could be made smart
enough to digest ILP32 data structures as Arjan suggests.

   I don't believe an ioctl solves all the problems.  An ioctl AND
redefining all the ACPI data types in use to a single ILP model might.
I think we lose a lot and add quite a bit of complexity in doing that
though.  Note the "pointer" in the command structure is superfluous, I'd
be happy to remove it, but that still leaves the basic ACPI data
structures.

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

