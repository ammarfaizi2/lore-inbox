Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266815AbUHCSgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266815AbUHCSgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 14:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUHCSeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 14:34:24 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:61906 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266798AbUHCSeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 14:34:11 -0400
Subject: Re: [RFC] dev_acpi: device driver for userspace access to ACPI
From: Dave Hansen <haveblue@us.ibm.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091557050.4981.135.camel@tdi>
References: <1091552426.4981.103.camel@tdi>
	 <1091554271.27397.5327.camel@nighthawk>  <1091557050.4981.135.camel@tdi>
Content-Type: text/plain
Message-Id: <1091558040.27397.5523.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 11:34:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 11:17, Alex Williamson wrote:
> On Tue, 2004-08-03 at 10:31 -0700, Dave Hansen wrote:
> > So, what kinds of generic, arch-independent interfaces should we
> > implement in the kernel that would reduce the need for something like
> > your driver?
> 
>    I agree with your intent, but I'm not sure a common kernel interface
> is feasible or desired.  This driver would be much more useful if it was
> cleverly abstracted by a userspace library.  Should we try to make the
> common layer be the library interface?  Obviously the more similar the
> kernel interface, the easier, but I'm not ready to sign-up to architect
> a generic interface.

Instead of architecting a generic interface, might you simply exclude
access from your driver to things that already have generic interfaces? 
I think there are things that we exclude from /proc/device-tree on ppc64
because there's a generic equivalent elsewhere.  

>    The ACPI interface could be used to do everything from switching a
> laptop display between the interfaces to listing and configuring/de-
> configuring specific pieces of hardware.  There will be a set of
> functionality that's common across multiple interfaces, but I don't want
> to prevent the usage that is very specific to the underlying
> implementation.

There are certainly some very platform-specific things that obviously
need to be done with direct access to the firmware, and that we don't
want to pollute the kernel with.  Parsing some of the firmware error
logs on ppc64 comes to mind.  You just need to be *very* careful with
the application authors because it's such a big gun :)

-- Dave

