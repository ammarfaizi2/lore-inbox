Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265493AbUFTPlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUFTPlz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 11:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265574AbUFTPlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 11:41:55 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:34253 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S265493AbUFTPlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 11:41:52 -0400
Message-ID: <40D5B09A.E1B582F2@users.sourceforge.net>
Date: Sun, 20 Jun 2004 18:43:22 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <mailman.1087541100.18231.linux-kernel2news@redhat.com> <20040618124716.183669f8@lembas.zaitcev.lan> <40D46B6C.9618B196@users.sourceforge.net> <20040619205253.GO28927@marowsky-bree.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:
> On 2004-06-19T19:35:56,
>    Jari Ruusu <jariruusu@users.sourceforge.net> said:
> > Last time I checked, SUSE kernels include " characters in EXTRAVERSION
> > and KERNELRELEASE Makefile strings. Those " characters need to be
> > filtered out before EXTRAVERSION and KERNELRELEASE strings can be
> > used.
> >
> > Just another SUSE sillyness.
> 
> What kind of crap 've you been smokin'? Sue your dealer.

First 6 lines of Kernel Makefile (SuSE 8 ES on AMD64 Opteron):

VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 21
EXTRAVERSION = -$(CONFIG_RELEASE)-$(CONFIG_CFGNAME)

KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)


Last 7 lines of .config (SuSE 8 ES on AMD64 Opteron):

#
# Build options
#
# CONFIG_SUSE_KERNEL is not set
CONFIG_UNITEDLINUX_KERNEL=y
CONFIG_CFGNAME="smp"
CONFIG_RELEASE=207


Those " characters around "smp" will not go away automatically.
To see the difference try these lines in Makefile:

    echo $(KERNELRELEASE)
    echo '$(KERNELRELEASE)'

Those " characters make quite difference in Makefile code like this:

ifneq ($(KERNELRELEASE),$(shell uname -r))
    @echo You compiled this for wrong kernel
endif

You seem to use SUSE email address, so maybe _you_ should be answering this
question: What kind of crap 've you been smokin'?

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
