Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131367AbQLJSCS>; Sun, 10 Dec 2000 13:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbQLJSCI>; Sun, 10 Dec 2000 13:02:08 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:59837 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S131367AbQLJSB6>; Sun, 10 Dec 2000 13:01:58 -0500
Date: Sun, 10 Dec 2000 18:31:01 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11 EXT2 corruption (2)
Message-ID: <20001210183101.A6947@iapetus.localdomain>
In-Reply-To: <20001210161723.A1060@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20001210161723.A1060@iapetus.localdomain>; from F.vanMaarseveen@inter.NL.net on Sun, Dec 10, 2000 at 04:17:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the previous:
A clean rebuild of a linux tree failes because of EXT2 data block mixups
(?).  A second rebuild reveals further corruptions of similar nature. A
final fsck uncovers a few lost inodes. All file lengths are reasonable
i.e. no magic power of two numbers there.

doit
+ mkdir -p /loc/x28
+ cd /loc/x28
+ mkdir linux
+ tar xzf /home/fvm/kernel/v2.4/linux-2.4.0-test10.tar.gz
+ bzcat /home/fvm/kernel/v2.4/patch-2.4.0-test11.bz2
+ patch -p0 -s
+ zcat /home/fvm/kernel/v2.4/test12-pre7.gz
+ patch -p0 -s

[Further on a private patch failed because of NFS changes. Decided
 to redo it without the problematic patch]

rm -rf /loc/x28
doit
+ mkdir -p /loc/x28
+ cd /loc/x28
+ mkdir linux
+ tar xzf /home/fvm/kernel/v2.4/linux-2.4.0-test10.tar.gz
+ bzcat /home/fvm/kernel/v2.4/patch-2.4.0-test11.bz2
+ patch -p0 -s
7 out of 8 hunks FAILED -- saving rejects to linux/arch/ppc/configs/apus_defconfig.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
14 out of 14 hunks ignored -- saving rejects to linux/arch/ppc/configs/common_defconfig.rej
17 out of 18 hunks FAILED -- saving rejects to linux/arch/ppc/configs/gemini_defconfig.rej
6 out of 6 hunks FAILED -- saving rejects to linux/arch/ppc/configs/mbx_defconfig.rej
12 out of 15 hunks FAILED -- saving rejects to linux/arch/ppc/configs/oak_defconfig.rej

Now this _is_ bizarre since these are official patches and have worked before.

-rw-r--r--   1 fvm      sec          8882 Aug 11 20:18 linux/arch/ppc/configs/apus_defconfig.orig
File has incomplete last line, ending with:
	ending with:
	#
	# General setup
	#
	# CONFIG_HIGHMEM is not set
	# CONFIG_MOL is not set
	# CONFIG_ISA is not set
	# CONFIG_SBUS is not set
	# CONFIG_PCI is not set
	CONFIG_NET=y
	C

-rw-r--r--   1 fvm      sec         17682 Nov 13 21:58 linux/arch/ppc/configs/common_defconfig
File has incomplete last line, ending with:
	#
	# File systems
	#
	# CONFIG_QUOTA is not set
	# CONFIG_AUTOFS_FS is not set
	# CON

-rw-r--r--   1 fvm      sec          7678 Nov 13 21:58 linux/arch/ppc/configs/gemini_defconfig.orig
File has incomplete last line, ending with:
	#
	# Appletalk devices
	#
	# CONFIG_APPLETALK is not

-rw-r--r--   1 fvm      sec          5628 Nov 28  1999 linux/arch/ppc/configs/mbx_defconfig.orig
File starts with:
	ONFIG_HP100 is not set
	# CONFIG_NET_ISA is not set
	CONFIG_NET_PCI=y
	CONFIG_PCNET32=y
	# CONFIG_ADAPTEC_STARFIRE is not set
	# CONFIG_AC3200 is not set
	# CONFIG_APRICOT is not set
	# CONFIG_CS89x0 is not set
	CONFIG_DE4X5=y

-rw-r--r--   1 fvm      sec          5997 Aug 11 20:18 linux/arch/ppc/configs/oak_defconfig.orig
File starts with:
	CONFIG_SOUND_ICH is not set
	# CONFIG_SOUND_VMIDI is not set
	# CONFIG_SOUND_TRIX is not set
	# CONFIG_SOUND_MSS is not set
	# CONFIG_SOUND_MPU401 is not set
	# CONFIG_SOUND_NM256 is not set
	# CONFIG_SOUND_MAD16 is not set

mv /loc/x28 /loc/x28.bad
doit
+ mkdir -p /loc/x28
+ cd /loc/x28
+ mkdir linux
+ tar xzf /home/fvm/kernel/v2.4/linux-2.4.0-test10.tar.gz
+ bzcat /home/fvm/kernel/v2.4/patch-2.4.0-test11.bz2
+ patch -p0 -s
2 out of 2 hunks FAILED -- saving rejects to linux/drivers/usb/acm.c.rej
4 out of 4 hunks FAILED -- saving rejects to linux/drivers/usb/scanner.c.rej

Files contain binary data:
-rw-r--r--   1 fvm      sec         18592 Nov 13 21:59 linux/drivers/usb/acm.c.orig
-rw-r--r--   1 fvm      sec         26412 Nov 13 21:59 linux/drivers/usb/scanner.c.orig

mount -o ro,remount /loc
df /loc
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda4              6182660   4509152   1359440  77% /loc
fsck -f /dev/hda4
Parallelizing fsck version 1.15 (18-Jul-1999)
e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
/dev/hda4 is mounted.  

WARNING!!!  Running e2fsck on a mounted filesystem may cause
SEVERE filesystem damage.

Do you really want to continue (y/n)? yes

Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Unattached inode 216034
Connect to /lost+found<y>? yes

Inode 216034 ref count is 2, should be 1.  Fix<y>? yes

Unattached inode 216035
Connect to /lost+found<y>? yes

Inode 216035 ref count is 2, should be 1.  Fix<y>? yes

Unattached inode 216036
Connect to /lost+found<y>? yes

Inode 216036 ref count is 2, should be 1.  Fix<y>? yes

Unattached inode 216037
Connect to /lost+found<y>? yes

Inode 216037 ref count is 2, should be 1.  Fix<y>? yes

Unattached inode 216038
Connect to /lost+found<y>? yes

Inode 216038 ref count is 2, should be 1.  Fix<y>? yes

Unattached inode 216039
Connect to /lost+found<y>? yes

Inode 216039 ref count is 2, should be 1.  Fix<y>? yes

Unattached inode 216040
Connect to /lost+found<y>? yes

Inode 216040 ref count is 2, should be 1.  Fix<y>? yes

Unattached inode 216041
Connect to /lost+found<y>? yes

Inode 216041 ref count is 2, should be 1.  Fix<y>? yes

Unattached inode 216042
Connect to /lost+found<y>? yes

Inode 216042 ref count is 2, should be 1.  Fix<y>? yes

Unattached inode 216043
Connect to /lost+found<y>? yes

Inode 216043 ref count is 2, should be 1.  Fix<y>? yes

Unattached inode 216044
Connect to /lost+found<y>? yes

Inode 216044 ref count is 2, should be 1.  Fix<y>? yes

Pass 5: Checking group summary information
/dev/hda4: ***** FILE SYSTEM WAS MODIFIED *****
/dev/hda4: 194697/786432 files (4.6% non-contiguous), 1151976/1570353 blocks

/loc/lost+found:
total 88
-rw-r--r--   1 fvm      sec           547 Nov  6  1999 #216034
-rw-r--r--   1 fvm      sec            42 Aug  5  1998 #216035
-rw-r--r--   1 fvm      sec         14227 Feb 10  2000 #216036
-rw-r--r--   1 fvm      sec            39 Aug  5  1998 #216037
-rw-r--r--   1 fvm      sec          2075 Oct  7  1999 #216038
-rw-r--r--   1 fvm      sec          4333 Aug 11 20:19 #216039
-rw-r--r--   1 fvm      sec          5554 Feb 10  2000 #216040
-rw-r--r--   1 fvm      sec         24723 Nov 13 21:59 #216041
-rw-r--r--   1 fvm      sec          3736 Nov 12  1999 #216042
-rw-r--r--   1 fvm      sec          1459 Nov 13 21:58 #216043
-rw-r--r--   1 fvm      sec            37 Oct  7  1999 #216044
file *
#216034: English text
#216035: C program text
#216036: C program text
#216037: C program text
#216038: C program text
#216039: C program text
#216040: C program text
#216041: C program text
#216042: C program text
#216043: C program text
#216044: C program text

cycling power revealed two things:
-	File contents didn't change: everything reported about file contents
	still in effect.
-	BIOS reported I had only 64MB but I _did_ add 128MB two weeks ago. No
	kernel build problems until now when both BIOS and kernel decided I had
	only 64MB (I checked /var/log/messages for this).

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
