Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289886AbSAPGae>; Wed, 16 Jan 2002 01:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290364AbSAPGaZ>; Wed, 16 Jan 2002 01:30:25 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:5385 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S289886AbSAPGaS>; Wed, 16 Jan 2002 01:30:18 -0500
Date: Wed, 16 Jan 2002 00:29:42 -0600
To: "Eric S. Raymond" <esr@thyrsus.com>, Rob Landley <landley@trommello.org>,
        Nicolas Pitre <nico@cam.org>, lkml <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020116062942.GC2067@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.33.0201151538340.5892-100000@xanadu.home> <20020116034137.CRFB26021.femail12.sdc1.sfba.home.com@there> <20020115224821.A4658@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115224821.A4658@thyrsus.com>
User-Agent: Mutt/1.3.25i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[esr]
> The version I just released does exactly that.  Well, not exactly; it
> actually looks at fstab -- /proc/mounts gives you '/dev/root' rather
> than a physical device name in the root entry.

/etc/fstab is hardly guaranteed to be accurate either.  The kernel
mounts the root device based on its command line and any pivot_root()
calls you make, not based on /etc/fstab.

[In practice, I imagine most people don't lie to fstab.  The fsck init
script would get annoyed.]

But the horse's mouth, in this case, is /proc/sys/kernel/real-root-dev,
a 16-bit decimal int which represents a device number in
MAJOR*256+MINOR format.  There *may* also the 'root=' asciiz string in
/proc/cmdline, which will be a 4-digit hex number, but that is not
reliable - because of pivot_root() among other things.

On my system, real-root-dev gives 8453, which means /dev/hde5, which is
on ide2.  According to /proc/ide/ide2/config, it is a PCI device of
type 105a:4d30 [Promise Ultra100], so you can derive
CONFIG_BLK_DEV_PDC202XX as well as CONFIG_BLK_DEV_IDEDISK.

Peter
