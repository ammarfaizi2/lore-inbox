Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269840AbRHDISa>; Sat, 4 Aug 2001 04:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269839AbRHDISQ>; Sat, 4 Aug 2001 04:18:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35398 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S269836AbRHDIQ6>; Sat, 4 Aug 2001 04:16:58 -0400
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: "chen, xiangping" <chen_xiangping@emc.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI bus speed
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC536@elway.lss.emc.com>
	<20010803153231.A28624@bacchus.dhis.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Aug 2001 02:10:28 -0600
In-Reply-To: <20010803153231.A28624@bacchus.dhis.org>
Message-ID: <m1lml0w8i3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle <ralf@uni-koblenz.de> writes:

> On Thu, Aug 02, 2001 at 06:47:49PM -0400, chen, xiangping wrote:
> 
> > Is there any easy way to probe the PCI bus speed of an Intel box?
> 
> You can find about PCI33 or PCI66 standards but there is no way to find
> the exact clock rate the PCI bus is actually clocked at.  

There is no portable way to find out the bus speed.  If you really
have to you can go in and stick an analyizer on the bus and measure it
but that is no help from  the software point of view.

Additionally there is not requirement that a PCI33 bus even run at
33Mhz  It can legaly run at 15Mhz to save powe if someone wants to,
and as of PCI 2.1 I believe it is perfectly legal to clock even a
PCI66 capable bus with all PCI66 capable cards down to 1Mhz.

As most systems use integrated solutions you can usually do something
like ask the northbridge of the chipset what frequency it is running
the PCI bus at.  This is code that needs to be written for every PCI
host bridge, and probably every PCI<->PCI bridge as well.

With linuxBIOS I might be able to help out a little bit by reporting
motherboard hardcodes but that is likely the most a BIOS can do.
Having a driver that understands how your northbridge chip clocks the
PCI bus goes much farther, to solving this problem.

> Which is a
> problem with certain non-compliant cards; the IOC3 card and a few others
> derive internal clocks from the PCI bus clock rate so will not properly
> work if operated on a bus with different clock rate.

Hmm.  So it looks like we need some kind of interface in linux to
propogate this information from the northbridge chip :(

Eric
