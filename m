Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbSIZQwQ>; Thu, 26 Sep 2002 12:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261372AbSIZQwQ>; Thu, 26 Sep 2002 12:52:16 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:33168 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261363AbSIZQwP>;
	Thu, 26 Sep 2002 12:52:15 -0400
Date: Thu, 26 Sep 2002 18:57:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse/Keyboard problems with 2.5.38
Message-ID: <20020926185717.B27676@ucw.cz>
References: <1032996672.11642.6.camel@chevrolet> <20020926105853.A168142@ucw.cz> <1033039991.708.6.camel@chevrolet> <20020926133725.A8851@ucw.cz> <1033054211.587.6.camel@chevrolet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1033054211.587.6.camel@chevrolet>; from liste@jordet.nu on Thu, Sep 26, 2002 at 05:30:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 05:30:09PM +0200, Stian Jordet wrote:
> tor, 2002-09-26 kl. 13:37 skrev Vojtech Pavlik:
> > Hmm, have you looked into 'dmesg'? It prints the information with
> > KERN_DEBUG priority, which often won't make it on the screen or into the
> > logs ...
> > 
> > > I did, however, find out that if I press SHIFT+what
> > > ever of the buttons arrows, insert, home, page up/down, delete and end,
> > > I get just the same behaviour. It does not happen with CTRL or ALT.
> > 
> > Can you try passing 'i8042_direct' on the kernel command line to see if
> > it cures the problem? It looks like your keyboard is doing some very
> > strange 84-key-at-emulation, stranger than others do ...
> > 
> You had, ofcourse right, it was in my syslog. But the keystroke that
> make my computer freeze isn't there. This is the last line:
> 
> kernel: atkbd.c: Received 1d flags 00
> 
> But I find this line several places, so it's obviously not the one
> causing the crash. Altough, when passing i8042_direct to the kernel,
> everything works just as expected. My keyboard is a Logitech Cordless
> Desktop. The keyboard and mouse shares the same receiver, which both is
> connected via ps/2. 

Great. So, the problem is in i8042.c untranslating the keycodes. Please
also enable #define I8042_DEBUG_IO in drivers/input/serio/i8042.h, don't
start X, enable maximum console loglevel by "echo 16 16 16 16 >
/proc/sys/kernel/printk", and press the killing key combination.
(without i8042_direct, of course). Then send me the ten last or so lines
printed. This should allow me to fix the problem. Thanks.

-- 
Vojtech Pavlik
SuSE Labs
