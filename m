Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317889AbSFNER6>; Fri, 14 Jun 2002 00:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317886AbSFNER5>; Fri, 14 Jun 2002 00:17:57 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:34052 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S317883AbSFNERz>;
	Fri, 14 Jun 2002 00:17:55 -0400
Message-ID: <3D096E09.B58901A7@torque.net>
Date: Fri, 14 Jun 2002 00:16:09 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Atwood <mra@pobox.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, kurt@garloff.de
Subject: Re: SCSI host/channel/lun/part to /dev/sd* or maj/minor mapping
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Atwood write:
> Is there a mapping between the Host,Channel,Id,Lun of a SCSI device as
> reported in /proc/scsi/scsi, and the the /dev/sd* names and/or the
> major/minor device numbers?
> 
> I've done some experamentation, and the more obvious ways of doing
> the mapping dont seem to be 100%.

Mark,
There are several utilities discussed at this url:
http://www.torque.net/sg/u_index.html
including scsidev and sg_map. Devfs shows you this mapping
via its hierarchy:
$ ls -l
total 0
brw-------    1 root     root       8,   0 Dec 31  1969 disc
crw-r-----    1 root     root      21,   0 Dec 31  1969 generic
brw-------    1 root     root       8,   1 Dec 31  1969 part1
$ pwd
/dev/scsi/host1/bus0/target0/lun0/


None of these approaches is completely satisfactory. Kurt Garloff
is working on a patch that seems to address this problem quite
cleanly:

$ cat /proc/scsi/map
# C,B,T,U	Type	onl	sg_nm	sg_dev	nm	dev
0,0,00,00	05	1	sg0	c:15:00	sr0	b:0b:00
1,0,01,00	05	1	sg1	c:15:01	sr1	b:0b:01
1,0,03,00	05	1	sg3	c:15:03	sr2	b:0b:02
1,0,05,00	00	1	sg4	c:15:04	sda	b:08:00
1,0,09,00	00	1	sg5	c:15:05	sdb	b:08:10
1,0,02,00	01	1	sg2	c:15:02	osst0	c:ce:00
2,0,01,00	05	1	sg6	c:15:06	sr3	b:0b:03
2,0,02,00	01	1	sg7	c:15:07	osst1	c:ce:01
2,0,03,00	05	1	sg8	c:15:08	sr4	b:0b:04
2,0,09,00	00	1	sg10	c:15:0a	sdd	b:08:30
3,0,10,00	00	1	sg11	c:15:0b	sde	b:08:40
3,0,12,00	00	1	sg12	c:15:0c	sdf	b:08:50


Doug Gilbert
