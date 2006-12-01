Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162139AbWLAWfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162139AbWLAWfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162143AbWLAWfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:35:46 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:19116 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S1162139AbWLAWfp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:35:45 -0500
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
From: Ben Collins <ben.collins@ubuntu.com>
To: arjan@infradead.org
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Eric Piel <eric.piel@tremplin-utc>
In-Reply-To: <1165009747.3233.108.camel@laptopd505.fenrus.org>
References: <1164998179.5257.953.camel@gullible>
	 <20061201185657.0b4b5af7@localhost.localdomain>
	 <1165001705.5257.959.camel@gullible>
	 <1165002345.3233.104.camel@laptopd505.fenrus.org>
	 <1165006868.5257.972.camel@gullible>
	 <1165009747.3233.108.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Dec 2006 17:35:38 -0500
Message-Id: <1165012538.5257.992.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 22:49 +0100, Arjan van de Ven wrote:
> On Fri, 2006-12-01 at 16:01 -0500, Ben Collins wrote:
> > On Fri, 2006-12-01 at 20:45 +0100, Arjan van de Ven wrote:
> > > On Fri, 2006-12-01 at 14:35 -0500, Ben Collins wrote:
> > > > What about the point that userspace (udev, and such) is not available
> > > > when DSDT loading needs to occur? Init hasn't even started at that
> > > > point.
> > > 
> > > that's a moot point; you need to load firmware from the initramfs ANYWAY
> > > for things like qlogic and others...
> > 
> > I don't see how that relates. The DSDT needs to be loaded even before
> > driver initialization begins. 
> 
> in fact it needs to be loaded even before the ACPI engine starts
> executing, otherwise you're hot-replacing code underneath a live
> system...  at which point you can do this same feature in another way :)
> there already is a feature that builds a dsdt into the kernel image, all
> a distro would need is a bit of objcopy magic to build the right one
> into the vmlinuz...

Providing object files for on-demand relinking of the kernel just adds a
shit load of overhead. If you're suggesting modifying vmlinuz in place
instead, that just seems really undesirable. Last thing I want is
something mucking with the kernel binary.

It's easier for me to keep this patch in my tree, especially since most
users have come to expect this as the "standard" method for inserting
their DSDT replacement.

The only other thing I can think of is grub providing the DSDT just like
it does for the initrd.
