Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269120AbUIHLiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269120AbUIHLiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269121AbUIHLiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:38:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9442 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269120AbUIHLiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:38:17 -0400
Date: Wed, 8 Sep 2004 12:38:16 +0100
From: Matthew Wilcox <willy@debian.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       "David S. Miller" <davem@davemloft.net>, willy@debian.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: multi-domain PCI and sysfs
Message-ID: <20040908113816.GL642@parcelfarce.linux.theplanet.co.uk>
References: <9e4733910409041300139dabe0@mail.gmail.com> <200409072115.09856.jbarnes@engr.sgi.com> <20040907211637.20de06f4.davem@davemloft.net> <200409072125.41153.jbarnes@engr.sgi.com> <9e47339104090723554eb021e4@mail.gmail.com> <Pine.GSO.4.58.0409081302040.20726@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0409081302040.20726@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 01:11:36PM +0200, Geert Uytterhoeven wrote:
> On ia32, you access PCI I/O space (`I/O ports') using IN/OUT instructions.
> On non-ia32, you access PCI I/O space by accessing a special region of the CPU
> address space.

That's one way of doing it, sure ... ;-)

With HP's Dino PCI controller, you generate I/O cycles on the PCI bus by
writing the address to the DINO_PCI_ADDR register, then reading or writing
the DINO_IO_DATA register.

> You access PCI memory space by accessing a special region of the CPU
> address space on all platforms I'm aware of.

The PPC64 iSeries port seems to do a hypervisor call for readb() et al.
Nasty stuff.

> On ia32, it starts at CPU address
> zero, and there's no offset between CPU physical addresses and PCI bus
> addresses. On other platforms, there may be offsets.

It can even depend on machine model ... only some ia64 platforms have
different bus view and physical view (see Documentation/IO-mapping.txt)

> For access to PCI config space, there are even more possibilities. On ia32
> it's usually done using indirect access to PCI I/O space 0xcf8 etc. On other
> platforms it's usually done by accessing a special region of the CPU address
> space. Or in a different way ;-)

We have four options on i386 -- direct1, direct2, bios and mmconfig.
Other platforms ... well, get even weirder.  Magic registers, firmware
calls, memory mapped.  It's all been done.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
