Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276800AbRJKT7b>; Thu, 11 Oct 2001 15:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276839AbRJKT7P>; Thu, 11 Oct 2001 15:59:15 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:23303 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S276831AbRJKT67>; Thu, 11 Oct 2001 15:58:59 -0400
Message-Id: <200110111959.f9BJxQY99154@aslan.scsiguy.com>
To: Alexander Feigl <Alexander.Feigl@gmx.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: aic7xxx SCSI system hangs 
In-Reply-To: Your message of "11 Oct 2001 21:44:41 +0200."
             <1002829481.12402.16.camel@PowerBox.MysticWorld.de> 
Date: Thu, 11 Oct 2001 13:59:26 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am rather sure that the cabling is Ok. Besides I am not a SCSI newbie
>(although I don't have any ideas how it works internally) - everything
>else works without problems. High data rate reading of a CD-ROM,
>ripping, reading the TOC of data CD-ROM and reading the TOC of a CDDA
>with cdda2wav. On my system 3 things have to come together.
>
>1) I use cdrecord -toc to read the TOC
>2) A CDDA disc is inserted in the drive
>3) I use my Plextor PX 32TS drive
>
>The problem is 100% reproducable here. 

That's great and all, but it doesn't change the fact that the
problem, from the Adaptec chip's perspective, is a protocol
violation *on the bus*.  I'm willing to believe that there is
a chip bug in the aic7896/97 if you can provice a SCSI bus trace
indicating that everything is normal on the SCSI bus.

>A co-developer of my project has similar problems with reading the TOC.

On the same or different controller?

>> As for why you cannot talk to the device after a while, the device
>> has been set offline.  The controller was unable to talk to it
>> successfully, so the SCSI layer decided to ignore it.
>
>If the device is only set offline it would be a minor problem. Probably
>I could do rmmod/insmod or scsi-remove-single-device and re-add it. As I
>mailed in my first posts even a cdrecord -scanbus or accesses to other
>drives on the same controller hang and will be in uninterruptible state
>after this call. The processes cannot be killed, the module cannot be
>unloaded and I have to reboot to do any SCSI accesses again.

To diagnose why things are hung will require you to grovel around
in the SCSI data structures to determine why I/O is hung.  Perhaps
use kdb to change the SCSI loging level after the hangs start, then
try access to another device and see where the traces lead you?  I
cannot reproduce the problem here, so it is difficult for me to debug
it.

--
Justin
