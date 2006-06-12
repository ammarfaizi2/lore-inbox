Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWFLVSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWFLVSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWFLVSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:18:47 -0400
Received: from www.osadl.org ([213.239.205.134]:50869 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932298AbWFLVST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:18:19 -0400
Subject: Re: [PATCH] x86 built-in command line
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Matt Mackall <mpm@selenic.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Tim Bird <tim.bird@am.sony.com>
In-Reply-To: <20060612204925.GT24227@waste.org>
References: <20060611215530.GH24227@waste.org>
	 <200606121712.k5CHClUE017185@terminus.zytor.com>
	 <20060612204925.GT24227@waste.org>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 23:19:12 +0200
Message-Id: <1150147153.5257.277.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 15:49 -0500, Matt Mackall wrote:
> I don't think that's a show-stopper. I'll provide one after we decide
> how this should work.
>  
> > b. This patch will override a user-provided command line if one
> > exists.  This is the wrong behaviour; instead, the builtin command
> > line should only apply if no user-specified command line is present.
> 
> There are four possible behaviors:
> 
> a) internal supercedes external (what's in the patch)
> b) external supercedes internal (what you proposed)
> c) external is appended to internal (what Tim proposed)
> d) internal is appended to external (not very interesting)
> 
> And there are some possible uses:
> 
> 1) bootloader doesn't support command line
> 2) bootloader has hardcoded or otherwise difficult-to-change command line
> 3) automated testing for tftp boot, etc.
> 4) bypassing boot protocol command line length (not yet supported)
> 5) setting defaults like ACPI off, etc.
> 
> (a) works for 1, 2, 3, and 4.
> (b) works for 1, 3, and 4, provided you clear the command line in your
> boot loader
> (c) works for 1, 3, and 4, provided you're not trying to override
> earlier arguments
> 
> (5) generally is unworkable because our parser doesn't generally do the
> right thing for options like "acpi=on acpi=off" (though it might work
> in the specific case of acpi, haven't checked). If, for instance, you
> try to override console, you'll get two consoles.
> 
> So I think (a) is the way to go. If there's a use case for (b) that's
> important, it's not jumping out at me. Finally, at least the arch I
> inspected when preparing this patch had gone with (a) too.
> 
> (As an example of (2), the last x86 bootloader I dealt with was written
> in Forth, and getting a fresh build of it meant getting some cycles
> from the last two Forth hackers on the planet.)

Well most of the bootloaders I'm working with let me change the
commandline. So why must I recompile the kernel to change the console
from VGA to serial ? Having a default commandline built in is great,
when

- your bootloader is not able to provide one 
- as a default fallback if the operator(me) was too lazy to setup the
bootloader 

	tglx


