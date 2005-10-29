Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVJ2OuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVJ2OuB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVJ2OuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:50:00 -0400
Received: from fairlite.demon.co.uk ([80.176.228.186]:10966 "EHLO
	windows.demon.co.uk") by vger.kernel.org with ESMTP
	id S1751159AbVJ2OuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:50:00 -0400
Subject: Re: Intel D945GNT crashes with AGP enabled
From: Alan Hourihane <alanh@fairlite.demon.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1130594110.5396.8.camel@blade>
References: <1130506715.5345.7.camel@blade>
	 <20051028162806.GA4340@redhat.com>  <1130518160.5372.6.camel@blade>
	 <1130585267.5360.12.camel@blade>  <1130588872.24907.1.camel@blade>
	 <1130593470.6786.4.camel@jetpack.demon.co.uk>
	 <1130594110.5396.8.camel@blade>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 29 Oct 2005 15:49:58 +0100
Message-Id: <1130597398.6786.10.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-29 at 15:55 +0200, Marcel Holtmann wrote:
> Hi Alan,
> 
> > > > And btw why can't I compile the intelfb on x86_64? I use the internal
> > > > graphics card (8086:2772) of the D945GNT motherboard.
> > > > 
> > > > 0000:00:02.0 VGA compatible controller: Intel Corporation 945G Integrated Graphics Controller (rev 02)
> > > > 
> > > > The Kconfig file makes it unselectable on x86_64 system.
> > > > 
> > > > config FB_INTEL
> > > >         tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
> > > >         depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
> > > > 
> > > > It seems that the most recent support in this driver is for the 915G and
> > > > not for the 945G. Are they so different that we need a complete new
> > > > driver or is the !X86_64 a relict from old times?
> > > 
> > > it seems that the first problem is:
> > > 
> > > arch/x86_64/kernel/built-in.o: In function `pci_iommu_init':
> > > pci-gart.c:(.init.text+0x8f0c): undefined reference to `agp_amd64_init'
> > > pci-gart.c:(.init.text+0x8f1a): undefined reference to `agp_bridge'
> > > pci-gart.c:(.init.text+0x8f1f): undefined reference to `agp_copy_info'
> > > make: *** [.tmp_vmlinux1] Error 1
> > > 
> > > Is this fixable or will the intelfb never work on x86_64 system?
> > 
> > You are barking up the wrong tree with this. Read the tristate line.
> > 
> > It doesn't mention 915 or 945 support. Intelfb only supports upto the
> > 865G anyway.
> 
> I read that line and enabling the compilation of the intelfb on x86_64
> was only a simple try to see if it compiles. It doesn't and basically I
> have no idea how to fix it.
> 
> The 915G (8086:2582) is supported by the driver in the latest vanilla
> kernel. Look at intelfb.h file and then you will see that the comment
> line in Kconfig is outdated. I also found a patch to support the 915GM
> (8086:2592) and maybe a similar patch will make the 945 work with the
> intelfb driver.

Doing a quick google shows that support is only partial for 915G. And
the 915GM patch would be easily done for the 945G.

But I'm not sure how partial that support is having not tried it, but I
can see that there are definate problems here.

Alan.
