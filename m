Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUG2Pof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUG2Pof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268211AbUG2Pnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:43:41 -0400
Received: from guardian.hermes.si ([193.77.5.150]:11794 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S267779AbUG2PjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:39:19 -0400
Message-ID: <B1ECE240295BB146BAF3A94E00F2DBFF090203@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>,
       "'Pat LaVarre'" <p.lavarre@ieee.org>
Cc: "'linux_udf@hpesjro.fc.hp.com'" <linux_udf@hpesjro.fc.hp.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Can not read UDF CD
Date: Thu, 29 Jul 2004 17:32:52 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C47580.B7AECDC0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C47580.B7AECDC0
Content-Type: text/plain;
	charset="iso-8859-1"

> From: 	Pat LaVarre[SMTP:p.lavarre@ieee.org]
> 
> David B:
> 
> /// In short,
> 
> I suggest quickly trying the mount -o lastblock= and anchor= udf.ko
> options described at:
> 
> http://lxr.linux.no/source/Documentation/filesystems/udf.txt?v=2.6.5
> 
> else working thru til able to try the phgfsck described at my page:
> 
> http://udfko.blog-city.com/read/577369.htm
> 
> If you do post the phgfsck report on the web, I'll gladly link to it.
> 
I attach the "udf_test -scsi 1:0" output.


> /// At length, in Seven parts ...
> 
> /// 1) Similarly
	snip

> /// 2) Where
> 
> What kind of cable do you use, what is your device name, what is your
> mount point?
> 
cable is 80 wire ATA-66
dev  is /dev/cdrom2 -> /dev/hdc
/mnt/cdrom2


> Til I know, I will cover both USB and PATAPI and pretend you want to
> mount /dev/scd0 at /mnt/scd0.
> 
> /// 3) -o lastblock="$n"
> 
> Up in user land, my workaround was:
> 
> n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 - p\"`"
> sudo mount -r -o lastblock="$n" /dev/scd0 /mnt/scd0
> 
Will try...

> /// 4) patch -p1 ...
> 
> To recover the feature:
> 
> sudo mount -r /dev/scd0 /mnt/scd0
> 
> for such unfriendly discs, I web-published the patch quoted below to the
> patches-udf.lastblock package of http://iomrrdtools.sourceforge.net/
Wil try ...

> /// 5) -o anchor=...
> 
> If -o lastblock="$n" doesn't work for you, then one more blind try is -o
> anchor="$n" i.e.
> 
> n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 - p\"`"
> sudo mount -r -o anchor="$n" /dev/scd0 /mnt/scd0
> 
> Please note -o anchor is arguably reckless except when combined with -r.
> 
> /// 6) phgfsck
> 
> If neither blind try works for you, then to make sense of the disc you
> can try phgfsck.  For example, here, I see:
> 
> $ sudo phgfsck -scsi /dev/sg0 | grep 'AVDPs at'
>         Number of AVDPs: 2, AVDPs at  N-256,  N
> $
> 
> Seeing "AVDP ... at ... N" tells me to try what I mentioned above:
> 
> n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 - p\"`"
> sudo mount -r -o anchor="$n" /dev/scd0 /mnt/scd0
> 
> /// 7) reconfiguring Linux to permit phgfsck
> 
> http://www.extra.research.philips.com/udf/
> is the Philips page that offers the phgfsck, aka the "Philips UDF
> Verifier".
> 
> My clarification of that page is:
> 
> http://udfko.blog-city.com/read/577369.htm
> 
> Philips deserves nothing but kudos for donating the phgfsck to improve
> UDF interoperability worldwide ... except the fact remains they haven't
> chosen to release their copyright under a license approved as open
> source by such authorities as sourceforge.net.
> 
> Consequently, the phgfsck can be unusually hard to use in Linux. 
> Specifically, it does Not incorporate any of the better SCSI pass thru
> libraries.  Privately, as yet I've heard from Two employees of different
> corporations who privately requested and privately were denied
> permission to donate code into the phgfsck, because its source is partly
> closed.
> 
> First, as yet with the phgfsck, you have to substitute an sg name for
> the regular dev name, even when running 2.6.
> 
> To discover your sg name, you can try each of /dev/sg* to see what
> happens, or you can download yet another tool, such as sg_scan -i or my
> own plscsi -w, found at http://members.aol.com/plscsi/linux/
> 
> In theory `phgfsck -showscsi` will give you device names, but for me
> that query doesn't work reliably.  Trying here just now in
> 2.6.8-rc2-bk7, it hangs.  In the past, I've seen it miss names.
> 
> Often you need root privilege to discover the sg name.
> 
> You will probably have an sg name to find only if your kernel has a
> drivers/scsi/sg.ko and your device name was among the /dev/scd*
> 
> Else you might have to get into substituting ide-scsi.ko for ide-cd.ko,
> especially if your device name was among the /dev/hd*.  linux-scsi
> speaks occasionally of the issues such substitutions raise.
> 
> Pat LaVarre
> http://iomrrdtools.sourceforge.net/
> http://udfko.blog-city.com/
> 
> --- From:
> http://sourceforge.net/project/showfiles.php?group_id=101444&package_id=12
> 5426
> 
> See also: Readme.txt
> ... Copyright (c) 2004 Iomega Corp
> ... free software ...
> ... GNU General Public License as ... either ... or ...
> ...
> 
> diff -urp linux-2.6.8-rc2-bk7/fs/udf/lowlevel.c
> linux-2.6.8-rc2-bk7-pel/fs/udf/lowlevel.c
> --- linux-2.6.8-rc2-bk7/fs/udf/lowlevel.c	2004-06-15
> 23:19:36.000000000 -0600
> +++ linux-2.6.8-rc2-bk7-pel/fs/udf/lowlevel.c	2004-07-28
> 14:46:02.373806296 -0600
> @@ -73,9 +73,9 @@ udf_get_last_block(struct super_block *s
>  	struct block_device *bdev = sb->s_bdev;
>  	unsigned long lblock = 0;
>  
> -	if (ioctl_by_bdev(bdev, CDROM_LAST_WRITTEN, (unsigned long)
> &lblock))
> -		lblock = bdev->bd_inode->i_size >> sb->s_blocksize_bits;
> -
> +	if (!ioctl_by_bdev(bdev, CDROM_LAST_WRITTEN, (unsigned long)
> &lblock))
> +		return lblock;
> +	lblock = bdev->bd_inode->i_size >> sb->s_blocksize_bits;
>  	if (lblock)
>  		return lblock - 1;
>  	else
> diff -urp linux-2.6.8-rc2-bk7/fs/udf/super.c
> linux-2.6.8-rc2-bk7-pel/fs/udf/super.c
> --- linux-2.6.8-rc2-bk7/fs/udf/super.c	2004-07-28
> 10:36:35.928051888 -0600
> +++ linux-2.6.8-rc2-bk7-pel/fs/udf/super.c	2004-07-28
> 14:45:45.356393336 -0600
> @@ -1562,6 +1562,9 @@ static int udf_fill_super(struct super_b
>   		goto error_out;
>  	}
>  
> +	if (!UDF_SB_LASTBLOCK(sb)) {
> +		UDF_SB_LASTBLOCK(sb) = udf_get_last_block(sb);
> +	}
>  	udf_find_anchor(sb);
>  
>  	/* Fill in the rest of the superblock */
> 
>  <<report_1_stein.txt>> 

------_=_NextPart_000_01C47580.B7AECDC0
Content-Type: text/plain;
	name="report_1_stein.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="report_1_stein.txt"

UDF Conformance Testing Application
(c) Koninklijke Philips Electronics N.V. 1999-2004
Application version: 1.1r0
UCT Core version   : 1.1r0

Command:
  udf_test
Generic options parsing:

Medium info options parsing:

Device options parsing:
	-scsi 1:0

  host adapter: 1
  SCSI Id.    : 0

INQUIRY command:=20
  Vendor identification : TEAC
  Product identification: CD-540E
  Product revision level: 3.0A
  INQUIRY/ANSI Version  : 0
  Version Descriptors   : 0x2E00 0x3100 0x7200 0x3000 0x5C00 0x6200 =
0x6900 0x6E00
  Peripheral Device Type: CD/DVD Device

TEST UNIT READY command:=20
  Device ready

READ CAPACITY command:=20
  Highest valid block number in last complete session: 60071
  Block Size     : 2048

GET CONFIGURATION command: ..
  fails

MODE SENSE command:=20
  Medium Type: 36 (=3D 0x24) - overwritable

READ DISC INFORMATION command: .....
  fails, skip read track info

Created SCSI device
  host adapter id	: 1
  scsi id		: 0
  last valid block	: 60071
  block size		: 2048
  packet length		: 0
  nmb of sessions	: 1
  verify session	: 1
  session starts	: 0      =20
  medium WR type	: overwritable
  medium SE type	: unknown

=3D> ignore device medium WR type: overwritable

Inspect 1 block for presence of VAT or AVDP
starting at block: 60071

  =3D=3D>	read cache: max 16 buffers of 64 sectors, total 2048 Kb
err:	.
  60071	        1 error block read

Inspect 456 blocks for presence of VAT or AVDP
starting at block: 59615

  59615	      455 ok blocks read
  59815	AVDP	(255 times at 59815 thru 60069)
err:	.
  60070	        1 error block read

last AVDP at 60069 (N-2),	AVDP at 59815 (N-256)

Verification start medium info
  last valid block	: 60071
  block size		: 2048
  packet length		: 0
  nmb of sessions	: 1
  verify session	: 1
  session starts	: 0      =20
  medium WR type	: unknown
  medium SE type	: unknown

=3D=3D=3D=3D>	Start verification
	Start time   : 2004-07-29 17:26:54 +02:00 (east of UTC)
	Verbose level: 100
	Message limit: 20
	Fake read enabled
	Read cache enabled
	Initial UDF Revision range: 1.02 thru 2.50

=3D=3D=3D=3D>	Volume Structure verification
	Read Volume Recognition Sequence
     16	read block
	BEA01
	Start of Extended Area
     17	read block
	NSR02
     18	read block
	TEA01
     19	read block
	End of Extended Area
	End of Volume Recognition Sequence

  =3D=3D>	Changed UDF Revision range from: 1.02 thru 2.50 to: 1.02 thru =
1.50
-	because of "NSR descriptor"

	Reading Volume Information
    256	read block
	AVDP at 256
	First Tag Serial Number: 1
  59815	read block
	AVDP at N-256
	AVDP error: Volume Descriptor Sequence Extent not equal to
-		    the one read in first AVDP
-	   Main: length,location: 32768, 30654 expected:  32768, 32  =20
-	Reserve: length,location: 32768, 30670 expected:  32768, 48  =20
-	Using first AVDP
  60071	read block
  60071	Note: READ ERROR
	No AVDP at N

	Number of AVDPs: 2, AVDPs at  256,  N-256

=3D=3D=3D=3D>	Read Main VDS extent:      32, length:  32768
     32	read block
	PVD   VDS Number: 0
	PVD   Recording Time: 2004-07-27 17:14:49 +01:00
	PVD   Volume Identifier    : "VNC"
	PVD   Volume Set Identifier: "41067169"
  =3D=3D>	PVD  344 New Entity Identifier (regid):
	Application Entity Identifier
	  <empty>
  =3D=3D>	PVD  388 New Entity Identifier (regid):
	Implementation Entity Identifier
	  Identifier	     : "*AHEAD Nero"
	  OS Class	     : #00  Undefined
	  OS Identifier	     : #00  Undefined
	  Implementation Use : #05 #00 #00 #00 #00 #00
  =3D=3D>	Add PVD to VDS info
     33	read block
	IUVD  VDS Number: 1
	IUVD EntityID Identifier: "*UDF LV Info"
  =3D=3D>	IUVD 20  New Entity Identifier (regid):
	UDF Entity Identifier
	  Identifier	     : "*UDF LV Info"
	  UDF revision	     : 1.02
  =3D=3D>	Changed UDF Revision range from: 1.02 thru 1.50 to: 1.02 only
-	because of "UDF EntityID UDF revision"
	  OS Class	     : #05  Windows 9x
	  OS Identifier	     : #00  Windows 9x - Generic
	Warning: OS Class Windows 9x was introduced in UDF 1.50
-	Current UDF revision range: 1.02 only
	UDF IUVD Logical Volume Identifier : "VNC"
	UDF IUVD LVInfo1: <undefined>
	UDF IUVD LVInfo2: <undefined>
	UDF IUVD LVInfo3: <undefined>
  =3D=3D>	Add IUVD to VDS info
     34	read block
	PD    VDS Number: 2, Partition Number: 0
  =3D=3D>	PD   24  New Entity Identifier (regid):
	Application Entity Identifier
	  Identifier	     : "+NSR02"
	PD: No Unallocated/Freed Space Set in Partition Header Descriptor
  =3D=3D>	PD   196 New Entity Identifier (regid):
	Implementation Entity Identifier
	  Identifier	     : "*AHEAD Nero"
	  OS Class	     : #05  Windows 9x
	  OS Identifier	     : #00  Windows 9x - Generic
	Warning: OS Class Windows 9x was introduced in UDF 1.50
-	Current UDF revision range: 1.02 only
  =3D=3D>	Add PD to VDS info, partition number: 0
     35	read block
	LVD   VDS Number: 3
	LVD   Logical Volume Identifier: "VNC"
  =3D=3D>	LVD  216 New Entity Identifier (regid):
	Domain Entity Identifier
	  Identifier	     : "*OSTA UDF Compliant"
	  UDF revision	     : 1.02
	  Domain flags	     : #03  Hard and Soft Write-Protect
  =3D=3D>	Add LVD to VDS info
     36	read block
	USD   VDS Number: 4, nmb of ADs: 0
  =3D=3D>	Add USD to VDS info
     37	read block
	TD =20

=3D=3D=3D=3D>	Read Reserve VDS extent:      48, length:  32768
     48	read block
	PVD   VDS Number: 0
	PVD   Recording Time: 2004-07-27 17:14:49 +01:00
	PVD   Volume Identifier    : "VNC"
	PVD   Volume Set Identifier: "41067169"
  =3D=3D>	Add PVD to VDS info
     49	read block
	IUVD  VDS Number: 1
	IUVD EntityID Identifier: "*UDF LV Info"
	UDF IUVD Logical Volume Identifier : "VNC"
	UDF IUVD LVInfo1: <undefined>
	UDF IUVD LVInfo2: <undefined>
	UDF IUVD LVInfo3: <undefined>
  =3D=3D>	Add IUVD to VDS info
     50	read block
	PD    VDS Number: 2, Partition Number: 0
	PD: No Unallocated/Freed Space Set in Partition Header Descriptor
  =3D=3D>	Add PD to VDS info, partition number: 0
     51	read block
	LVD   VDS Number: 3
	LVD   Logical Volume Identifier: "VNC"
  =3D=3D>	Add LVD to VDS info
     52	read block
	USD   VDS Number: 4, nmb of ADs: 0
  =3D=3D>	Add USD to VDS info
     53	read block
	TD =20

=3D=3D=3D=3D>	Check equivalence of Main VDS and Reserve VDS

  =3D=3D>	Main and Reserve VDS are equivalent

=3D=3D=3D=3D>	Check Main VDS. Summary:
	 PVD VDS Number  0
	 LVD VDS Number  3
	 USD VDS Number  4
	  PD VDS Number  2
	IUVD VDS Number  1  ID: "*UDF LV Info"
	   5 prevailing VDS descriptors found


  =3D=3D>	Using Main VDS

=3D=3D=3D=3D>	Checking Logical Volume: "VNC"

	Prevailing Partition Descriptors:
	  pNmb:    0, start:   257, length:   18708, access: read-only

	LVD Partition Maps:
	  p0: Physical Partition Map (Type 1), pNmb:    0

  =3D=3D>	Changed medium WR type from unknown to read-only
-	        because of partition access type
  =3D=3D>	Changed medium SE type from unknown to nonsequential
-	        because of no Virtual Partition found


	Mounted Partitions:
-	p0: Physical, pNmb:    0, blocks:   257 thru   18964, access: =
read-only
-			  logical blocks:     0 thru   18707


	Read LVID sequence extent: 64, length: 4096
     64	read block
	LVID  - Close
	LVID Recording Time: 2004-07-27 17:14:49 +01:00
     65	read block
	TD =20

	Next UniqueID: #0000000000000102,
	from LVID Logical Volume Header Descriptor.


  =3D=3D>	p0: read Unallocated or Freed Partition Space Sets
	p0: No partition Space set found
	--

	Read FSD sequence extent: (0,p0), length:   2048

    257	read block
	FSD   FSN: 0, FSDN: 0
	FSD   Logical Volume Identifier: "VNC"
	FSD   File Set Identifier      : "VNC"
	FSD   Copyright File Identifier: <undefined>
	FSD   Abstract File Identifier : <undefined>

=3D=3D=3D=3D>	Volume identifiers summary:

	    PVD:         Volume Identifier  [32]: "VNC"
	    PVD:     Volume Set Identifier [128]: "41067169"
	    LVD: Logical Volume Identifier [128]: "VNC"
	   IUVD: Logical Volume Identifier [128]: "VNC"
	    FSD: Logical Volume Identifier [128]: "VNC"
	    FSD:       File Set Identifier  [32]: "VNC"

=3D=3D=3D=3D>	File Structure verification

	read Root Directory
    258	read block
	FE   file type DIR    name: <root>
	cnt:  extent type,      size,  location,part,     body, total alloc
	  1: long_ad    0        288          2 0          288       2048

  =3D=3D>	(max) depth:  1  1  Expand directory: <root>

	Read FIDs
    259	read block
	Verify FIDs
	FID   cid:       name: /<parent FID>, refers to: <root>
	FID   cid:  16   name: "patch-2.6.8-rc1-rc2.bz2"
	FID   cid:  16   name: "patch-2.6.8-rc1.bz2"
	FID   cid:  16   name: "linux-2.6.7.tar.bz2"
	Add FIDs to directory hierarchy and read FEs
    260	read block
	FE   file type FILE   name: "patch-2.6.8-rc1-rc2.bz2"
	cnt:  extent type,      size,  location,part,     body, total alloc
	  1: long_ad    0     543778          7 0       543778     544768
    261	read block
	FE   file type FILE   name: "patch-2.6.8-rc1.bz2"
	cnt:  extent type,      size,  location,part,     body, total alloc
	  1: long_ad    0    2662225        273 0      2662225    2662400
    262	read block
	FE   file type FILE   name: "linux-2.6.7.tar.bz2"
	cnt:  extent type,      size,  location,part,     body, total alloc
	  1: long_ad    0   35092228       1573 0     35092228   35092480

Directory: <root>

.d.p......:..r.x:..r.x:..r.x DIR   1 2004-07-27 16:14        288 =
/<parent FID>, refers to: <root>
..........:..r.x:..r.x:..r.x FILE  1 2004-07-27 10:09     543778 =
"patch-2.6.8-rc1-rc2.bz2"
..........:..r.x:..r.x:..r.x FILE  1 2004-07-27 10:08    2662225 =
"patch-2.6.8-rc1.bz2"
..........:..r.x:..r.x:..r.x FILE  1 2004-07-27 10:10   35092228 =
"linux-2.6.7.tar.bz2"

	file body read: "patch-2.6.8-rc1-rc2.bz2"
    264	fake read 266 blocks
	file body read: "patch-2.6.8-rc1.bz2"
    530	fake read 1300 blocks
	file body read: "linux-2.6.7.tar.bz2"
   1830	fake read 17135 blocks

	Expand complete, max depth  1 for directory: <root>
-			   3 files   0 directories
-	 overall total:    3 files   1 directory =20

	Maximum directory depth: 1

	End of directory tree expansion
	Excluding deleted FIDs with cleared ICB

=3D=3D=3D=3D>	Testing File Link Count by cross reference of 5 paths.
	File Link Count errors will be identified here by the
	physical address of the File Entry as well as all
	paths identifying the File Entry.
	The physical address of the File Entry is also shown in
	the informational read block messages above.
	Note that errors found here may have been reported before
	or may be caused by other previously reported errors.

=3D=3D=3D=3D>	Testing free Volume Space in USD Allocation Descriptors
	No free Volume Space defined in USD

=3D=3D=3D=3D>	Build Partition Space Bitmaps.
	Also check structures that overlap with partition space.

=3D=3D=3D=3D>	Partition Allocation summary :

 =3D=3D=3D>	Physical Partition p0:  size 18708 blocks, read-only
				blocks     257 thru   18964

  =3D=3D>	Compare partition p0 calculated bitmap to recorded Space Set
	  No Space Set found for partition p0

=3D=3D=3D=3D>	Final LVID verification
	Close LVID
  =3D=3D>	read-only Physical Partition p0 Space summary:
	                  Partition Length    :   18708
	             LVID Partition Size      :   18708
	             LVID Partition Free Space:       0
	          Verifier expected free space:       0


  =3D=3D>	       LVID status summary:
	Last modification Time    : 2004-07-27 17:14:49 +01:00 (east of UTC)
	Last written Developer Id : "*AHEAD Nero"
	Next UniqueID             : #0000000000000102 =3D> from LVID
	max used FE  UniqueID     : #0000000000000016
	Number of Files           :        3
	Number of Directories     :        1
	Min UDF Read   Revision   : UDF 1.02
	Min UDF Write  Revision   : UDF 1.02
	Max UDF Write  Revision   : UDF 1.02
	    Medium UDF Revision   : UDF 1.02


=3D=3D=3D=3D>	Testing uniqueness of relevant UniqueIDs.


	Test complete
	Elapsed time : 00:03

=3D=3D=3D=3D>	Volume identifiers summary:

	    PVD:         Volume Identifier  [32]: "VNC"
	    PVD:     Volume Set Identifier [128]: "41067169"
	    LVD: Logical Volume Identifier [128]: "VNC"
	   IUVD: Logical Volume Identifier [128]: "VNC"
	    FSD: Logical Volume Identifier [128]: "VNC"
	    FSD:       File Set Identifier  [32]: "VNC"

=3D=3D=3D=3D>	Encountered EntityID (regid) summary:

 count	EntityID

    3	Domain Entity Identifier
	  Identifier	     : "*OSTA UDF Compliant"
	  UDF revision	     : 1.02
	  Domain flags	     : #03  Hard and Soft Write-Protect
    2	UDF Entity Identifier
	  Identifier	     : "*UDF LV Info"
	  UDF revision	     : 1.02
	  OS Class	     : #05  Windows 9x
	  OS Identifier	     : #00  Windows 9x - Generic
	Warning: OS Class Windows 9x was introduced in UDF 1.50
-	Current UDF revision range: 1.02 only
    6	Implementation Entity Identifier
	  Identifier	     : "*AHEAD Nero"
	  OS Class	     : #00  Undefined
	  OS Identifier	     : #00  Undefined
	  Implementation Use : #05 #00 #00 #00 #00 #00
    7	Implementation Entity Identifier
	  Identifier	     : "*AHEAD Nero"
	  OS Class	     : #05  Windows 9x
	  OS Identifier	     : #00  Windows 9x - Generic
	Warning: OS Class Windows 9x was introduced in UDF 1.50
-	Current UDF revision range: 1.02 only
    2	Application Entity Identifier
	  <empty>
    2	Application Entity Identifier
	  Identifier	     : "+NSR02"

  These EntityIDs are also shown above when read for the first time

=3D=3D=3D=3D>	Final verify status report

  Final UDF Revision range: 1.02 only

  File System info
  last valid block	: 60071
  block size		: 2048
  packet length		: 0
  nmb of sessions	: 1
  verify session	: 1
  session starts	: 0      =20
  medium WR type	: read-only
  medium SE type	: nonsequential

  Summed file body sizes: 38298231 bytes	(36.523 Mbyte)

    Error count:   1	total occurrences:     1
  Warning count:   2	total occurrences:     9

  Disclaimer:
-	The number of errors and warnings is an indication only.
-	There is no guarantee that the number of errors shown
-	by the verifier is correct.


------_=_NextPart_000_01C47580.B7AECDC0--
