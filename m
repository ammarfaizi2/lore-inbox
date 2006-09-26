Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWIZPzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWIZPzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWIZPzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:55:04 -0400
Received: from xenotime.net ([66.160.160.81]:34459 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932149AbWIZPzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:55:00 -0400
Date: Tue, 26 Sep 2006 08:56:11 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout, switching to
 single_cmd mode...
Message-Id: <20060926085611.c32e7cb2.rdunlap@xenotime.net>
In-Reply-To: <s5hy7s6r5m6.wl%tiwai@suse.de>
References: <451834D0.40304@goop.org>
	<s5hlko7szjy.wl%tiwai@suse.de>
	<20060926083720.da9dca8e.rdunlap@xenotime.net>
	<s5hy7s6r5m6.wl%tiwai@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 17:48:33 +0200 Takashi Iwai wrote:

> At Tue, 26 Sep 2006 08:37:20 -0700,
> Randy Dunlap wrote:
> > 
> > On Tue, 26 Sep 2006 12:16:33 +0200 Takashi Iwai wrote:
> > 
> > > At Mon, 25 Sep 2006 12:58:08 -0700,
> > > Jeremy Fitzhardinge wrote:
> > > > 
> > > > I have a ThinkPad X60 which uses the Intel 82801G HDA audio chip.  This 
> > > > used to work for me, but lately (sometime during 2.6.18-rcX series) it 
> > > > stopped working - programs trying to use it tend to just block forever 
> > > > waiting for /dev/dsp.
> > > > 
> > > > The only obvious symptom is:
> > > > 
> > > >     hda_intel: azx_get_response timeout, switching to single_cmd mode...
> > > > 
> > > > appearing in the kernel log when booting.
> > > > 
> > > 
> > > There is no big change relevant to TP X60 during 2.6.18rc, so I don't
> > > think it's a regression in the hd-audio driver code.
> > > 
> > > > Details attached.  The dmesg output is for the FC6 distro kernel 
> > > > 2.6.18-1.2689.fc6PAE, but I see the same symptoms with 2.6.18-mm1.
> > > 
> > > You must see difference with mm1 (suppose that mm1 already includes
> > > the latest ALSA patches).  When the CORB/RIRB interrupt gets broken,
> > > the driver first switches to poling mode, then single_cmd mode as
> > > fallback.
> > > 
> > > Also, try disable_msi=1 option for mm1.  MSI seems broken on some
> > > systems.
> > 
> > is that "pci=nomsi" ?
> 
> No, snd-hda-intel driver has a new module option "disable_msi" to
> disable MSI support on that driver.  As default, it's off, i.e. MSI is
> enabled if available.  (Well, I feel it's better to rename it
> enable_msi and set on as default...)
> 
> Sorry for unclear text.

ugh.  We shouldn't have drivers with such options IMO.
I have seen/used MSI for ethernet, SATA, and audio.
It either works for all of them or none of them AFAIK.

Why do you think that it should not just be a global system option/flag?

---
~Randy
