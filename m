Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVCIGF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVCIGF0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVCIGF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:05:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:49336 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261549AbVCIGFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:05:19 -0500
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: xorg@freedesktop.org, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910503082158c95c904@mail.gmail.com>
References: <1110265919.13607.261.camel@gaston>
	 <1110319304.13594.272.camel@gaston>
	 <9e47339105030815477d0c7688@mail.gmail.com>
	 <1110326565.32556.7.camel@gaston>
	 <9e47339105030819172eecc324@mail.gmail.com>
	 <1110340398.32557.36.camel@gaston>
	 <9e4733910503082035318e9d23@mail.gmail.com>
	 <1110346634.32556.54.camel@gaston>
	 <9e4733910503082158c95c904@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 17:00:40 +1100
Message-Id: <1110348041.32524.60.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 00:58 -0500, Jon Smirl wrote:
> On Wed, 09 Mar 2005 16:37:13 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2005-03-08 at 23:35 -0500, Jon Smirl wrote:
> > > This is from /linux-2.5/Documentation/filesystems/sysfs-pci.txt. It
> > > describes how ia64 is achieving legacy IO.  The VGA control code
> > > probably needs to be coordinated with this.
> > 
> > This is a different thing, and I will implement it on ppc one of these
> > days. This is for issuing the IO cycles on the bus. It has nothing
> > to do with the actual arbitration work.
> 
> Each one of these legacy spaces corresponds to an allowable
> simultaneous VGA use. There should be one arbiter per legacy space.

Ugh ? They are or they are not independant, that's a platform thing and
has nothing to do with arbitration. They aren't VGA specific neither.

The arbitrer uses the vga_conflicts() callback for that purpose. It is
defined to always return 1 by default, but the platform can override it
if it has separate PCI domains, in order to tell the arbitrer wether 2
cards can conflict or not.

Based on that, the arbitrer will, or will not, let you lock the VGA
legacy resources simultaneously.

Ben.


