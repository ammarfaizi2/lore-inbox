Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269106AbUIXUDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbUIXUDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269102AbUIXUDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:03:11 -0400
Received: from fmr03.intel.com ([143.183.121.5]:6839 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S269106AbUIXUDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:03:04 -0400
Date: Fri, 24 Sep 2004 13:02:52 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add hook for PCI resource deallocation
Message-ID: <20040924130251.A26271@unix-os.sc.intel.com>
References: <41498CF6.9000808@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41498CF6.9000808@jp.fujitsu.com>; from kaneshige.kenji@jp.fujitsu.com on Thu, Sep 16, 2004 at 05:54:14AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 05:54:14AM -0700, Kenji Kaneshige wrote:
> 
>    Hi,
> 
>    This patch adds a hook 'pcibios_disable_device()' into
>    pci_disable_device() to call architecture specific PCI resource
>    deallocation code. It's a opposite part of pcibios_enable_device().
>    We need this hook to deallocate architecture specific PCI resource
>    such as IRQ resource, etc.. This patch is just for adding the hook,
>    so pcibios_disable_device() is defined as a null function on all
>    architecture so far.
> 
>    I tested this patch on i386, x86_64 and ia64. But it has not been
>    tested on other architectures because I don't have these machines.
> 
>    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> 

Hi Kenji

I think instead of modifying all the arch specific code, you could use the __attribute__(weak)
and define a default dummy funcion in 	drivers/pci/pci.c

void __attribute__((weak)) pcibios_disable_device(struct pci_dev *dev)	{ }


each arch that really needs this can define the override function. That way you dont need to 
put the dummy function in several places, containing your changes to a very few set of files.


Cheers,
ashok
