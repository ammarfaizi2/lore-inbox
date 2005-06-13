Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVFMXss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVFMXss (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFMXrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 19:47:36 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:59292 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261500AbVFMWDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:03:19 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: bhaskara <bhaskara@aludra.usc.edu>
Subject: Re: mouse still losing sync and thus jumping around
Date: Mon, 13 Jun 2005 17:03:06 -0500
User-Agent: KMail/1.8.1
Cc: Voluspa <lista1@telia.com>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.33.0506131450100.21818-100000@aludra.usc.edu>
In-Reply-To: <Pine.GSO.4.33.0506131450100.21818-100000@aludra.usc.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506131703.07315.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 16:59, bhaskara wrote:
> > On 2005-02-23 16:53:04 Dmitry Torokhov wrote:
> > > On Wed, 23 Feb 2005 17:29:49 +0100, Nils Kalchhauser wrote:
> > [...]
> > >> it seems to me like it is connected to disk activity... is that
> > >> possible?
> >
> > > Yes, It usually happens either under high load, when mouse interrupts
> > > are significantly delayed. Or sometimes it happen when applications
> > > poll battey status and on some boxes it takes pretty long time. And
> > > because it is usually the same chip that serves keyboard/mouse it
> > > again delays mouse interrupts.
> >
> > My notebook is an Acer Aspire 1520 (1524) with a Synaptics Touchpad,
> > model: 1, fw: 5.8, id: 0x9248b1, caps: 0x904713/0x4000
> >
> > Kernels 2.6.11.11 and 2.6.12-rc6
> > Synaptics driver 0.14.2
> >
> > The "lost sync at byte" and "driver resynched" began flooding the logs
> > when I enabled Sensors --> Temperatures --> thermal_zone [THRC/THRS] in
> > the system monitor gkrellm. I haven't tried battery monitoring.
> >
> > There are only occasional mouse pointer jumps, but the logfiles grow
> > very quickly. I tried reducing the gkrellm updates from 10 times a
> > second to 2, but it only had a marginal effect. It seems a bit silly
> > that this powerful notebook (AMD64 Athlon 3400+) can't 'multitask'
> > correctly.
> >
> > I thought about just erasing the warning messages from the kernel
> > source (don't want to disable warn in syslog completely), but when I
> > found the gkrellm culprit I turned off the monitoring instead,
> > reluctantly.
> >
> > My system has no taxing desktop, just a window manager.
> >
> 
> I had this problem with the ps2 mouse on my desktop even under very light
> load. This problem went away the very instant I started using a USB mouse.
> So, I don't buy the delayed interrupts explanation.
>

You do not have to buy anything, you just need to read the code. pmouse
driver emits this warning if delay between 2 bytes in a middle of a packet
exceeds 0.5 sec. USB works slightly differently.
  
-- 
Dmitry
