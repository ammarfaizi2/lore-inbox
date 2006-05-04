Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWEDUdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWEDUdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 16:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWEDUdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 16:33:12 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:52430 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1030319AbWEDUdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 16:33:11 -0400
Date: Thu, 4 May 2006 14:33:10 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Dave Airlie <airlied@gmail.com>,
       gregkh@suse.de, ak@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: i386/x86_84: disable PCI resource decode on device disable
Message-ID: <20060504203310.GE9609@parisc-linux.org>
References: <20060503152747.A29327@unix-os.sc.intel.com> <21d7e9970605032016w2a092ce9qb2bff38e739bca5@mail.gmail.com> <4459CCF5.9080106@gmail.com> <20060504130156.A3494@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504130156.A3494@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 01:01:57PM -0700, Rajesh Shah wrote:
> Yeah, that's also what some other drivers do. For example, PCI/PCIE
> bridges may support capabilities (like hotplug) that are controlled
> by separate drivers. These drivers don't do pci_disable_device()
> when they unload, since the bridge must continue to decode even
> when the other capability driver is gone.
> 
> The problem is that most PCI bridges don't have any "extra"
> resources padded into the address ranges they pass down. It
> would be nice to be able to reuse address space released when
> a device is disabled (e.g.  for future hot-add), if it's really
> no longer needed.

You could always reprogram the BARs.  But I really wouldn't recommend
this; you'll just fragment the address space.
