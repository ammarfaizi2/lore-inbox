Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272086AbRIJWrn>; Mon, 10 Sep 2001 18:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272079AbRIJWrd>; Mon, 10 Sep 2001 18:47:33 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:56586 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272086AbRIJWr0>; Mon, 10 Sep 2001 18:47:26 -0400
Message-ID: <3B9D42C5.275A1558@t-online.de>
Date: Tue, 11 Sep 2001 00:46:29 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andreas Steinmetz <ast@domdv.de>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
In-Reply-To: <XFMail.20010911002924.ast@domdv.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz schrieb:
> 
> > Something other made me wonder:
> > I ran the machine several times with the *new* aic7xxx-driver (TCQ=32)
> > and the "aic7xxx=verbose" commandline, and i noticed the following:
> > At every reboot (made by "reboot", RH7.1), the machine was not able to
> > stop the raid5 correctly...it un-mounted the mountpoint (/home) and then
> > it normaly wants to stop the raid...(you see the messages "mdrecoveryd
> > got waken up...") but that did not work and after some time (30sec) the
> > kernel Ooopsed. This was reproducable and only occured if booted with
> > the "aic7xxx=verbose" kernel-parameter.
> > The effect after reboot was, that the raid had to be resynced because
> > one partition (that which always falls out) was damaged or at least
> > seemed to.
> > (The filesystem was clean, that was already unmounted as the oops
> > occured.)
> >
> > Perhaps someone can test if this is reproducable with his machine
> > too...i use kernel 2.4.3, raid is built-in, also the aic7xxx, there are
> > three raid-disks (LVD, aic7xxx-controller on Mobo) in a raid5 mounted as
> > /home.
> >
> Same behaviour for RAID1 and the new aic7xxx driver for me at nearly every
> reboot. The old driver works just fine (2.4.9).

Ok, as i am using Kernel 2.4.3, it seems that the problem exists from
2.4.3 to 2.4.9...could you easily post the kernel-oops ?

I can and will, but i am stil in testing the old driver with my
disk-falls-out-of-raid problem, so i cannot reboot the next week or so
as this problem only occurs randomly about once per week...:-(...and i
want to "circle in" this problem to be sure that it is not something
else...

One thing i realize in the moment:
The old driver uses a default TCQ of 8, now my /proc/scsi/aic7xxx/0 says
that the actual queue depth per device is 1,1,1,1,1.....the TCQ is 8.
We should test if the problem with the new driver goes away if we set a
TCQ of 1...or has someone done this already ?

This problem leads IMHO to the theory that the raid-code and the (new)
aic7xxx-code interfer in some way...(race condition?)...perhaps this
also causes my disk to fall out of the raid...

Solong...
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
