Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUHTMRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUHTMRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUHTMRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:17:40 -0400
Received: from the-village.bc.nu ([81.2.110.252]:25479 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266703AbUHTMRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:17:32 -0400
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though
	sysfs)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Alex Romosan <romosan@sycorax.lbl.gov>, Dave Airlie <airlied@linux.ie>
In-Reply-To: <20040820044635.42969.qmail@web14925.mail.yahoo.com>
References: <20040820044635.42969.qmail@web14925.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093000474.30941.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 12:14:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-20 at 05:46, Jon Smirl wrote:
> Attached is a real world reason why we need a VGA control device.
> VesaFB loads and marks the VGA screen region as reserved. The driver
> does not attach to any device.

You'll love this: The vesafb device might not be a VGA device. In
certain modes the Weitek P9100 is an example of this as in higher modes
it turns off its inbuilt 5286 and flips to the P9x00 engine which is
nonvga.

> The short term fix for this is to make VesaFB aware of the PCI ROM
> patch. The PCI ROM patch makes it possible to identify the boot video
> device. Once VesaFB can identify the boot video device it can properly
> attach itself to both the device and memory. Then DRM radeon loads

Device yes, memory we already know. We currently don't register the
memory always because it may not be in the ISA/PCI space. However we can
certainly walk the bars now you can find the boot video device
and use that to see if the video memory reported by the VESA bios is
in any of them. The other complication is that we can't use the PCI
device level allocator here because some PCI devices have video and
other functionality on one chip. Not however a problem if you grab just
the single resource.

Alan

