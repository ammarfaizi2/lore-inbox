Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTCCNW2>; Mon, 3 Mar 2003 08:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbTCCNW2>; Mon, 3 Mar 2003 08:22:28 -0500
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:35290 "EHLO
	picard.csi-inc.com") by vger.kernel.org with ESMTP
	id <S264938AbTCCNWY>; Mon, 3 Mar 2003 08:22:24 -0500
Message-ID: <01ff01c2e189$5231cdc0$f6de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "Neil Brown" <neilb@cse.unsw.edu.au>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-raid" <linux-raid@vger.kernel.org>
References: <015d01c2df23$9c22f020$f6de11cc@black> <15967.52086.864201.674739@notabene.cse.unsw.edu.au>
Subject: Re: RAID SCSI binding
Date: Mon, 3 Mar 2003 08:32:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using mdadm v1.0.0

/dev/sdn1:
          Magic : a92b4efc
        Version : 00.90.00
           UUID : 05084a65:52ffddf9:e971cafd:3aca3445
  Creation Time : Wed Nov  7 07:19:15 2001
     Raid Level : raid5
    Device Size : 36081792 (34.41 GiB 36.94 GB)
   Raid Devices : 7
  Total Devices : 8
Preferred Minor : 4

    Update Time : Fri Feb 28 05:53:34 2003
          State : dirty, no-errors
 Active Devices : 7
Working Devices : 7
 Failed Devices : 1
  Spare Devices : 0
       Checksum : a1e07486 - correct
         Events : 0.189

         Layout : left-asymmetric
     Chunk Size : 128K

      Number   Major   Minor   RaidDevice State
this     0       8      209        0      active sync   /dev/sdn1
   0     0       8      209        0      active sync   /dev/sdn1
   1     1       8      225        1      active sync   /dev/sdo1
   2     2       8      241        2      active sync   /dev/sdp1
   3     3      65        1        3      active sync   /dev/sdq1
   4     4      65       17        4      active sync   /dev/sdr1
   5     5      65       33        5      active sync   /dev/sds1
   6     6      65       49        6      active sync   /dev/sdt1
/dev/sdo1:
          Magic : a92b4efc
        Version : 00.90.00
           UUID : 05084a65:52ffddf9:e971cafd:3aca3445
  Creation Time : Wed Nov  7 07:19:15 2001
     Raid Level : raid5
    Device Size : 36081792 (34.41 GiB 36.94 GB)
   Raid Devices : 7
  Total Devices : 8
Preferred Minor : 4

    Update Time : Fri Feb 28 05:53:34 2003
          State : dirty, no-errors
 Active Devices : 7
Working Devices : 7
 Failed Devices : 1
  Spare Devices : 0
       Checksum : a1e07498 - correct
         Events : 0.189

         Layout : left-asymmetric
     Chunk Size : 128K

      Number   Major   Minor   RaidDevice State
this     1       8      225        1      active sync   /dev/sdo1
   0     0       8      209        0      active sync   /dev/sdn1
   1     1       8      225        1      active sync   /dev/sdo1
   2     2       8      241        2      active sync   /dev/sdp1
   3     3      65        1        3      active sync   /dev/sdq1
   4     4      65       17        4      active sync   /dev/sdr1
   5     5      65       33        5      active sync   /dev/sds1
   6     6      65       49        6      active sync   /dev/sdt1

----- Original Message -----
From: "Neil Brown" <neilb@cse.unsw.edu.au>
To: "Mike Black" <mblack@csi-inc.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>; "linux-raid" <linux-raid@vger.kernel.org>
Sent: Friday, February 28, 2003 3:49 PM
Subject: Re: RAID SCSI binding


> On Friday February 28, mblack@csi-inc.com wrote:
> > Linux 2.4.20 (but not unique to this kernel -- been this way for over a year):
> > I have a RAID5 array that doesn't startup properly during boot (I have to stop it and restart after the system is up).  I've had
> > this problem forever and have been trying to fix it.
> > Here's what it looks like when it's up and running:
> > md4 : active raid5 sdn1[0] sdt1[6] sds1[5] sdr1[4] sdq1[3] sdp1[2] sdo1[1]
> >      216490752 blocks level 5, 128k chunk, algorithm 0 [7/7] [UUUUUUU]
> > The partitions types are set to 0x83 and the array is being manually
> > started in rc.local instead of doing auto-start.
>
> What tool are you using to start the array? raidstart or mdadm?
> There doesn't seem to be enough noise in the logs for it to be
> raidstart (no "md: autorun ...") so I assume mdadm.
>
> What do you get if you add "-v" to the mdadm running from rc.local?
> Can you show me
>   mdadm -E /dev/sda1 /dev/sdo1
>
> NeilBrown
>
> >
> > So it looks to me like the md driver doesn't like the raid system crossing the major device boundary for some odd reason.
> > Although I'm not sure why I can stop and restart after the system is totally up but not start it in rc.local using the same
> > commands:
>
> I suspect this is just a co-incidence.  I cannot imagine how the major
> device number could affect things at all.
>
> NeilBrown

