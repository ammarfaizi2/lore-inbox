Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWEDUGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWEDUGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 16:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWEDUGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 16:06:08 -0400
Received: from mga06.intel.com ([134.134.136.21]:49816 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751331AbWEDUGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 16:06:06 -0400
X-IronPort-AV: i="4.05,89,1146466800"; 
   d="scan'208"; a="31601246:sNHT132398826"
Date: Thu, 4 May 2006 13:01:57 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, Rajesh Shah <rajesh.shah@intel.com>,
       gregkh@suse.de, ak@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: i386/x86_84: disable PCI resource decode on device disable
Message-ID: <20060504130156.A3494@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20060503152747.A29327@unix-os.sc.intel.com> <21d7e9970605032016w2a092ce9qb2bff38e739bca5@mail.gmail.com> <4459CCF5.9080106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4459CCF5.9080106@gmail.com>; from adaplas@gmail.com on Thu, May 04, 2006 at 05:44:21PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 05:44:21PM +0800, Antonino A. Daplas wrote:
> 
> Most, if not all PCI-based framebuffer drivers call pci_disable_device()
> in their unload routine. Although it's very rare that framebuffer drivers
> are unloaded, if you do, and the the resources are also disabled, it will
> kill the VGA core of the card.  You lose your text console and even
> hang the machine.
> 
> > 
> > Alan Cox mentioned this somewhere before in relation to video cards..
> 
> Alan Cox, if I remember correctly, advises against calling pci_disable_device()
> for video drivers when they unload.
> 
Yeah, that's also what some other drivers do. For example, PCI/PCIE
bridges may support capabilities (like hotplug) that are controlled
by separate drivers. These drivers don't do pci_disable_device()
when they unload, since the bridge must continue to decode even
when the other capability driver is gone.

The problem is that most PCI bridges don't have any "extra"
resources padded into the address ranges they pass down. It
would be nice to be able to reuse address space released when
a device is disabled (e.g.  for future hot-add), if it's really
no longer needed.

Rajesh
