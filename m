Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUA2QGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUA2QF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:05:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:23952 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265981AbUA2QF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:05:58 -0500
Date: Thu, 29 Jan 2004 08:05:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <willy@debian.org>
cc: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, Andi Kleen <ak@colin2.muc.de>,
       Andrew Morton <akpm@osdl.org>, mj@ucw.cz,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
In-Reply-To: <20040129155911.GD18725@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0401290802370.689@home.osdl.org>
References: <6B09584CC3D2124DB45C3B592414FA830112C34F@bgsmsx402.gar.corp.intel.com>
 <20040129150925.GC18725@parcelfarce.linux.theplanet.co.uk>
 <20040129155911.GD18725@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jan 2004, Matthew Wilcox wrote:
> 
> Brian Gerst spotted a bug -- I'd forgotten to initialise mmcfg_virt_addr.

The compiler _should_ entirely compile away "fix_to_virt(xxx)", so by 
creating a variable for the value, you're actually making code generation 
worse. You might as well have

	#define mmcfg_virt_addr (fix_to_virt(FIX_PCIE_MCFG))

instead.

That said, this patch looks perfectly acceptable to me. With some testing, 
I'd take it through Greg or -mm.

		Linus
