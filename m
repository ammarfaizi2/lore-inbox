Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUBAFK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 00:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUBAFK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 00:10:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265213AbUBAFKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 00:10:23 -0500
Date: Sun, 1 Feb 2004 05:10:21 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, Andi Kleen <ak@colin2.muc.de>,
       Andrew Morton <akpm@osdl.org>, mj@ucw.cz,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040201051021.GO18725@parcelfarce.linux.theplanet.co.uk>
References: <6B09584CC3D2124DB45C3B592414FA830112C34F@bgsmsx402.gar.corp.intel.com> <20040129150925.GC18725@parcelfarce.linux.theplanet.co.uk> <20040129155911.GD18725@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401290802370.689@home.osdl.org> <20040129164230.GE18725@parcelfarce.linux.theplanet.co.uk> <m1hdybwzli.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hdybwzli.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 02:57:29PM -0700, Eric W. Biederman wrote:
> Is it really safe to treat the base address as a u32?  I know
> if I was doing the BIOS and that address was tied to a 32bit BAR I
> would be extremely tempted to put those 256M of address space above
> 4G.  Putting something like that below 4G leads to 1/2 Gig of memory
> missing. 

This is actually a Linux limitation -- we're pretty bad at dealing with
64-bit BARs on 32-bit architectures.  There's two interfaces to get
at it -- ioremap() and set_fixmap().  Both of these interfaces take an
unsigned long to describe a physical address.

> Point being I don't think it is safe to assume the BIOS always puts
> the extended PCI configuration space below 4G.

MCFG isn't described in any released version of the ACPI spec, so I
don't know whether it's even possible for it to be a 64-bit address.
There's a reserved field that might be used for the upper 32 bits.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
