Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276782AbRJKTrh>; Thu, 11 Oct 2001 15:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276768AbRJKTr2>; Thu, 11 Oct 2001 15:47:28 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:40795 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S276787AbRJKTrW>;
	Thu, 11 Oct 2001 15:47:22 -0400
Subject: Re: PROBLEM: aic7xxx SCSI system hangs
From: Alexander Feigl <Alexander.Feigl@gmx.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200110111915.f9BJFLY97700@aslan.scsiguy.com>
In-Reply-To: <200110111915.f9BJFLY97700@aslan.scsiguy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 11 Oct 2001 21:44:41 +0200
Message-Id: <1002829481.12402.16.camel@PowerBox.MysticWorld.de>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2001-10-11 um 21.15 schrieb 1002827721:
>
> To sum up, from time to time, the controller sees the first REQ for
> the data-in phase that follows the command phase, prior to seeing the
> phase lines change to data-in.  This is either caused by the plextor
> not allowing the proper bus-settle time for the phase change to be
> seen prior to asserting REQ *OR* your cabling is poor (too long,
> marginal/bent pin, incorrect termination, etc.) giving a similar
> result.
>

I am rather sure that the cabling is Ok. Besides I am not a SCSI newbie
(although I don't have any ideas how it works internally) - everything
else works without problems. High data rate reading of a CD-ROM,
ripping, reading the TOC of data CD-ROM and reading the TOC of a CDDA
with cdda2wav. On my system 3 things have to come together.

1) I use cdrecord -toc to read the TOC
2) A CDDA disc is inserted in the drive
3) I use my Plextor PX 32TS drive

The problem is 100% reproducable here. 

A co-developer of my project has similar problems with reading the TOC.
But he owns a Plextor PX40 drive and has problems with cdda2wav. I
cannot remember if it hangs when reading CDDA or CD-ROM TOCs on his
machine. cdda2wav is working fine on my machine and I am unable to hang
the SCSI subsystem with it - he gets reproducible hangs on his machine.
cdrecord works fine on his machine and makes problems on mine.
 
> As for why you cannot talk to the device after a while, the device
> has been set offline.  The controller was unable to talk to it
> successfully, so the SCSI layer decided to ignore it.
> 

If the device is only set offline it would be a minor problem. Probably
I could do rmmod/insmod or scsi-remove-single-device and re-add it. As I
mailed in my first posts even a cdrecord -scanbus or accesses to other
drives on the same controller hang and will be in uninterruptible state
after this call. The processes cannot be killed, the module cannot be
unloaded and I have to reboot to do any SCSI accesses again.

Alexander Feigl

