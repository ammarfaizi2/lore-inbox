Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVCKXYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVCKXYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVCKXXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:23:54 -0500
Received: from smtp05.auna.com ([62.81.186.15]:1934 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S261818AbVCKXRj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:17:39 -0500
Date: Fri, 11 Mar 2005 23:17:38 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: AGP bogosities
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<1110579068l.8904l.0l@werewolf.able.es> <20050311221838.GG4185@redhat.com>
	<1110581163l.5796l.0l@werewolf.able.es>
	<1110582991.8513.13.camel@nosferatu.lan>
In-Reply-To: <1110582991.8513.13.camel@nosferatu.lan> (from
	azarah@nosferatu.za.org on Sat Mar 12 00:16:31 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1110583058l.5650l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.12, Martin Schlemmer wrote:
> On Fri, 2005-03-11 at 22:46 +0000, J.A. Magallon wrote:
> > On 03.11, Dave Jones wrote:
> > > On Fri, Mar 11, 2005 at 10:11:08PM +0000, J.A. Magallon wrote:
> > >  > 
> > >  > On 03.11, Paul Mackerras wrote:
> > >  > > Linus,
> > >  > > 
> > >  > ...
> > >  > > 
> > >  > > Oh, and by the way, I have 3D working relatively well on my G5 with a
> > >  > > 64-bit kernel (and 32-bit X server and clients), which is why I care
> > >  > > about AGP 3.0 support. :)
> > >  > > 
> > >  > 
> > >  > I think it is not a G5 only problem. I have a x8 card, a x8 slot, but
> > >  > agpgart keeps saying this:
> > >  > 
> > >  > Mar 11 23:00:28 werewolf dm: Display manager startup succeeded
> > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> > >  > Mar 11 23:00:29 werewolf kernel: agpgart: reserved bits set in mode 0xa. Fixed.
> > >  > Mar 11 23:00:29 werewolf kernel: agpgart: X passes broken AGP2 flags (2) in AGP3 mode. Fixed.
> > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
> > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
> > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> > >  > Mar 11 23:00:29 werewolf kernel: agpgart: reserved bits set in mode 0xa. Fixed.
> > >  > Mar 11 23:00:29 werewolf kernel: agpgart: X passes broken AGP2 flags (2) in AGP3 mode. Fixed.
> > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
> > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
> > >  > 
> > >  > The nvidia driver (brand new 1.0-7167, now works with stock -mm) tells me
> > >  > it is in x8 mode, but i suspect it lies....
> > >  > 
> > >  > Will try your patch right now.
> > > 
> > 
> > Looks fine, now I got:
> > 
> > agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> > agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> > agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> > agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> > agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> > agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> > 
> > werewolf:~> lspci
> > 00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller Hub (rev 02)
> > 00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP Controller (rev 02)
> > ...
> > 01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1)
> > 
> > BTW, I had to patch the nVidia driver. It just tries up to x4 AGP...
> > 
> 
> New and old one works fine with Paul's patch:
> 
> --old--
> agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> agpgart: X tried to set rate=x12. Setting to AGP3 x8 mode.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> -------
> 
> (ok, so old driver is a bit dodgy)
> 
> --new--
> agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> -------
> 

Just curiosity, what says your /proc/driver/nvidia/agp/status ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam3 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-6mdk)) #3


