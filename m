Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266031AbUBCUdC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266094AbUBCUcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:32:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:46723 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266031AbUBCUcm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:32:42 -0500
Date: Tue, 3 Feb 2004 15:35:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
cc: John Bradford <john@grabjohn.com>,
       =?iso-8859-1?q?Martin_Povoln=FD?= <xpovolny@aurora.fi.muni.cz>,
       linux-kernel@vger.kernel.org, axboe@suse.de, alan@redhat.com
Subject: Re: 2.6.0, cdrom still showing directories after being erased
In-Reply-To: <yw1xn080m1d2.fsf@kth.se>
Message-ID: <Pine.LNX.4.53.0402031509100.32547@chaos>
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos>
 <401FB78A.5010902@zvala.cz> <Pine.LNX.4.53.0402031018170.31411@chaos>
 <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk> <yw1xsmhsf882.fsf@kth.se>
 <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
 <20040203174606.GG3967@aurora.fi.muni.cz> <200402031853.i13Ir1e0003202@81-2-122-30.bradfords.org.uk>
 <yw1xn080m1d2.fsf@kth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, [iso-8859-1] Måns Rullgård wrote:

> John Bradford <john@grabjohn.com> writes:
>
> > Regardless of specs, I don't know what the majority of devices in the
> > real world actually do.  Maybe Jens and Alan, (cc'ed), can help.
>
> Just tested with an ASUS SCB-2408 in my laptop.  It gives read errors
> after doing a fast erase, just like it should.
>
> --
> Måns Rullgård
> mru@kth.se
> -

I had to borrow a R/W CDROM because most everybody uses CR-R only
here. That's why it took so long to check. With SCSI, Linux 2.4.24,
cdrecord fails to umount the drive before it burns it. The result
is that the previous directory still remains at the mount-point.
This, even though cdrecord ejected the drive to "re-read" its
status.

Bottom line: If the CDROM isn't umounted first, you can still
get a directory entry even though the CDROM has been written with
about 500 magabytes of new data.


Script started on Tue Feb  2 02:11:28 2004
# cat cp.iso
if  ! test $1 ; then
    echo "Usage cp.iso <directory>"
    exit 1
fi
DEV=`cdrecord -scanbus | grep ROM | cut -f2,2`
echo Using CD-ROM device, ${DEV}
echo Trying to erase the media
cdrecord dev=${DEV} blank=fast
echo Starting to write the media
nice --18 mkisofs -L -l -R -P Analogic -p rjohnson@analogic.com \
 $1 | cdrecord -v fs=6m dev=${DEV} speed=4 -eject -

# cp.iso platinum
Using libscg version 'schily-0.1'
Using CD-ROM device, 0,4,0
Trying to erase the media
Cdrecord release 1.8a35 Copyright (C) 1995-1999 Jörg Schilling
scsidev: '0,4,0'
scsibus: 0 target: 4 lun: 0
Using libscg version 'schily-0.1'
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : SYNC
Vendor_info    : 'YAMAHA  '
Identifikation : 'CRW6416S        '
Revision       : '1.0b'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
cdrecord: Drive needs to reload the media to return to proper status.
Starting to write CD/DVD at speed 1 in write mode for single session.
Last chance to quit, starting real write in 9 seconds.8 seconds.7 seconds.6 seconds.5 seconds.4 seconds.3 seconds.2 seconds.1 seconds.

[SNIPPED...]
Starting to write the media
Cdrecord release 1.8a35 Copyright (C) 1995-1999 Jörg Schilling
TOC Type: 1 = CD-ROM
scsidev: '0,4,0'
scsibus: 0 target: 4 lun: 0
Using libscg version 'schily-0.1'
atapi: 0
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : SYNC
Vendor_info    : 'YAMAHA  '
Identifikation : 'CRW6416S        '
Revision       : '1.0b'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Drive buf size : 1566432 = 1529 KB
FIFO size      : 6291456 = 6144 KB
Track 01: data  unknown length
Total size:       0 MB (00:00.00) = 0 sectors
Lout start:       0 MB (00:02/00) = 0 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 5
  Is not unrestricted
  Is not erasable
  Disk sub type: 2
  ATIP start of lead in:  -11634 (97:26/66)
  ATIP start of lead out: 359848 (79:59/73)
Disk type: Short strategy type (Phthalocyanine or similar)
Manuf. index: 3
Manufacturer: CMC Magnetics Corporation
Trying to clear drive status.
cdrecord: Drive needs to reload the media to return to proper status.
Using TESTLIBRAW.000;1 for  platinum/firewire/libraw1394-0.9.0/doc/testlibraw.1.in (testlibraw.1)
Using CONFIG.000;1 for  platinum/firewire/libraw1394-0.9.0/config.h.in (config.h)
Using IEEE.000;1 for  platinum/IEEE-database/IEEE.dat.backup (IEEE.dat)
Using LD.000;1 for  platinum/kernel/linux-2.4.18/arch/mips64/ld.script.elf32.S (ld.script.elf64)
Using IPT_TOS.000;1 for  platinum/kernel/linux-2.4.18/include/linux/netfilter_ipv4/ipt_tos.h (ipt_TOS.h)
Using IPT_TCPMSS.000;1 for  platinum/kernel/linux-2.4.18/include/linux/netfilter_ipv4/ipt_tcpmss.h (ipt_TCPMSS.h)
Using IPT_MARK.000;1 for  platinum/kernel/linux-2.4.18/include/linux/netfilter_ipv4/ipt_mark.h (ipt_MARK.h)
Using IP6T_MARK.000;1 for  platinum/kernel/linux-2.4.18/include/linux/netfilter_ipv6/ip6t_mark.h (ip6t_MARK.h)
Using .000;1 for  platinum/kernel/linux-2.4.18/net/ipv4/netfilter/.ipt_TOS.o.flags (.ipt_tos.o.flags)
Using .001;1 for  platinum/kernel/linux-2.4.18/net/ipv4/netfilter/.ipt_MARK.o.flags (.ipt_mark.o.flags)
Using IPT_TOS.000;1 for  platinum/kernel/linux-2.4.18/net/ipv4/netfilter/ipt_TOS.o (ipt_tos.o)
Using IPT_TOS.001;1 for  platinum/kernel/linux-2.4.18/net/ipv4/netfilter/ipt_tos.c (ipt_TOS.c)
Using IPT_TCPMSS.000;1 for  platinum/kernel/linux-2.4.18/net/ipv4/netfilter/ipt_tcpmss.c (ipt_TCPMSS.c)
[SNIPPED...]

Using IPCHAINS.000 for  ./rr_moved/ipchains (ipchains)
Using XXXX.000 for  ./rr_moved/xxxx (xxxx)
  92  6760 platinum
  96  9510 rr_moved
 101   450 xxxx
 102   328 raid
 103   340 ipchains
 104   340 ipfwadm
 105   334 ah
 106   340 limit
 107   340 mac
 108   340 mark
 109   340 multiport
 110   340 owner
 111   340 state
 112   340 tos
 113   340 unclean
 114   340 ftp
 115   338 snmp
 116   340 log
 117   340 mark
 118   340 masquerade
 119   340 mirror
 120   340 redirect
 121   340 reject
 122   340 tos
 123   340 limit
 124   340 mark
 125   340 mark
 126   344 linked
 127   336 max
 128   340 acceleport
 129   340 sio
 130   340 pda
 131   340 u232
 132   450 xxxx
 133   328 raid
 134   340 limit
 135   340 mac
 136   340 mark
 137   340 multiport
 138   340 tos
 139   334 ah
 140   340 reject
 141   340 ipchains
 142   340 ipfwadm
 143   344 linked
 144   336 max
 145  1406 pcibr
 146   336 bits
 147   464 m68k
 148   348 bits
 149   348 bits
 150   838 bits
 151   350 sys
 152   348 bits
 153  1822 bits
 154   464 alpha
 155   338 net
 156   954 sys
 157   466 bits
 158   694 sys
 159   340 i686
 160  1308 sys
 161   586 bits
 162   334 sys
 163   456 bits
 164  2296 bits
 166   968 sys
 167   714 bits
 168   588 sys
 169  4220 sparc32
 172  5380 sparc64
 175   718 sys
 176  1580 bits
 177   336 bits
 178   832 bits
 179  1432 sparc
 180   452 sys
 181   330 sparc32
 182   336 bits
 183   464 sys
 184   606 bits
[SNIPPED...]

Writing  time:    1921.042s
Fixating...
Fixating time:   15.325s
cdrecord: fifo had 1924382 puts and 1924382 gets.
cdrecord: fifo was 0 times empty and 430948 times full, min fill was 100%.
You have new mail in /var/spool/mail/root
# ls /mnt
Presto	altmath
# ls /mnt
Presto	altmath
# ls /mnt/*
/mnt/Presto:

/mnt/altmath:
# ls /mnt/*
Presto	altmath
# exit
exit

Script done on Tue Feb  3 35:16:38 2004


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


