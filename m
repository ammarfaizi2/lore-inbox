Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWGFPjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWGFPjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWGFPjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:39:36 -0400
Received: from colo.lackof.org ([198.49.126.79]:49812 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1030343AbWGFPjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:39:36 -0400
Date: Thu, 6 Jul 2006 09:39:40 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Brice Goglin <brice@myri.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/7] Check root chipset no_msi flag instead of all parent busses flags
Message-ID: <20060706153940.GA29981@colo.lackof.org>
References: <20060703003959.942374000@myri.com> <20060703004055.835863000@myri.com> <20060704070643.GA16632@colo.lackof.org> <44AAF5D9.9040908@myri.com> <20060705034829.GA19937@colo.lackof.org> <44AB4243.8030002@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AB4243.8030002@myri.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 12:38:27AM -0400, Brice Goglin wrote:
> Grant Grundler wrote:
> > I still don't want the generic PCI code to assume a "root"
> > PCI Host bus controller was found after that loop.
> 
> If I am not mistaken, we can use the following code to check whether we
> found a root chipset:
>         unsigned cap;
>         u16 val;
>         u8 ext_type;
>         cap = pci_find_capability(pdev, PCI_CAP_ID_EXP);

That might work fine on x86 boxen where firmware fakes all devices
to show up in PCI config space. That's not the case on many other
architectures. My whole point was the pdev doesn't exist for
a root chipset on those other arch's.

grant

>         if (cap) {
>                 pci_read_config_word(pdev, cap + PCI_CAP_FLAGS, &val);
>                 ext_type = (val & PCI_EXP_FLAGS_TYPE) >> 4;
>                 if (ext_type == PCI_EXP_TYPE_ROOT_PORT)
>                         <check no_msi flag>
>         }
> 
> Brice
