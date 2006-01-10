Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWAJKvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWAJKvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWAJKvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:51:36 -0500
Received: from gate.perex.cz ([85.132.177.35]:23700 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932177AbWAJKvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:51:35 -0500
Date: Tue, 10 Jan 2006 11:51:33 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Hannu Savolainen <hannu@opensound.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
In-Reply-To: <Pine.LNX.4.61.0601090010090.31763@zeus.compusonic.fi>
Message-ID: <Pine.LNX.4.61.0601101144130.10330@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <s5h7j9chzat.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601080225500.17252@zeus.compusonic.fi>
 <Pine.LNX.4.61.0601081007550.9470@tm8103.perex-int.cz>
 <Pine.LNX.4.61.0601090010090.31763@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Hannu Savolainen wrote:

> > >From the end user perspective, don't you think that having an opportunity 
> > to change the API entry point from one to multiple (user space library - 
> > preferred, direct kernel space - last resort) is more flexible for 
> > developers and users? Please, consider this question without any flames 
> > line which API is better and what's better for audio subsystem architects 
> > and what's better for your commercial work.
> It's too late to discuss about this. This decision could have been made in 
> 1992-1993 before large number of applications were already written. 
> Unfortunately the whole issue was raised just recently.
> 
> There has been definitions for routines like osslib_open(), etc in 
> soundcard.h for years. Also the libOSSlib.so library contains such 
> routines. If an OSS application is compiled without -DOSSLIB then they are 
> defined as open, etc. Unfortunately this version of soundcard.h was not 
> accepted by the kernel OSS maintainers so the stock Linux version doesn't 
> have these definitions.
> 
> If you like to get OSS apps to go through this library API you can do the 
> following:
> 
> - Get the latest soundcard.h from our OSS package to be included in the 
> stock kernel.
> - Do the same for libOSSlib (sources shipped with OSS).
> - Tell all OSS developers to change all OSS system calls to use their 
> osslib_ counterparts. And to recompile against the latest soundcard.h
> with -DOSSLIB. Make sure all distributions have done the changes before 
> that.
> 
> Then you can include a libOSSlib.o library in ALSA with all the OSS 
> emulation stuf inside.

You should do the clear statement that the direct using of syscalls is not 
recommented for application developers. Unfortunately at this time, I 
admit, it would be very difficult to change the existing applications.

I can only suggest to OSS including the commercial version:

1) create a osslib package under GPL and probably also under BSD licence
2) notify developers in your documentation that every syscall has own
   function in osslib and that using syscalls directly is not recommended

In this way, your library will go to all Linux distributions and OSS app 
developers will have quite confirmed the right direction from you.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
