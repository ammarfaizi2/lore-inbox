Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263103AbUJ2FGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbUJ2FGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 01:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbUJ2FGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 01:06:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:22243 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263112AbUJ2FF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 01:05:57 -0400
Date: Fri, 29 Oct 2004 06:58:58 +0200
From: Andi Kleen <ak@suse.de>
To: Len Brown <len.brown@intel.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Luming Yu <luming.yu@intel.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Robert Moore <robert.moore@intel.com>,
       Alex Williamson <alex.williamson@hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi)
Message-ID: <20041029045858.GL11384@wotan.suse.de>
References: <3ACA40606221794F80A5670F0AF15F84041ABFFA@pdsmsx403> <418085B0.30208@intel.com> <20041028152404.GB7902@thunk.org> <1099025292.5402.200.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099025292.5402.200.camel@d845pe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [ It would be sort of neat if we could built the core ACPI support in
> some kind of modular way such that that we could have it at boot-time,
> if we need it, but optionally unload it at run-time if it turned out the
> target system didn't need it. ]

It would be possible with some Makefile hacks. Basically you would need
to objcopy the ACPI object files and rename .text*/.data* to 
a different acpi specific name. Then you can give it an special 
area in the vmlinux.lds and possibly free it.

I agree with you that it's better kept in the kernel.

> Static Kernel Size:
>    text    data     bss     dec     hex filename
>  144533    5608    4920  155061   25db5 drivers/acpi/built-in.o

Hmm, this used to be smaller, no? Perhaps someone going over
bloat-o-meter[1] output to an older version would be useful.
There is probably some low hanging fruit.

-Andi

[1] ftp://ftp.firstfloor.org/pub/ak/perl/bloat-o-meter

