Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUIJMgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUIJMgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUIJMgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:36:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3848 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267381AbUIJMft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:35:49 -0400
Date: Fri, 10 Sep 2004 13:35:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seems to be impossible to disable CONFIG_SERIAL [2.6.7]
Message-ID: <20040910133545.E22599@flint.arm.linux.org.uk>
Mail-Followup-To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
	linux-kernel@vger.kernel.org
References: <20040910110819.GE14060@lkcl.net> <20040910120950.D22599@flint.arm.linux.org.uk> <20040910122059.GG14060@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040910122059.GG14060@lkcl.net>; from lkcl@lkcl.net on Fri, Sep 10, 2004 at 01:20:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 01:20:59PM +0100, Luke Kenneth Casson Leighton wrote:
> On Fri, Sep 10, 2004 at 12:09:50PM +0100, Russell King wrote:
> > On Fri, Sep 10, 2004 at 12:08:19PM +0100, Luke Kenneth Casson Leighton wrote:
> > > hi,
> > > 
> > > has anyone noticed that it's impossible (without hacking) to remove
> > > CONFIG_SERIAL?
> > > 
> > > remove the entries or set all SERIAL config entries to "n"...
> > > hit make...
> > > CONFIG_SERIAL_8250 gets set to "m", CONFIG_SERIAL gets set to "y"!
> > > 
> > > seeerrrriiialllll muuuusssstttt dieeeeeee kill kill kill.
> > 
> > No idea - you've given very little information to go on.  I doubt
> > you're building an x86 kernel... Mind giving some clues and maybe
> > a copy of your .config file?
>  
>  x86 kernel, debian default config with legacy stuff like
> 
>  sure.

Ok, so it _isn't_ CONFIG_SERIAL at all.  Grumble.

Anyway, CONFIG_SERIAL_8250 gets set to 'm' because:

$ find . -name 'Kconfig*' | xargs grep 'select SERIAL_8250' -B5
./drivers/char/Kconfig-source "drivers/char/pcmcia/Kconfig"
./drivers/char/Kconfig-
./drivers/char/Kconfig-config MWAVE
./drivers/char/Kconfig- tristate "ACP Modem (Mwave) support"
./drivers/char/Kconfig- depends on X86
./drivers/char/Kconfig: select SERIAL_8250

and you have CONFIG_MWAVE is set to 'm'.  Of course, no surprises you
couldn't work this out - using "select" on a user-visible configuration
symbol is a bloody nightmare and IMHO fundamentally broken.

It seems to have been introduced by this change:

http://linux.bkbits.net:8080/linux-2.5/cset@3f6e2888FMm2_snV3LfsXw6tII6QvA?nav=index.html|src/|src/drivers|src/drivers/char|related/drivers/char/Kconfig

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
