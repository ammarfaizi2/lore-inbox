Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbUDAXGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 18:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUDAXGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 18:06:15 -0500
Received: from mail-ext.curl.com ([66.228.88.132]:28941 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S263291AbUDAXGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 18:06:13 -0500
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: [Linux-NTFS-Dev] Geometry determination
References: <1080564842.5545.19.camel@imp.csi.cam.ac.uk>
	<Pine.LNX.4.21.0403291512030.6684-100000@mlf.linux.rulez.org>
	<20040329144111.GA26750@apps.cwi.nl>
In-Reply-To: <20040329144111.GA26750@apps.cwi.nl>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 01 Apr 2004 18:06:11 -0500
Message-ID: <s5ghdw3ti1o.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

> What I also claim is that Linux has no way of knowing what geometry
> other operating systems will assign to a disk. Different operating
> systems invent different translations.

The only one that matters is the one Windows expects.  Which is the
same as what DOS uses.  Which is the geometry from the "legacy INT13"
BIOS interface.

> Moreover, there is the matter of the correspondence of BIOS disk
> numbers and Linux disk names. Especially when both IDE and SCSI
> disks are present, and when more than two disks are present, it may
> be impossible to get this correspondence right. Details depend on
> the type of BIOS.

True, multiple disks pose a problem.  But for some applications (e.g.,
mine), the only disk that matters is the boot device.  And although it
is theoretically "impossible" to determine the Linux disk name for the
boot device, somehow this has not prevented millions of installations
of Linux boot loaders.

The vast majority of systems do not have very many drives.  So it is
possible to take a pretty good guess about how they are named.

Also, a fully modern EDD BIOS *will* let you perform this mapping
reliably by giving you PCI bus and device numbers.  The EDD module
exposes this information, provided your BIOS makes it available...
Unfortunately, few do (yet).

> However, there is really no good reason why the kernel would try to
> guess at the geometry other systems like to see.

I agree that such guessing is better left to userspace.  But I
disagree about applications using HDIO_GETGEO.  By writing to
/proc/ide/hda/settings, I can alter the values returned by HDIO_GETGEO
for IDE devices.  This is exactly what I want to do: Set the geometry
which ALL applications use.

For non-IDE devices, HDIO_GETGEO already returns useful geometry (in
my experience).  So it is a perfectly fine way for applications to
determine the disk geometry.

> For the past years, the main thing the kernel did was inferring the
> desired geometry from the partition table. But fdisk or LILO or
> whatever can do that as well. So, really no kernel help is needed.

This is completely useless for my application, which is to install an
OS for the first time.

> (And, you say, what if I am partitioning an empty disk to be used by
> DOS/Windows? There my stock answer "look at the partition table"
> fails, but there is some EDD stuff that could be used instead.  Of
> course one should always use the FDISK of some operating system to
> create partitions for that operating system.)

But I *am* partitioning an empty disk, and I want to use Linux (see
http://unattended.sourceforge.net/).

And I do.  See:

  http://www.ussg.iu.edu/hypermail/linux/kernel/0404.0/0269.html

Cheers!

 - Pat
