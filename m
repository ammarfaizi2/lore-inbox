Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271613AbRIJTNY>; Mon, 10 Sep 2001 15:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271617AbRIJTNO>; Mon, 10 Sep 2001 15:13:14 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:36875 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S271613AbRIJTM6>; Mon, 10 Sep 2001 15:12:58 -0400
Message-ID: <3B9D1078.54860A60@t-online.de>
Date: Mon, 10 Sep 2001 21:11:52 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
In-Reply-To: <200109072337.f87NbPY92715@aslan.scsiguy.com> <3B9CC525.7E26ABC2@mediascape.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Zaplinski schrieb:
> 
> Okay, I tested it today, compiled 2.4.9ac10 with the new driver and TCQ set
> to 32. I built the driver as a module to make sure that the machine at least
> boots into runlevel 3 (I have no console access, only access to the reset
> switch).
> 
> I rebooted and inserted the driver with 'modprobe aic7xxx', remembered that
> I forgot the verbose flag, removed the driver with 'modprobe -r' and
> re-inserted it with 'modprobe aic7xxx aic7xxx=verbose'. The machine was
> still alive then. But right after entering 'raidhotadd /dev/md1 /dev/sda1'
> the machine hung. reiserfs erased the last lines of /var/log/messages, but
> AFAIK the verbose driver output showed no errors.
> 
> But how can I help to reproduce the error? Of course I could break the
> mirror, compile the driver into the kernel (non-module) and do some stress
> test on the SCSI drive. But it's not so good when I drive this machine into
> a hang too often.
> 
> I compiled the old driver now, also with TCQ set to 32, and the machine
> seems to work fine.
> 

Hello...

I`m also in the moment testing with my raid-problem where one drive
falls out of the raid...till now it did not happen with the old driver,
but that means nothing as it only happened once a week or so.

Something other made me wonder:
I ran the machine several times with the *new* aic7xxx-driver (TCQ=32)
and the "aic7xxx=verbose" commandline, and i noticed the following:
At every reboot (made by "reboot", RH7.1), the machine was not able to
stop the raid5 correctly...it un-mounted the mountpoint (/home) and then
it normaly wants to stop the raid...(you see the messages "mdrecoveryd
got waken up...") but that did not work and after some time (30sec) the
kernel Ooopsed. This was reproducable and only occured if booted with
the "aic7xxx=verbose" kernel-parameter.
The effect after reboot was, that the raid had to be resynced because
one partition (that which always falls out) was damaged or at least
seemed to.
(The filesystem was clean, that was already unmounted as the oops
occured.)

Perhaps someone can test if this is reproducable with his machine
too...i use kernel 2.4.3, raid is built-in, also the aic7xxx, there are
three raid-disks (LVD, aic7xxx-controller on Mobo) in a raid5 mounted as
/home.

Solong...
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
