Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbULBATy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbULBATy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbULBATo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:19:44 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:29371 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261513AbULBASv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 19:18:51 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.10-rc2-mm4
Date: Wed, 1 Dec 2004 17:18:42 -0700
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <20041130095045.090de5ea.akpm@osdl.org> <20041201211036.GQ2650@stusta.de>
In-Reply-To: <20041201211036.GQ2650@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412011718.42740.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 December 2004 2:10 pm, Adrian Bunk wrote:
> > add-acpi-based-floppy-controller-enumeration.patch
> >   Add ACPI-based floppy controller enumeration.
> 
> As far as I understood the discussion, this patch should be dropped.

As I understand it, Len & Linus have figured out how to fiddle
with ELCR[1] in such a way that when ACPI disables a PCI link
device that happens to be on IRQ6, the ELCR polarity doesn't
get screwed up.  So the floppy driver can still blindly probe
for its device without getting an interrupt storm.

But the BIOS is still telling the OS that there's no floppy
controller, and Linux still isn't listening.  In the case of
floppy, maybe that's OK, because all arches that support floppy
seem to make it safe to do blind probing.

But in the case of i8042, IDE, and IPMI, I think we definitely
*should* do either ACPI or PNP-ACPI enumeration.  These devices
are all optional on ia64, and at least on HP hardware, the only
reason we configure the box to allow blind probing is so these
deaf drivers continue to work.

[1] http://linux.bkbits.net:8080/linux-2.5/cset%4041a2c479tEbbKs1AxXHrR-LgHzPXzA
