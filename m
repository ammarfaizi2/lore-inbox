Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbULSDOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbULSDOk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 22:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbULSDOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 22:14:40 -0500
Received: from ppp-202.176.140.131.revip.asianet.co.th ([202.176.140.131]:19083
	"EHLO mhfl2.mhf.dom") by vger.kernel.org with ESMTP id S261264AbULSDOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 22:14:37 -0500
From: Michael Frank <mhf@berlios.de>
To: softwaresuspend-devel@lists.berlios.de
Subject: Re: [SoftwareSuspend-devel] 2.6 Suspend PM issues
Date: Sun, 19 Dec 2004 11:14:24 +0800
Cc: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200412171315.50463.mhf@berlios.de> <20041218074202.GG29084@elf.ucw.cz> <20041218075003.GA3015@elf.ucw.cz>
In-Reply-To: <20041218075003.GA3015@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412191114.25930.mhf@berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 December 2004 15:50, Pavel Machek wrote:
> Hi!
>
> > > > > > By what was discussed wrt ALSA issue I gather that you still
> > > > > > resume _all_ drivers after doing the atomic copy?
> > > > > >
> > > > > > As explained earlier this year, if this is the case, it is
> > > > > > firstly unacceptable as it will result in loss of data in many
> > > > > > applications and secondly very clumsy.
> > > > > >
> > > > > > Example With 2.4 OK, with 2.6 It would fail:
> > > > > > A datalogger connected to a seral port of a notebook in the
> > > > > > field. Data transfer in progress which can be put on hold bo
> > > > > > lowering RTS (HW handshake) but _cannot_ be restarted. Battery
> > > > > > low, must suspend to change battery, upon resume transfer can
> > > > > > continue.
> > > > > >
> > > > > > Will this be taken care of?
> > > >
> > > > Driver will get enough info in its resume routine ("hey, it is
> > > > resume, but it is only resume after atomic copy"), so it can ignore
> > > > the resume if it really needs to.
> > >
> > > Each driver has to make the decision when to ignore resume? that would
> > > add a lot of bloat as well as lots of work to implement and test the
> > > changes for 100s of drivers...
> >
> > No, only those drivers where extra resume does some damage. So far I
> > know about one, and that's your data logging device.
>
> ...which will not work anyway, swsusp1 or swsusp2. Have you actually
> tried it?

I put suspend support into 2.4 serial driver and use it. It does work.

2.6 serial driver suspend was not working a year ago, have not tried since.

>
> During boot, BIOS is probably going to play with RTS anyway. So no
> matter what you do during suspend, you are probably going to screw it
> up anyway on the boot just before resume.

Luckily not on several of my machines and the linux 2.4 driver at least 
does not turn the lines on until resume tells it to do so...

>
> So there are currently 0 examples where extra resume hurts.

still 1 ;) and the same thing would apply to using an USB dongle and 
there will be many applications were it hurts as well.

Then, extra resume is not required, it's bad when it causes strain on the 
power source (notebook battery low), is a clumsy implementation and slows 
suspend process down.

Michael
