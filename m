Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUG2Qcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUG2Qcj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267793AbUG2Q0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:26:10 -0400
Received: from s1.mailresponder.info ([81.2.143.10]:60938 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S267572AbUG2QYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:24:08 -0400
From: "David Burg" <dburg@nero.com>
To: "'David Balazic'" <david.balazic@hermes.si>,
       "'Pat LaVarre'" <p.lavarre@ieee.org>
Cc: <linux_udf@hpesjro.fc.hp.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Can not read UDF CD
Date: Thu, 29 Jul 2004 18:23:38 +0200
Message-ID: <000301c47588$6850e2f0$7a02a8c0@cwx235>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <B1ECE240295BB146BAF3A94E00F2DBFF090203@piramida.hermes.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pat,

Could it be that Nero is to be blamed? I see in the verifier log:

	AVDP at N-256
	AVDP error: Volume Descriptor Sequence Extent not equal to
-		    the one read in first AVDP
-	   Main: length,location: 32768, 30654 expected:  32768, 32   
-	Reserve: length,location: 32768, 30670 expected:  32768, 48   

Let me know if you also think the medium produced by Nero has a mistake and
our Nero UDF engineers have a bug to fix.

Best regards,

David Burg

----------------------------------------------------------------
David Burg
Software Development,
InCD Project Leader

Ahead Software AG
Im Stoeckmaedle 18    fax:   +49 (0)7248 911 888
76307 Karlsbad        email: dburg@nero.com
Germany               http://www.nero.com
----------------------------------------------------------------



-----Original Message-----
From: linux_udf-owner@hpesjro.ipf.fc.hp.com
[mailto:linux_udf-owner@hpesjro.ipf.fc.hp.com] On Behalf Of David Balazic
Sent: Thursday, July 29, 2004 5:33 PM
To: David Balazic; 'Pat LaVarre'
Cc: 'linux_udf@hpesjro.fc.hp.com'; 'linux-kernel@vger.kernel.org'
Subject: RE: Can not read UDF CD


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

I attach the "udf_test -scsi 1:0" output.

> /// At length, in Seven parts ...
>
> /// 1) Similarly

	snip

> /// 2) Where
>
> What kind of cable do you use, what is your device name, what is your
> mount point?

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
> n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 -
> p\"`" sudo mount -r -o lastblock="$n" /dev/scd0 /mnt/scd0

Will try...

> /// 4) patch -p1 ...
>
> To recover the feature:
>
> sudo mount -r /dev/scd0 /mnt/scd0
>
> for such unfriendly discs, I web-published the patch quoted below to
> the patches-udf.lastblock package of
> http://iomrrdtools.sourceforge.net/

Wil try ...

> /// 5) -o anchor=...
>
> If -o lastblock="$n" doesn't work for you, then one more blind try is
> -o anchor="$n" i.e.
>
> n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 -
> p\"`" sudo mount -r -o anchor="$n" /dev/scd0 /mnt/scd0
>
> Please note -o anchor is arguably reckless except when combined with
> -r.
>
> /// 6) phgfsck
>
> If neither blind try works for you, then to make sense of the disc
> you can try phgfsck.  For example, here, I see:
>
> $ sudo phgfsck -scsi /dev/sg0 | grep 'AVDPs at'
>         Number of AVDPs: 2, AVDPs at  N-256,  N
> $
>
> Seeing "AVDP ... at ... N" tells me to try what I mentioned above:
>
> n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 -
> p\"`" sudo mount -r -o anchor="$n" /dev/scd0 /mnt/scd0
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
> Philips deserves nothing but kudos for donating the phgfsck to
> improve UDF interoperability worldwide ... except the fact remains
> they haven't chosen to release their copyright under a license
> approved as open source by such authorities as sourceforge.net.
>
> Consequently, the phgfsck can be unusually hard to use in Linux.
> Specifically, it does Not incorporate any of the better SCSI pass
> thru libraries.  Privately, as yet I've heard from Two employees of
> different corporations who privately requested and privately were
> denied permission to donate code into the phgfsck, because its source
> is partly closed.
>
> First, as yet with the phgfsck, you have to substitute an sg name for
> the regular dev name, even when running 2.6.
>
> To discover your sg name, you can try each of /dev/sg* to see what
> happens, or you can download yet another tool, such as sg_scan -i or
> my own plscsi -w, found at http://members.aol.com/plscsi/linux/
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
> Else you might have to get into substituting ide-scsi.ko for
> ide-cd.ko, especially if your device name was among the /dev/hd*. 
> linux-scsi speaks occasionally of the issues such substitutions
> raise.
>
> Pat LaVarre
> http://iomrrdtools.sourceforge.net/
> http://udfko.blog-city.com/
>
> --- From:
> http://sourceforge.net/project/showfiles.php?group_id=101444&package_
>id=12 5426
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

