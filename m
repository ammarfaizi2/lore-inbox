Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263339AbTDCKBI>; Thu, 3 Apr 2003 05:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263340AbTDCKBH>; Thu, 3 Apr 2003 05:01:07 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:38632 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S263339AbTDCKBG>; Thu, 3 Apr 2003 05:01:06 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 3 Apr 2003 02:09:48 -0800 (PST)
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <b6fmoe$nvt$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304030207230.31471-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when you think of huge raid arrays that present themselves to the system
as a single drive even 64 partitions can be limiting.

I don't really know what an appropriate limit would be, this may be
something that has a default setting for static dev entries and they
dynamic assignments can get more

David Lang

On 2 Apr 2003, H. Peter Anvin wrote:

> Date: 2 Apr 2003 14:03:58 -0800
> From: H. Peter Anvin <hpa@zytor.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: 64-bit kdev_t - just for playing
>
> Followup to:  <200304020931.38671.pbadari@us.ibm.com>
> By author:    Badari Pulavarty <pbadari@us.ibm.com>
> In newsgroup: linux.dev.kernel
> >
> > Roman,
> >
> > Here is the patch for sd to allow more than 256 disks.
> > There are few issues with the patch that need to be resolved.
> >
> > 1) With the patch I get 16 bits for minor. Since 4 bits are used for
> > partition, we get 12 bits to represent disks. So each major can support
> > 2^12 =3D 4096 disks. Disks 0 - 4095 are mapped to major=3D8,=20
> > disks 4096 - 8191 to major =3D 65 and so on..
> >
> > This means ..
> >
> > (i) I need to create nodes in /dev/ to match new <major, minor> for=20
> > these disks.  Currently "mknod" is broken due to glibc issues with dev_t.
> >
> > (ii) We need to worry about backward compatibility. For example:
> > 17th disk used to have <65, 0>. Now its major, minor is <8, 256>.
> > So /dev/ entires need to be re-created to match these, everytime
> > you reboot 2.4/2.5 etc. Greg KH udev might fix this for us.=20
> >
> > 2) Do we still need 16 majors for disks ?
> >
>
> No, we don't.  On the other hand, we really should change to 64
> partitions/disk, same as for non-SCSI disks.  16 really is too small.
>
> 	-hpa
>
> --
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
