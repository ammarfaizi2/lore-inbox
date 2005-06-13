Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVFMXUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVFMXUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVFMWXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:23:33 -0400
Received: from msg-mx4.usc.edu ([128.125.137.9]:54665 "EHLO msg-mx4.usc.edu")
	by vger.kernel.org with ESMTP id S261553AbVFMWWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:22:02 -0400
Date: Mon, 13 Jun 2005 15:22:00 -0700 (PDT)
From: bhaskara <bhaskara@aludra.usc.edu>
Subject: Re: mouse still losing sync and thus jumping around
In-reply-to: <200506131703.07315.dtor_core@ameritech.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Voluspa <lista1@telia.com>, linux-kernel@vger.kernel.org
Message-id: <Pine.GSO.4.33.0506131506030.21818-100000@aludra.usc.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 13 June 2005 16:59, bhaskara wrote:
> > > On 2005-02-23 16:53:04 Dmitry Torokhov wrote:
> > > > On Wed, 23 Feb 2005 17:29:49 +0100, Nils Kalchhauser wrote:
> > > [...]
> > > >> it seems to me like it is connected to disk activity... is that
> > > >> possible?
> > >
> > > > Yes, It usually happens either under high load, when mouse interrupts
> > > > are significantly delayed. Or sometimes it happen when applications
> > > > poll battey status and on some boxes it takes pretty long time. And
> > > > because it is usually the same chip that serves keyboard/mouse it
> > > > again delays mouse interrupts.
> > >
> > > My notebook is an Acer Aspire 1520 (1524) with a Synaptics Touchpad,
> > > model: 1, fw: 5.8, id: 0x9248b1, caps: 0x904713/0x4000
> > >
> > > Kernels 2.6.11.11 and 2.6.12-rc6
> > > Synaptics driver 0.14.2
> > >
> > > The "lost sync at byte" and "driver resynched" began flooding the logs
> > > when I enabled Sensors --> Temperatures --> thermal_zone [THRC/THRS] in
> > > the system monitor gkrellm. I haven't tried battery monitoring.
> > >
> > > There are only occasional mouse pointer jumps, but the logfiles grow
> > > very quickly. I tried reducing the gkrellm updates from 10 times a
> > > second to 2, but it only had a marginal effect. It seems a bit silly
> > > that this powerful notebook (AMD64 Athlon 3400+) can't 'multitask'
> > > correctly.
> > >
> > > I thought about just erasing the warning messages from the kernel
> > > source (don't want to disable warn in syslog completely), but when I
> > > found the gkrellm culprit I turned off the monitoring instead,
> > > reluctantly.
> > >
> > > My system has no taxing desktop, just a window manager.
> > >
> >
> > I had this problem with the ps2 mouse on my desktop even under very light
> > load. This problem went away the very instant I started using a USB mouse.
> > So, I don't buy the delayed interrupts explanation.
> >
>
> You do not have to buy anything, you just need to read the code. pmouse
> driver emits this warning if delay between 2 bytes in a middle of a packet
> exceeds 0.5 sec. USB works slightly differently.

No offense ..... but, I did some googling and figured out where the mesg
was being printed from. So I ripped out all the unnecessary stuff from the
kernel and also stopped all the unnecessary services, but still got this
behavior (with XFCE and KDE). By the way , my desktop
started exhibiting this behaviour after  a couple of months of usage and
not immediately after a kernel upgrade (2.6.8+).  However, I remember not
seeing this behavior on older 2.6.* kernels.

The .5 second delay is a symptom rather than the cause ( bad hardware ? ).

-G

