Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbWALQaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbWALQaw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWALQaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:30:52 -0500
Received: from aun.it.uu.se ([130.238.12.36]:9978 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1030465AbWALQav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:30:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17350.33811.433595.750615@alkaid.it.uu.se>
Date: Thu, 12 Jan 2006 17:30:11 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       oliver@neukum.org
Subject: Re: need for packed attribute
In-Reply-To: <20060112134729.GB5700@flint.arm.linux.org.uk>
References: <200601121227.k0CCRCB8016162@alkaid.it.uu.se>
	<20060112134729.GB5700@flint.arm.linux.org.uk>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
 > > As fas as I can tell, the AAPCS document (v2.03 7th Oct 2005) requires
 > > that a simple "struct foo { unsigned char c; };" should have both size
 > > and alignment equal to 1, but gcc makes them both 4. Do you have any
 > > information about why gcc is doing this on ARM/Linux? Is there an accurate
 > > ABI document for ARM/Linux somewhere?
 > 
 > That's the new EABI, which is a major change to the existing ABI which
 > the kernel and all of userspace is currently built using.
 > 
 > The old ABI has it's roots in 1993 when the kernel and userland was
 > initially built using an ANSI C compiler, and the work being done to
 > port GCC was to make it compliant with that version of the ABI.  This
 > ABI is documented only in dead-tree form.
 > 
 > Due to lack of manpower on the Linux side (iow, more or less just me)
 > this became the ABI of the early ARM Linux a.out toolchain.  At that
 > time, I did not consider this to be a problem - it wasn't a problem
 > as far as the kernel was concerned.
 > 
 > When ELF came along, other folk worked on the toolchain, but they stuck
 > with that ABI - you could not transition between the a.out ABI to the
 > ELF ABI without breaking the kernel - structure layouts would change.
 > 
 > Hence, this is the existing ABI we have.  Changing the padding or
 > alignment of structures changes the kernel ABI, making it incompatible
 > with current userland.

OK, thanks for this info. It means that GCC is the definitive authority
on calling conventions and data layouts, not the AAPCS; I wasn't aware of
that before.

(My interest in this issue comes from working on a port of a functional
programming language's JIT compiler and runtime system to XScale.)

/Mikael
