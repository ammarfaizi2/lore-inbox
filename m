Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318252AbSHPJI4>; Fri, 16 Aug 2002 05:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318257AbSHPJI4>; Fri, 16 Aug 2002 05:08:56 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:34054 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S318252AbSHPJIz>; Fri, 16 Aug 2002 05:08:55 -0400
Message-Id: <200208160908.g7G98hp24237@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Misha Alex" <misha_zant@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Harddisk CHS to byte
Date: Fri, 16 Aug 2002 12:05:34 -0200
X-Mailer: KMail [version 1.3.2]
References: <F109qdBYbueKJ5iSFUc0000b46b@hotmail.com>
In-Reply-To: <F109qdBYbueKJ5iSFUc0000b46b@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 August 2002 06:46, Misha Alex wrote:
> >
> >   1)How do convert C,H,S into bytes.
> >     How can one read in linux if we know the C,H,S.
> >
> >      Also i tried the linear addressing linear = c*H*S + h*S +s -1 .But
> >linear or linear*512 never gave me the exact byte offset to seek.

linear = c*H*S + h*S + (s-1)

byte offset? It is sector offset... byte_ofs = sect_ofs*512

> >I am working in linux and using a hexeditor to seek .How many exact bytes
> >should i seek to find out the extended partition.I read the MBR and found
> >the exteneded partiton.
> >00 01 01 00 02 fe 3f 01 3f 00 00 00 43 7d 00 00
> >80 00 01 02 0b fe bf 7e 82 7d 00 00 3d 26 9c 00
> >00 00 81 7f 0f fe ff ff bf a3 9c 00 f1 49 c3 01
> >00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> >See the third column it is 0f(extended windows).The cylinder is 639(7f81
> > h) and sector is 1 .I don't know where to exactly read for the next
> > partiton. The byte offset for finding out the next partitions.

Most likely you forgot to *512

> >If i open hda3(Mind you hda3 is an extended partition on hda) with a
> >hexeditor i get
> >
> >00 01 81 7f 83 fe ff 7d 3f 00 00 00 00 82 3e 00
> >00 00 c1 7e 05 fe ff ff 3f 82 3e 00 7e 04 7d 00
> >00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> >.Now the first partition is of type 83 which is linux and the next
> >extended partition is of type 05(extended) and cylinder894 and sec1.
> >
> >*************************************
> >How do i find the next chain of extended partitions.I mean how do i
> > convert cylinder 894 ,sec1 and head 0 into absolute bytes so that i can
> > hexdump the next partition table for finding out ?
> >************************************

I'd say dig out good old DOS diskedit from Norton utils.
If you insist on hand editing, please note that CHS addresses
in MBR and extended partitions are bogus for new large drives -
use "Starting sector" and "# of sectors" instead.

There is subtle rule: starting sector is disk relative in MBR
but extd_partition_start relative in extd partition

Even more subtle: 

MBR -> part1                         <- disk relative
    -> extd1                         <- disk relative
                 -> part2            <- extd1 relative
                 -> extd2            <- extd1 relative
                          -> part3   <-extd1 relative (yes! _extd1_!)

Yes it's brain damaged.

Good luck. :-)
--
vda
