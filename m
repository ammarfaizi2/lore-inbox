Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283916AbRLROZg>; Tue, 18 Dec 2001 09:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284135AbRLROZ0>; Tue, 18 Dec 2001 09:25:26 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:13229 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S284038AbRLROZG>; Tue, 18 Dec 2001 09:25:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: "ChristianK."@t-online.de (Christian Koenig)
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
Date: Tue, 18 Dec 2001 16:26:23 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D7FE@orsmsx111.jf.intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D7FE@orsmsx111.jf.intel.com>
Cc: Otto Wyss <otto.wyss@bluewin.ch>, Alexander Viro <viro@math.psu.edu>,
        "H. Peter Anvin" <hpa@zytor.com>, antirez <antirez@invece.org>,
        Andreas Dilger <adilger@turbolabs.com>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        Craig Christophel <merlin@transgeek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16GLAZ-1rFguGC@fwd07.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 17 December 2001 23:10, Grover, Andrew wrote:
> > From: Alexander Viro [mailto:viro@math.psu.edu]
> >
> > On Mon, 17 Dec 2001, Grover, Andrew wrote:
> > > I don't think multiple streams is a good idea, but did you
> >
> > all see the patch
> >
> > > by Christian Koenig to let the bootloader load modules?
> >
> > That seems to solve
> >
> > > the problem nicely.
> >
> > That puts an awful lot of smarts into bootloader and creates
> > code duplication
> > for no good reason.

I agree, but the problem I have with Initrd is that you could only have 
1 single initrd-image on your hard disk / loaded by the boot-loader.

Imaging my situation, I have some removeable hard-disks, changing it between 
a large amount of Systems all with individual Hardware-configuration.
(Some SCSI, some ide, and a cluster booting with pxegrub/Floppy-Disks).

With the last relleas of my patch I'm now capable to have a grub menu.lst 
looking like:

tile Kernel 2.4.14 Adaptec xyz/ne2000
kernel /boot/vmlinuz-2.4.14 root=/dev/sdxyz ...

# Loading SCSI-Drivers
modulesfromfile /etc/modules-adaptec /lib/modules/2.4.14/modules.dep 

# Loading Network-Drivers
modulesfromfile /etc/modules-ne2000 /lib/modules/2.4.14/modules.dep

tile Kernel 2.4.14 Tecram xyz / Inter EExpresPro 

# Loading SCSI-Drivers
modulesfromfile /etc/modules-tecram /lib/modules/2.4.14/modules.dep 

# Loading Network-Drivers
modulesfromfile /etc/modules-eepro /lib/modules/2.4.14/modules.dep 
......

Could you Imaging what work it would be to create an individual initrd-Image 
/ Kernel Image for every system I have. Beside this I sometimes have the 
Problem that I come to a system never seen bevore and have to boot with my 
Floppy Disk's. (I'm now looking forward that grub someday gets capable to use 
cd-roms directly).

I know this it isn't the best solution to add a module-loader to the Kernel, 
but did you have a better idea ?

MfG, Christian Koenig.
