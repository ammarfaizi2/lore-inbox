Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUGONXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUGONXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 09:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUGONXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 09:23:55 -0400
Received: from nef.ens.fr ([129.199.96.32]:56594 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S266198AbUGONXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 09:23:50 -0400
Date: Thu, 15 Jul 2004 15:23:48 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsuspend not working
Message-ID: <20040715132348.GA9939@lps.ens.fr>
References: <20040715121042.GB9873@lps.ens.fr> <20040715121825.GC22260@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040715121825.GC22260@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Thu, 15 Jul 2004 15:23:49 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 02:18:25PM +0200, Pavel Machek wrote:
> You are not really using swsusp. You are using pmdisk. Fix your
> kernel config.

Oh, I am confused; I believed that /proc/acpi/sleep was for swsuspend and
/sys/power/state for pmdisk. Well, things are changing I guess.

Anyway, I recompiled and tried again (not forgetting this time to swapon;
swsuspend has a usefull error message) and it worked ! Twice in a row !
I then tried S3, but then, no luck. The computer printed some text,
apparently shut down. I hit the power button to wake it up, I can hear
the fan and the disk spinning up, but the screen remains black and the
keyboard does nothing (caps lock does not lit the led, Ctrl-Alt-Suppr
does not reboot.) I have to hit the reset button.

Next I tried to suspend with the standard Fedora kernel
(2.6.6-1.435.2.3). I booted normally, did a telinit 1, umounted
everything except /proc and /, removed all modules except jbd and ext3
and did echo 4 > /proc/acpi/sleep and nothing happened. Half a second
later, sh was waiting for more input. The screen didn't blink, no line
was output, nothing in the logs.

The next step will be to boot the Fedora kernel directly in runlevel 1
(or maybe with init=/bin/sh, but I have to understand initrd, then) so
that most modules will never get loaded, video will never get set up,
etc., and then try S4. And then, their will be the long dichotomy to see
what is not working.

But that will be on monday, I think.

Éric
