Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTKKU0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 15:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbTKKU0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 15:26:10 -0500
Received: from gaia.cela.pl ([213.134.162.11]:59400 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263765AbTKKU0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 15:26:06 -0500
Date: Tue, 11 Nov 2003 21:25:55 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Julien Oster <lkml-20031111@mc.frodoid.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A7N8X (Deluxe) Madness
In-Reply-To: <frodoid.frodo.87n0b2zmk1.fsf@usenet.frodoid.org>
Message-ID: <Pine.LNX.4.44.0311112120450.30654-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'd guess one is locking up due to hard disk load,
> > and the other is locking up due to automatic suspend/standby issues.
> > Can you verify that the ac kernel isn't locking up due to a 'screensaver' 
> > type problem?
> 
> Interesting question. I also thought about that one. However,
> regarding X, the machine sometimes crashes before the X Server
> screensaver (nothing special there, just the built in one that turns
> the screen black) is clearing the screen and sometimes afterwards. If
> it crashes afterwards, I can of course not see when it crashed, since
> I don't see the clock on the screen anymore.
> 
> And there's nothing else which I could think of. I have resetted the
> spinout time for the harddisks to "never" (for different reasons) and
> I don't think that there's any power saving stuff enabled in BIOS
> setup. I'll check that. However, I'm afraid there really isn't any
> screensaver or powersaving thing within my system, of course for the
> standard X screensaver, which doesn't seem related to it.

Indeed however I didn't mean the X server xscreensaver and family - I 
meant the BIOS DPMS, kernel console saver, etc functionality.  I had this 
kind of problem with my stationary computer (it locked solid when the 
screen was blanked) with some older kernel version (around 2.4.9).  I 
think kernel screen saveing can be turned off with some sort of escape 
code...

indeed:
$ man console_codes
  /timeout
gives:
  ESC [ 9 ; n ] where n is screen blank timeout in minutes
  ESC [ 13 ] to unblank
  ESC [ 14 ; n ] to set the VESA powerdown interval in minutes
so try something like
  echo -e "\e[13]\e[9;10080]\e[14;10080]"
to make it blank after a week and see if it still locks.
You can also try turning of VESA/DPMS blanking in the Bios.

Cheers,
MaZe.


