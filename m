Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277011AbRJKWdw>; Thu, 11 Oct 2001 18:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277008AbRJKWdm>; Thu, 11 Oct 2001 18:33:42 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:53087 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S276997AbRJKWdc>; Thu, 11 Oct 2001 18:33:32 -0400
Date: Fri, 12 Oct 2001 00:31:36 +0200
From: Christian Ullrich <chris@chrullrich.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Can't mount reiserfs with 2.4.11, 2.4.10 works fine
Message-ID: <20011012003136.A435@christian.chrullrich.de>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <20011011223231.A730@christian.chrullrich.de> <Pine.GSO.4.21.0110111656200.24742-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.4.21.0110111656200.24742-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Oct 11, 2001 at 05:07:04PM -0400
X-Current-Uptime: 0 d, 01:05:13 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Alexander Viro wrote on Thursday, 2001-10-11:

> Umhm... Could you dd the sectors 0, 10000368 and 48063456 and mail them?

Here you are. I did the following (in 2.4.10, tell me if 
you need them from another kernel):

# dd if=/dev/hdb of=hdb-sect0 bs=512 count=1 
# dd if=/dev/hdb of=hdb-sect10000368 bs=512 count=1 skip=10000368
# dd if=/dev/hdb of=hdb-sect48063456 bs=512 count=1 skip=48063456

> Another thing to do - take the patch I've sent and add
> 
> 	printk("[%d %d]\n", start, size);
> 
> in the beginning of fs/partitions/check.c::add_gd_partition()

I patched both into 2.4.12, the patch went in without any problems.
The kernel (both vanilla and patched) didn't build with the .config I
used with the other kernels, it failed somewhere called IEEE1284.

dmesg output for 2.4.10+line:

SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 sda:[63 16002]
 sda1[16065 401625]
 sda2[417690 8401995]
 sda3[8819685 9092790]
 sda4 <[8819748 5253192]
 sda5[14073003 273042]
 sda6[14346108 995967]
 sda7[15342138 2570337]
 sda8 >
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 sdb:[63 10490382]
 sdb1[10490445 7164990]
 sdb2[17655435 257040]
 sdb4
hda: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(100)
hdb: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=79428/16/63, UDMA(100)
 hda:[63 2104452]
 hda1[2104515 37768815]
 hda2 <[2104578 20980827]
 hda5[23085468 48132]
 hda6[23133663 16739667]
 hda7 >
 hdb:[63 10000305]
 hdb1[10000368 68063184]
 hdb2 <[10000431 20972889]
 hdb5[48063519 30000033]
 hdb6 >[78063552 1999872]
 hdb3

------------------------------------------------------------------

dmesg output for 2.4.12+patch+line:

SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 sda:[63 16002]
 sda1[16065 401625]
 sda2[417690 8401995]
 sda3[8819685 9092790]
 sda4 <[8819748 5253192]
 sda5[14073003 273042]
 sda6[14346108 995967]
 sda7[15342138 2570337]
 sda8 >
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 sdb:[63 10490382]
 sdb1[10490445 7164990]
 sdb2[17655435 257040]
 sdb4
hda: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(100)
hdb: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=79428/16/63, UDMA(100)
 hda:[63 2104452]
 hda1[2104515 37768815]
 hda2 <[2104578 20980827]
 hda5[23085468 48132]
 hda6[23133663 16739667]
 hda7 >
 hdb:[63 10000305]
 hdb1[10000368 68063184]
 hdb2 < >[78063552 1999872]
 hdb3

[...]

ReiserFS version 3.6.25
hdb6: bad access: block=128, count=2
end_request: I/O error, dev 03:46 (hdb), sector 128
read_super_block: bread failed (dev 03:46, block 64, size 1024)
hdb6: bad access: block=16, count=2
end_request: I/O error, dev 03:46 (hdb), sector 16

---------------------------------------------------------------

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"

--0F1p//8PRICkK4MW
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=hdb-sect0
Content-Transfer-Encoding: base64

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAIElIBEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAABfduHbAACAAQEABw///z8AAACxl5gAAA///w8P///wl5gA0I8OBAAP//+CD///
wCenBACEHgAAAAAAAAAAAAAAAAAAAAAAVao=

--0F1p//8PRICkK4MW
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=hdb-sect10000368
Content-Transfer-Encoding: base64

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAD///Bw///z8AAABZBUABAA///wUP///wy0QC4MPJAQAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVao=

--0F1p//8PRICkK4MW
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=hdb-sect48063456
Content-Transfer-Encoding: base64

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAD///gw///z8AAAChw8kBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVao=

--0F1p//8PRICkK4MW--
