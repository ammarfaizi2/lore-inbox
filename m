Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265544AbUGTFMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbUGTFMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 01:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUGTFMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 01:12:52 -0400
Received: from [216.208.38.106] ([216.208.38.106]:5616 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265544AbUGTFMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 01:12:50 -0400
Date: Tue, 20 Jul 2004 07:13:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4 Backport] x445 usb legacy fix
Message-ID: <20040720051353.GD313@ucw.cz>
References: <1090289222.1388.461.camel@cog.beaverton.ibm.com> <20040719200608.280d17a1@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719200608.280d17a1@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 08:06:08PM -0700, Pete Zaitcev wrote:

> The patch looks a little dirty in small places, e.g. the double
> semicolon, the HZ/100 instead of HZ/10, space, two variables
> named "base" in two blocks. I do not believe Vojtech wrote it.
> He must have gotten it from someone else.

Actually I did, but it was a quick cut-and-paste from the USB drivers to
see if it would help with some PS/2 mouse detection problems reported to
me. I never cleaned it up, and it was actually submitted for kernel
inclusion by someone else than me (whose name I unfortunately don't
remember).

> The boot option may be useful, but in the core of the patch looks
> like like a roundabout way to do things. Why don't you trigger
> the meat of the quirk from, say, a DMI scan?
> 
> > +	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,		quirk_usb_disable_smm_bios },
> 
> This looks like a bizzare place to use as a hook. The x400 and x445
> obviously have their own bridges with own IDs (their NUMA cannot
> be using Intel parts, right?). So why don't hook off that?

Actually USB Legacy SMM emulation triggers problems on many many more
systems. The quirk does exactly the same thing the USB HCI drivers do in
their init code, it only does it early in the boot process, so that
even if the USB drivers are modules, the i8042 controller and PS/2 mouse
and keyboard initialization proceeds correctly.

The other options are to compile the HCI drivers into the kernel or to
have i8042 compiled as a module.

> The routines to take ownership look sane from USB HC access
> (not sane from C programming standpoint, as I mentioned above).

> But in any case, it's not something I can decide. Marcelo has that
> power for stock kernels, and for Red Hat kernels there's a process
> which starts with Bugzilla.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
