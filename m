Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVHMCzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVHMCzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 22:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVHMCzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 22:55:51 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:27820 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750836AbVHMCzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 22:55:50 -0400
Subject: Re: Trouble shooting a ten minute boot delay (SiI3112)
From: Steven Rostedt <rostedt@goodmis.org>
To: Shaun Jackman <sjackman@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <7f45d939050812183911812222@mail.gmail.com>
References: <7f45d939050809163136a234a@mail.gmail.com>
	 <42FC0DD4.9060905@gmail.com> <7f45d93905081201001a51d51b@mail.gmail.com>
	 <42FC57EC.2060204@pobox.com> <7f45d93905081210441e209e31@mail.gmail.com>
	 <Pine.LNX.4.61.0508122039390.16845@yvahk01.tjqt.qr>
	 <7f45d93905081212087ea5910a@mail.gmail.com>
	 <Pine.LNX.4.61.0508122113510.16845@yvahk01.tjqt.qr>
	 <7f45d939050812183911812222@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 12 Aug 2005 22:55:40 -0400
Message-Id: <1123901740.5296.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-12 at 18:39 -0700, Shaun Jackman wrote:
> 2005/8/12, Jan Engelhardt <jengelh@linux01.gwdg.de>:
> > >I tried earlyprintk=vga, but it didn't provide any extra information.
> > >Although, CONFIG_EARLY_PRINTK is disabled in my .config. Does it need
> > >to be set to CONFIG_EARLY_PRINTK=y for earlyprintk=vga to work?
> > 
> > I think yes, otherwise there would not be a .config entry at all.
> > 
> > >I haven't tried Sysrq+T yet. I'll report back.
> > 
> > Mind that it is unlikely to get a good trace at this stage, but it's worth the
> > try.

Is the keyboard ever set up then? This is all happening before
console_init (since that's when the prints start) and the early printk
won't show anything before it parses the options.  For other
architectures, I use to write out to the serial really early, just an
'x'. If you know how to do that, you could give it a try. Start at
start_kernel in main hopefully you see the 'x'. If you do, keep moving
it until you find where it's delaying.  Of course, this could be before
start_kernel, then you're really screwed, unless you're good at doing
the same in assembly (which I've done for MIPS, PPC and ARM, but never
for x86).

> 
> I compiled a vanilla 2.6.12.4 kernel, enabled EARLY_PRINTK and
> rebooted with earlyprintk=vga. The kernel didn't display any extra
> information before the delay.

Do you see grub saying "uncompressing kernel..." or whatever that says? 

-- Steve


