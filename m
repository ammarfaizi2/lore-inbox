Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSFOQET>; Sat, 15 Jun 2002 12:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSFOQET>; Sat, 15 Jun 2002 12:04:19 -0400
Received: from hera.cwi.nl ([192.16.191.8]:39065 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315431AbSFOQES>;
	Sat, 15 Jun 2002 12:04:18 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 15 Jun 2002 18:04:19 +0200 (MEST)
Message-Id: <UTC200206151604.g5FG4JQ26968.aeb@smtp.cwi.nl>
To: garloff@suse.de
Subject: Re: /proc/scsi/map
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How can one assign stable device names to SCSI devices in
> case there are devices that may or may not be switched on or connected.

An interesting unsolved problem.
[Your discussion confuses a few things, especially in the context
of removable devices: a uuid lives on the disk, the C,B,T,U tends
to identify the drive rather than the disk.]

> Life would be easier if the scsi subsystem would just report which
> SCSI device (uniquely identified by the controller,bus,target,unit tuple)
> belongs to which high-level device.

Yes. I took your patch, ported it to 2.5, and tried it out.

# cat /proc/scsi/map
# C,B,T,U       Type    onl     sg_nm   sg_dev  nm      dev(hex)
1,0,06,00       0x00    1       sg0     c:15:00 sda     b:08:00
2,0,00,00       0x00    1       sg1     c:15:01 sdb     b:08:10
2,0,00,01       0x00    1       sg2     c:15:02 sdc     b:08:20
3,0,00,00       0x00    1       sg3     c:15:03 sdd     b:08:30
3,0,00,01       0x00    1       sg4     c:15:04 sde     b:08:40

Very good - in combination with /proc/scsi/scsi this gives
good information. I like it.

But just "cat /proc/scsi/map" is not good enough.
>From the above output alone one cannot easily guess which is which.
One would need a small utility that reads /proc/scsi/map and
/proc/scsi/scsi and produces something readable.
Will add sth to util-linux in case this gets accepted.

Andries


