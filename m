Return-Path: <linux-kernel-owner+w=401wt.eu-S1161200AbXAMDFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbXAMDFd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbXAMDFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:05:32 -0500
Received: from eazy.amigager.de ([213.239.192.238]:48045 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161200AbXAMDFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:05:32 -0500
Date: Sat, 13 Jan 2007 04:05:28 +0100
From: Tino Keitel <tino.keitel@tikei.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Luming Yu <luming.yu@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3 regression: suspend to RAM broken on Mac mini Core Duo
Message-ID: <20070113030528.GA8269@dose.home.local>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Luming Yu <luming.yu@gmail.com>, Adrian Bunk <bunk@stusta.de>,
	Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20070107151744.GA9799@dose.home.local> <1168194194.18788.63.camel@mindpipe> <20070107200453.GA3227@thinkpad.home.local> <20070107222706.GA6092@thinkpad.home.local> <20070107234445.GM20714@stusta.de> <20070108210428.GA7199@dose.home.local> <3877989d0701090651m84d7f41v5d06e1638a7eb31d@mail.gmail.com> <20070109231655.GA5958@thinkpad.home.local> <20070112145025.GB7685@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070112145025.GB7685@ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 14:50:25 +0000, Pavel Machek wrote:
> Hi!
> 
> > > >> > It didn't. It looks like it is unusable, becuase it isn't reliable in
> > > >> > 2.6.20-rc3.
> > > >>
> > > >> Is this issue still present in -rc4?
> > > >
> > > >I used 2.6.20-rc4 in single user mode, and applied 2 patches from
> > > >netdev to get wake on LAN support. This way I was able to set up an
> > > >automatic suspend/resume loop. It looked good, but after e.g. 20
> > > >minutes, the resume hang. So it is reproduceable with 2.6.20-rc4.
> > > >Unfortunately, I can not test the same with 2.6.18, as the wake on LAN
> > > >patches need 2.6.20-rc.
> > > 
> > > Hmm, do you mean this is the first time of this kind of testing?
> > > Is this issue related to LAN driver?
> > > I guess you should be able to set up an automatic suspend/resume loop
> > > with /proc/acpi/alarm, and test similar with 2.6.18.
> > 
> > Thanks for the hint. I just used /proc/acpi/alarm to set up a
> > suspend/resume loop and did ca. 100 cycles in a row with 2.6.18.2 in
> > single user mode, without a failure.
> 
> Can you do similar test on 2.6.20 -- w/o network driver loaded (and
> generaly minimum drivers?)

I think I found the problem. In 2.6.18, I had a slightly different
config. With 2.6.20-rc4, I had sucessful suspend/resume cycles without
the USB DVB-T box attached. I tweaked the USB options a bit and
activated some options (CONFIG_USB_SUSPEND,
CONFIG_USB_MULTITHREAD_PROBE, CONFIG_USB_EHCI_SPLIT_ISO,
CONFIG_USB_EHCI_ROOT_HUB_TT, CONFIG_USB_EHCI_TT_NEWSCHED) and now I can
suspend/resume without hangs. At least I haven't seen one until now.

Thanks for you patience and regards,
Tino

