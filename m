Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTD3Spd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 14:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbTD3Spd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 14:45:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50948 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262306AbTD3Spc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:45:32 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Bootable CD idea
Date: 30 Apr 2003 11:57:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8p6b6$tm9$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0304301446450.2375-100000@einstein31.homenet> <200304301325.h3UDPtla000141@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200304301325.h3UDPtla000141@81-2-122-30.bradfords.org.uk>
By author:    John Bradford <john@grabjohn.com>
In newsgroup: linux.dev.kernel
>
> > > [1] I originally thought that the 2.4 kernel's in-built floppy
> > > bootloader used BIOS calls to access the disk, and that a 2.4 kernel
> > > image as the El-Torito boot image would work, as the kernel would be
> > > accessing the emulated disk, but it didn't seem to when I tried it
> > > just now - it failed with an error saying something along the lines of
> > > it had run out of data to decompress.
> > 
> > when you did "make bzImage", are you sure you didn't get the message about 
> > the kernel being too big for floppy booting?
> 
> No, I've just checked - the same kernel image boots fine from a real floppy.
> 

The boot sector bootloader is broken for anything but genuine legacy
floppies, because it relies on getting the proper sector not found in
order to determine the geometry.  Most LBA<->CHS conversions -- and
that includes El Torito, IDE floppies, USB floppies, and just about
anything else that isn't a classical legacy floppy -- simply spill
into the next track, confusing bootsect.S.  This is part of why
bootsect.S is gone in 2.5.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
