Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277532AbRLBNBV>; Sun, 2 Dec 2001 08:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277568AbRLBNBL>; Sun, 2 Dec 2001 08:01:11 -0500
Received: from mail100.mail.bellsouth.net ([205.152.58.40]:41873 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S277532AbRLBNBD>; Sun, 2 Dec 2001 08:01:03 -0500
Message-ID: <3C0A2609.AB42C366@mandrakesoft.com>
Date: Sun, 02 Dec 2001 08:00:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel list <linux-kernel@vger.kernel.org>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Keith Owens <kaos@ocs.com.au>
Subject: PATCH 2.4.17.2: CONFIG_FINAL, make kernel smaller
In-Reply-To: <3C0A1105.18B76D64@mandrakesoft.com> <25560.1007294074@ocs3.intra.ocs.com.au> <20011202133314.B717@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Sun, Dec 02, 2001 at 10:54:34PM +1100, Keith Owens wrote:
> > On Sun, 02 Dec 2001 06:31:17 -0500,
> > Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> > >Simply, all ext2 files are #include'd into a single file, ext2_all.c,
> > >and all functions and data structures are declared static.
> >
> > I like it.
> 
> Me also. Except for the KSTATIC spread all over the Kernel.

Yes :/  The source code is definitely uglier.  Maybe 'kstatic' would be
better on the eyes.

I just converted reiserfs and linux/kernel directories to KSTATIC.
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.17/config-final-2.4.17.2.patch.gz 
(should appear on ftp.kernel.org and mirrors soon, if not already)

Bytes saved/eliminated:
	ext2:		1135
	reiserfs:	2966
	kernel:		2578

	total:		6679 bytes saved

The conversion of linux/kernel was surprising...  I only changed two
'int' variables to KSTATIC.  That implies to me that the majority of the
space savings might simply come from the better packing created when
compiling all the files into a single .o.

I would like to also point out a nice fringe benefit:  since an entire
subsystem/driver is compiled together, you find bugs.  I have found
[tiny, unimportant] bugs in all the code I have converted to KSTATIC so
far.

> [jgarzik@rum linux-e2all]$ ls -l vmlinux* arch/i386/boot/bzImage*
> -rw-r--r--    1 jgarzik  jgarzik   1030123 Dec  2 07:50 arch/i386/boot/bzImage
> -rw-r--r--    1 jgarzik  jgarzik   1030263 Dec  2 06:04 arch/i386/boot/bzImage.orig
> -rwxr-xr-x    1 jgarzik  jgarzik   2809087 Dec  2 07:50 vmlinux*
> -rwxr-xr-x    1 jgarzik  jgarzik   2815766 Dec  2 06:04 vmlinux.orig*

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

