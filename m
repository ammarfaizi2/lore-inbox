Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVEXRCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVEXRCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVEXRAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:00:36 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:38081 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261154AbVEXQ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:59:22 -0400
Date: Tue, 24 May 2005 20:58:55 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andi Kleen <ak@suse.de>, len.brown@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net, gregkh@suse.de
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Message-ID: <20050524205855.A8367@jurassic.park.msu.ru>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de> <20050523175706.A12032@unix-os.sc.intel.com> <20050524120527.GB15326@wotan.suse.de> <20050524185856.A7639@jurassic.park.msu.ru> <20050524084533.A20567@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050524084533.A20567@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Tue, May 24, 2005 at 08:45:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 08:45:36AM -0700, Rajesh Shah wrote:
> The concern here isn't just increasing the size of pci_bus. The
> resource pointers in pci_bus point to resource structures in the
> corresponding pci_dev structure for p2p bridges. If we want to
> maintain this scheme, we'd have to increase the number of resources
> in the pci_dev structure too, which increases it for every single
> pci device in the system.

No. The pci_bus resource pointers are just pointers to _some_ resources
and generally aren't tied to particular pci device. For example, the
root pci buses often don't even have corresponding bus->self structure,
and bus resources are pointers to global io[mem,port]_resource.
And definitely we must not touch resource layout in struct pci_dev -
it's defined by pci specs.

> Probably ok for big server machines, but
> would others (e.g. embedded folks) complain?

Increasing the size of pci_bus by 8 or 16 bytes shouldn't be a problem -
I don't think embedded machines have a lot of pci buses. :-)
Anyway, the default PCI_BUS_NUM_RESOURCES value can be overridden in 
arch specific headers.

Ivan.
