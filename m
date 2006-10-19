Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946224AbWJSQvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946224AbWJSQvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946226AbWJSQvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:51:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:5761 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1946224AbWJSQvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:51:35 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="147597247:sNHT6225322614"
From: Jesse Barnes <jesse.barnes@intel.com>
To: David Miller <davem@davemloft.net>
Subject: Re: pci_fixup_video change blows up on sparc64
Date: Thu, 19 Oct 2006 09:52:21 -0700
User-Agent: KMail/1.9.4
Cc: eiichiro.oiwa.nm@hitachi.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
References: <20061018.233102.74754142.davem@davemloft.net> <XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com> <20061019.013732.30184567.davem@davemloft.net>
In-Reply-To: <20061019.013732.30184567.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610190952.22285.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 19, 2006 1:37 am, David Miller wrote:
> Also, and more importantly, you cannot use the 0xc0000 address in a
> raw way like this.  There are multiple PCI domains possible in a
> given system, and the 0xc0000 address you wish to use must be
> relative to that PCI domain.
>
> Therefore, in the presence of multiple PCI domains:
>
> 	x = ioremap(0xc0000, ...);
>
> doesn't make any sense, is extremely non-portable, and will crash
> on many non-x86 systems.

Right, I guess we should have been a bit more careful in making this 
code generic.  At least ia64, i386 and x86_64 systems often have video 
BIOSes in system memory at 0xc0000 (note that this isn't in PCI space).  
It sounds like on your system the regular sysfs ROM mapping code should 
be able to see the ROM, and this 0xc0000 mapping/copying shouldn't be 
necessary.

> All of this pci_fixup_video code was perfectly fine when it was only
> used on x86, where assumptions like this happened to work, but it is
> not possible to continue making these assumptions if this code will
> now run on every single architecture.

Maybe we should conditionalize it, making it only available on ia64, 
i386 and x86_64?  Then again, I think there are some embedded platforms 
that could use this code too?

Jesse
