Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132105AbRA3Ux0>; Tue, 30 Jan 2001 15:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131141AbRA3UxI>; Tue, 30 Jan 2001 15:53:08 -0500
Received: from cold.fortyoz.org ([64.40.111.214]:32516 "HELO cold.fortyoz.org")
	by vger.kernel.org with SMTP id <S132105AbRA3Uws>;
	Tue, 30 Jan 2001 15:52:48 -0500
Date: Tue, 30 Jan 2001 12:53:18 -0800
From: David Raufeisen <david@fortyoz.org>
To: linux-kernel@vger.kernel.org
Subject: Re:  VT82C686A corruption with 2.4.x
Message-ID: <20010130125318.B3186@fortyoz.org>
Reply-To: David Raufeisen <david@fortyoz.org>
In-Reply-To: <Pine.LNX.4.30.0101301557540.11641-100000@svea.tellus> <Pine.LNX.4.21.0101301145360.13653-100000@ns-01.hislinuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0101301145360.13653-100000@ns-01.hislinuxbox.com>; from "David D.W. Downey" on Tuesday, 30 January 2001, at 11:51:58 (-0800)
X-Operating-System: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bash-2.04# dmesg | grep -i udma
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=1868/255/63, UDMA(66)
hdb: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=4982/255/63, UDMA(66)
hdc: ATAPI 52X CD-ROM drive, 192kB Cache, UDMA(33)

bash-2.04# uname -a
Linux prototype 2.4.1 #1 Tue Jan 30 01:45:38 PST 2001 i686 unknown

bash-2.04# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda2              14G  3.7G   10G  26% /
/dev/hdb1              38G   20G   19G  51% /storage

I dunno what you wanted to do by:

> dd if=/dev/hda4 of=/tmp/testing.img bs=1024M count=2k

Becuase it won't read 1024M into memory at once, says memory exhausted..

So I did..

bash-2.04# cd /storage
bash-2.04# dd if=/dev/hda2 of=testing.img bs=1024k count=2000
2000+0 records in
2000+0 records out
bash-2.04# ls -sh testing.img 
2.0G testing.img
bash-2.04#

No problems here (nothing in dmesg, no crashing..) Course interactivity in X was total shit while dd was
running =\.

On Tuesday, 30 January 2001, at 11:51:58 (-0800),
David D.W. Downey wrote:

> 
> Actually what rumors are you hearing?
> 
> Right now I can tell you from personal experience that the VIA VT82C686A
> chipset is causing kernel deaths, corrupted data on my drives, and UDMA
> issues (meaning that when I enable the UDMA support the kernel
> CONSISTENTLY crashes.)
> 
> This is all pre patch-2.4.1-pre11. I've not tested the new patch as of yet
> as I was in a car accident and have not felt well enough to mess with
> things. I will however be testing the new patch in about a half hour. The
> test bed will be the SMP box I've been talking about on the list, Red Hat
> 7.0 (only one that will install on the machine without dying instantly
> during installation) and using the KGCC rather than the GCC that comes
> with RH7.
> 
> Supposedly there are a couple of other patches available to add as well,
> but I'm not sure where they are exactly. I just downloaded the patch that
> Voj gave (v3.20) for the VIA chipsets.
> 
> 
> Nicholas, give me a bit and I'll let you know what's going on with my
> tests here. I can consistently get the current kernel to die simply by
> running
> 
> dd if=/dev/hda4 of=/tmp/testing.img bs=1024M count=2k
> 
> 
> TRy this on your box with the patch-2.4.1-pre11 added to the kernel source
> and let me know what you get. Maybe we can work on this together.
> 
> 
> David D.W. Downey
> 

-- 
David Raufeisen <david@fortyoz.org>
Cell: (604) 818-3596
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
