Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265941AbUFTUk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265941AbUFTUk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 16:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUFTUk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 16:40:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:64971 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265941AbUFTUkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 16:40:55 -0400
Subject: Re: Stop the Linux kernel madness
From: Andreas Gruenbacher <agruen@suse.de>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <40D5B09A.E1B582F2@users.sourceforge.net>
References: <40D232AD.4020708@opensound.com>
	 <mailman.1087541100.18231.linux-kernel2news@redhat.com>
	 <20040618124716.183669f8@lembas.zaitcev.lan>
	 <40D46B6C.9618B196@users.sourceforge.net>
	 <20040619205253.GO28927@marowsky-bree.de>
	 <40D5B09A.E1B582F2@users.sourceforge.net>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1087764291.19400.134.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 20 Jun 2004 22:44:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-20 at 17:43, Jari Ruusu wrote:
> Lars Marowsky-Bree wrote:
> > On 2004-06-19T19:35:56,
> >    Jari Ruusu <jariruusu@users.sourceforge.net> said:
> > > Last time I checked, SUSE kernels include " characters in EXTRAVERSION
> > > and KERNELRELEASE Makefile strings. Those " characters need to be
> > > filtered out before EXTRAVERSION and KERNELRELEASE strings can be
> > > used.
> > >
> > > Just another SUSE sillyness.
> > 
> > What kind of crap 've you been smokin'? Sue your dealer.
> 
> First 6 lines of Kernel Makefile (SuSE 8 ES on AMD64 Opteron):
> 
> VERSION = 2
> PATCHLEVEL = 4
> SUBLEVEL = 21
> EXTRAVERSION = -$(CONFIG_RELEASE)-$(CONFIG_CFGNAME)

Indeed, that was a bug. In our current tree we have this, which gets rid
of the superfluous quotes:

EXTRAVERSION = -$(shell echo $(CONFIG_RELEASE)-$(CONFIG_CFGNAME))

> KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
> 
> 
> Last 7 lines of .config (SuSE 8 ES on AMD64 Opteron):
> 
> #
> # Build options
> #
> # CONFIG_SUSE_KERNEL is not set
> CONFIG_UNITEDLINUX_KERNEL=y
> CONFIG_CFGNAME="smp"
> CONFIG_RELEASE=207
> 
> 
> Those " characters around "smp" will not go away automatically.
> To see the difference try these lines in Makefile:
> 
>     echo $(KERNELRELEASE)
>     echo '$(KERNELRELEASE)'

Well, it depends in which context you use the string, which is why we
didn't catch the bug for a long time. I agree that the quotes shouldn't
be there. Mistakes happen.

> Those " characters make quite difference in Makefile code like this:
> 
> ifneq ($(KERNELRELEASE),$(shell uname -r))
>     @echo You compiled this for wrong kernel
> endif

This test may often turn out not to be very useful: For example, we are
building modules for different kernels without booting into each of
those kernels. Cross-compiling is another case where the above test
doesn't work.


Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG


