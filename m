Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268980AbUIXVYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268980AbUIXVYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 17:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUIXVYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 17:24:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:29112 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268899AbUIXVWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 17:22:22 -0400
Date: Fri, 24 Sep 2004 14:22:08 -0700
From: Greg KH <greg@kroah.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add hook for PCI resource deallocation
Message-ID: <20040924212208.GD7619@kroah.com>
References: <41498CF6.9000808@jp.fujitsu.com> <20040924130251.A26271@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924130251.A26271@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 01:02:52PM -0700, Ashok Raj wrote:
> On Thu, Sep 16, 2004 at 05:54:14AM -0700, Kenji Kaneshige wrote:
> > 
> >    Hi,
> > 
> >    This patch adds a hook 'pcibios_disable_device()' into
> >    pci_disable_device() to call architecture specific PCI resource
> >    deallocation code. It's a opposite part of pcibios_enable_device().
> >    We need this hook to deallocate architecture specific PCI resource
> >    such as IRQ resource, etc.. This patch is just for adding the hook,
> >    so pcibios_disable_device() is defined as a null function on all
> >    architecture so far.
> > 
> >    I tested this patch on i386, x86_64 and ia64. But it has not been
> >    tested on other architectures because I don't have these machines.
> > 
> >    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> > 
> 
> Hi Kenji
> 
> I think instead of modifying all the arch specific code, you could use the __attribute__(weak)
> and define a default dummy funcion in 	drivers/pci/pci.c
> 
> void __attribute__((weak)) pcibios_disable_device(struct pci_dev *dev)	{ }
> 
> 
> each arch that really needs this can define the override function.
> That way you dont need to put the dummy function in several places,
> containing your changes to a very few set of files.

Ohhh, nice.  I like that option better.  Kenji, care to respin your
patches based on this change?

thanks,

greg k-h
