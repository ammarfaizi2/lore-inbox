Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263158AbTDBVxE>; Wed, 2 Apr 2003 16:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbTDBVxE>; Wed, 2 Apr 2003 16:53:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31498 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263158AbTDBVxD>; Wed, 2 Apr 2003 16:53:03 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 64-bit kdev_t - just for playing
Date: 2 Apr 2003 14:03:58 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6fmoe$nvt$1@cesium.transmeta.com>
References: <200303311541.50200.pbadari@us.ibm.com> <Pine.LNX.4.44.0304021413210.12110-100000@serv> <200304020931.38671.pbadari@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200304020931.38671.pbadari@us.ibm.com>
By author:    Badari Pulavarty <pbadari@us.ibm.com>
In newsgroup: linux.dev.kernel
> 
> Roman,
> 
> Here is the patch for sd to allow more than 256 disks.
> There are few issues with the patch that need to be resolved.
> 
> 1) With the patch I get 16 bits for minor. Since 4 bits are used for
> partition, we get 12 bits to represent disks. So each major can support
> 2^12 =3D 4096 disks. Disks 0 - 4095 are mapped to major=3D8,=20
> disks 4096 - 8191 to major =3D 65 and so on..
> 
> This means ..
> 
> (i) I need to create nodes in /dev/ to match new <major, minor> for=20
> these disks.  Currently "mknod" is broken due to glibc issues with dev_t.
> 
> (ii) We need to worry about backward compatibility. For example:
> 17th disk used to have <65, 0>. Now its major, minor is <8, 256>.
> So /dev/ entires need to be re-created to match these, everytime
> you reboot 2.4/2.5 etc. Greg KH udev might fix this for us.=20
> 
> 2) Do we still need 16 majors for disks ?
> 

No, we don't.  On the other hand, we really should change to 64
partitions/disk, same as for non-SCSI disks.  16 really is too small.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
