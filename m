Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265485AbSJaXeM>; Thu, 31 Oct 2002 18:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265486AbSJaXeM>; Thu, 31 Oct 2002 18:34:12 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:44515 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265485AbSJaXeK>; Thu, 31 Oct 2002 18:34:10 -0500
Date: Thu, 31 Oct 2002 17:40:34 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "Lee, Jung-Ik" <jung-ik.lee@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "'Greg@kroah.com'" <Greg@kroah.com>
Subject: RE: bare pci configuration access functions ?
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A492@orsmsx119.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0210311729290.27728-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Grover, Andrew wrote:

> > From: Lee, Jung-Ik [mailto:jung-ik.lee@intel.com] 
> > 	Some kernel drivers/components such as hotplug 
> > pci/io-node drivers,
> > ACPI driver, some console drivers, etc **need bare pci 
> > configuration space
> > access** before either pci driver is initialized or struct pci_dev is
> > constructed.
> > 
> > ACPI needs this for ACPI/PCI population, hotplug pci driver 
> > for populating
> > hot-added pci hierarchy. As more drivers are cross ported 
> > over to wider
> > architectures, this would become wider need. Help me if 
> > others need this
> > too.
> 
> When the PCI Config stuff got revamped a few months ago, Greg KH, myself,
> and some other people discussed this, and the conclusion seemed to be that
> it was less ugly to make the code that needs bare PCI config access use fake
> structs, than to have the bare functions exposed. Greg, am I remembering
> correctly?

As one of the other people involved, I think the solution which was agreed
on was to have the lower level functions provided with (struct pci_bus *,
u8 dev, u8 fn) since that is what's really needed to implement the config
accesses. The standard PCI config functions, taking struct pci_dev * are
merely a wrapper around these. Greg did a patch to implement it, and it
looks like it got merged.

pci_bus_{read,write}_config_{byte,word,dword}()

--Kai




