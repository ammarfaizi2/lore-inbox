Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUIJM4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUIJM4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267364AbUIJM4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:56:22 -0400
Received: from open.hands.com ([195.224.53.39]:19949 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S266643AbUIJM4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:56:19 -0400
Date: Fri, 10 Sep 2004 14:07:33 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: Re: seems to be impossible to disable CONFIG_SERIAL [2.6.7]
Message-ID: <20040910130733.GI14060@lkcl.net>
References: <20040910110819.GE14060@lkcl.net> <20040910120950.D22599@flint.arm.linux.org.uk> <20040910122059.GG14060@lkcl.net> <20040910133545.E22599@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910133545.E22599@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 01:35:45PM +0100, Russell King wrote:
> On Fri, Sep 10, 2004 at 01:20:59PM +0100, Luke Kenneth Casson Leighton wrote:
> > On Fri, Sep 10, 2004 at 12:09:50PM +0100, Russell King wrote:
> > > On Fri, Sep 10, 2004 at 12:08:19PM +0100, Luke Kenneth Casson Leighton wrote:
> > > > hi,
> > > > 
> > > > has anyone noticed that it's impossible (without hacking) to remove
> > > > CONFIG_SERIAL?
> > > > 
> > > > remove the entries or set all SERIAL config entries to "n"...
> > > > hit make...
> > > > CONFIG_SERIAL_8250 gets set to "m", CONFIG_SERIAL gets set to "y"!
> > > > 
> > > > seeerrrriiialllll muuuusssstttt dieeeeeee kill kill kill.
> > > 
> > > No idea - you've given very little information to go on.  I doubt
> > > you're building an x86 kernel... Mind giving some clues and maybe
> > > a copy of your .config file?
> >  
> >  x86 kernel, debian default config with legacy stuff like
> > 
> >  sure.
> 
> Ok, so it _isn't_ CONFIG_SERIAL at all.  Grumble.
> 
> Anyway, CONFIG_SERIAL_8250 gets set to 'm' because:
> 
> $ find . -name 'Kconfig*' | xargs grep 'select SERIAL_8250' -B5
> ./drivers/char/Kconfig-source "drivers/char/pcmcia/Kconfig"
> ./drivers/char/Kconfig-
> ./drivers/char/Kconfig-config MWAVE
> ./drivers/char/Kconfig- tristate "ACP Modem (Mwave) support"
> ./drivers/char/Kconfig- depends on X86
> ./drivers/char/Kconfig: select SERIAL_8250
> 
> and you have CONFIG_MWAVE is set to 'm'.  

 oh, do i?  looovely, what's one of those when it's at home?

 it would appear that the "select ..." thing is what's causing the
 nightmares: it forces options to be enabled without informing the user,
 and without the user being able to do it the other way round:
 say "i don't want CONFIG_SERIAL_8250 and therefore any option depending
 on it can bugger off".

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

