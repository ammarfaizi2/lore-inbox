Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVAaRJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVAaRJD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVAaRHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:07:20 -0500
Received: from [81.2.110.250] ([81.2.110.250]:11995 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261267AbVAaRHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:07:01 -0500
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Grant Grundler <grundler@parisc-linux.org>, Jesse Barnes <jbarnes@sgi.com>,
       Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       lkml <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050128200010.GJ28246@parcelfarce.linux.theplanet.co.uk>
References: <9e47339105011719436a9e5038@mail.gmail.com>
	 <200501270828.43879.jbarnes@sgi.com>
	 <20050128173222.GC30791@colo.lackof.org>
	 <200501281041.42016.jbarnes@sgi.com>
	 <20050128193320.GB32135@colo.lackof.org>
	 <20050128200010.GJ28246@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107170461.14847.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 31 Jan 2005 16:01:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-28 at 20:00, Matthew Wilcox wrote:
> Possibly a better solution (less likely to break things) would be to allow
> drivers to reserve the 10-bit aliases too.  Something like this:
> 
> static inline void request_isa_alias_regions(unsigned long start,
>                 unsigned long n, const char *name)
> {
>         int base;
>         for (base = 0x400; base < 0x10000; base += 0x400) {
>                 request_region(base + start, n, name);
>         }
> }
> 
> and then call that in drivers/video/console/vgacon.c

Almost every x86 I/O device in ISA space has this problem so it would be
better if request_region learned to take a decode mask instead of adding
another 500 entries

