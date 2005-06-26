Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVFZTfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVFZTfq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 15:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFZTfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 15:35:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39954 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261588AbVFZTex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 15:34:53 -0400
Date: Sun, 26 Jun 2005 20:34:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, greg@kroah.com,
       rajesh.shah@intel.com, linux-kernel@vger.kernel.org
Subject: Re: ACPI-based PCI resources: PCMCIA bugfix, but resources missing in trees
Message-ID: <20050626203447.D28598@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, greg@kroah.com,
	rajesh.shah@intel.com, linux-kernel@vger.kernel.org
References: <20050626040329.3849cf68.akpm@osdl.org> <20050626140411.GA8597@dominikbrodowski.de> <20050626121710.44c1df8d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050626121710.44c1df8d.akpm@osdl.org>; from akpm@osdl.org on Sun, Jun 26, 2005 at 12:17:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 12:17:10PM -0700, Andrew Morton wrote:
> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> >
> > On Sun, Jun 26, 2005 at 04:03:29AM -0700, Andrew Morton wrote:
> >  > - Lots of merges.  I'm holding off on the 80-odd pcmcia patches until we get
> >  >   the recent PCI breakage sorted out.
> > 
> >  pci-yenta-cardbus-fix.patch and the following patch should solve the
> >  initialization time trouble. However, the ACPI-based PCI resource handling
> >  is badly broken, IMHO:
> > 
> >  - many resources of devices don't show up in the resource trees (
> >    /proc/iomem and /proc/ioports) any longer. This means that PCMCIA, but
> >    also possibly other subsystems (ISA, PnP, ...) do not know which resources
> >    it cannot use.
> 
> Is this a recent regression?  Is it only in -mm?
> 
> IOW: can you identify the bad patch?  Or the bad patcher ;)

It's greg's pci-somethingortheotheraboutacpi-collection-02 patch (sorry
don't remember it exactly).

It's basically replacing the PCI bus root resources with new resources.
These aren't then attached to the resource tree.  However, PCI will
attach the child resources to the (unattached) bus resources.

Hence, all PCI resources remain invisible.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
