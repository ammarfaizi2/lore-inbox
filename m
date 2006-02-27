Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWB0M74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWB0M74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWB0M7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:59:55 -0500
Received: from styx.suse.cz ([82.119.242.94]:64431 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751140AbWB0M7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:59:55 -0500
Date: Mon, 27 Feb 2006 13:59:51 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Samuel Masham <samuel.masham@gmail.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060227125951.GA11497@suse.cz>
References: <20060222013410.GH20204@MAIL.13thfloor.at> <20060222023121.GB4661@stusta.de> <Pine.LNX.4.62.0602251255110.18095@pademelon.sonytel.be> <20060225124606.GI3674@stusta.de> <Pine.LNX.4.61.0602251521300.31692@yvahk01.tjqt.qr> <20060225145049.GQ3674@stusta.de> <Pine.LNX.4.61.0602251628050.13355@yvahk01.tjqt.qr> <20060225154028.GU3674@stusta.de> <Pine.LNX.4.61.0602252300200.7535@yvahk01.tjqt.qr> <20060225220737.GE3674@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225220737.GE3674@stusta.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 11:07:38PM +0100, Adrian Bunk wrote:
> On Sat, Feb 25, 2006 at 11:01:03PM +0100, Jan Engelhardt wrote:
> > >> >> You said that INPUT was not a driver, right. But without it, a keyboard 
> > >> >> won't work, will it?
> > >> >
> > >> >Yes, you do need INPUT for a keyboard.
> > >> >No, INPUT alone does not support any hardware - that's the job of the 
> > >> >drivers depending on INPUT.
> > >> >No, I don't understand what your question wants to achieve.
> > >> 
> > >> Let's look at another subsystem:
> > >> "Yes, you do need SND for a soundcard."
> > >> "No, SND alone does not support any hardware - that's the job of the drivers
> > >> depending on SND."
> > >> Should SND also be made a bool like INPUT?
> > >
> > >No, SND=m is also possible in the EMBEDDED=n case.
> > >
> > This example was to show that INPUT should not be y-only. Except if you plan to
> > make SND y-only too.
> 
> 
> Please try to understand the following:
> - INPUT=m is already only available if EMBEDDED=y

That is because too many people were making the mistake of saying 'N' to
INPUT. EMBEDDED here was really chosen while meaning EXPERT. This has
nothing to do with the kernel image size - the size of input.c is pretty
minimal anyway.

> - as I did already explain, EMBEDDED=y and MODULES=y at the same 
>   time doesn't make much  sense

It doesn't. But in the same way making INPUT depend on EMBEDDED doesn't
make sense if you intend EMBEDDED to truly mean what it says.

> As I already said, SND=m is completely different since it is also 
> available in the (common) EMBEDDED=n case.
 
It's not. Input, like sound, scsi, usb, firewire .... is just another
subsystem in the kernel. The kernel can live without it, and it used to
work just fine when all modular, including autoloading.

-- 
Vojtech Pavlik
Director SuSE Labs
