Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136944AbREJV0e>; Thu, 10 May 2001 17:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136943AbREJV0Z>; Thu, 10 May 2001 17:26:25 -0400
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:39909 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S136945AbREJV0T>; Thu, 10 May 2001 17:26:19 -0400
Message-ID: <3AFB0778.1C97E416@bigfoot.com>
Date: Thu, 10 May 2001 14:26:16 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20pre2-amd-via-ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: ATAPI Tape Driver Failure in Kernel 2.4.4, More
In-Reply-To: <3AF9558F.9C76953C@tpr.com> <3AF9B411.2A0F3F43@tpr.com> <3AF9B876.FDB1B6DD@bigfoot.com> <3AFA8A1D.A9BBB4DF@tpr.com> <3AFAD0DC.90510557@windsormachine.com> <20010510204813.856F56A69@oscar.casa.dyndns.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > to do is be able to write to the tape, but not read from it.
> > Even in 2.2.x, putting the IDE patches in, breaks it.  Apparently
> > the HP's aren't completely ATAPI compatible

scsi0 : SCSI host adapter emulation for IDE ATAPI devices
scsi : 1 host.
  Vendor: HP        Model: COLORADO 20GB     Rev: 4.01
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi tape st0 at scsi0, channel 0, id 0, lun 0

The following all work with the above, either ide.2.2.19.04092001.patch or
ide.2.2.18.1221.patch:

linux-2.2.19pre17-ide
linux-2.2.19-intel-hpt-smp
linux-2.2.19-amd-via-ide
linux-2.2.20p2-amd-via-ide


[14:17] abit:/etc/dump > more *.block
::::::::::::::
dump0-abit-2.2.19-050401-06:43:36.block
::::::::::::::
/       0       dump
/usr    90113   dump
/var    3593378 dump
/tmp    3675075 dump
/home   3692644 dump
/kits   5237605 dump
/big    9440550 dump
::::::::::::::
dump1-abit-2.2.20-050901-17:10:08.block
::::::::::::::
/       14567911        dump
/usr    14574120        dump
/var    14810569        dump
/tmp    14832970        dump
/home   14833227        dump
/kits   15199116        dump
/big    15850029        dump
[14:17] abit:/etc/dump > mt seek 14567911
[14:18] abit:/etc/dump > mt tell
At block 14567911.
[14:20] abit:/etc/dump > /sbin/restore -t -f /dev/nst0 | head
Level 1 dump of / on abit:/dev/hda2
Label: "abit-2.2.20"
Dump   date: Wed May  9 17:11:53 2001
Dumped from: Fri May  4 06:43:36 2001
         2      .
        11      ./lost+found
      4065      ./lost+found/#4065
      4019      ./dev
      4030      ./dev/initctl
      4083      ./dev/audio
      4084      ./dev/audio1
      4111      ./dev/console

rgds,
tim.
--
