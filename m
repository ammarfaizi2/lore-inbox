Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935793AbWK1KGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935793AbWK1KGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935796AbWK1KGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:06:48 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:28907 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S935793AbWK1KGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:06:47 -0500
X-Originating-Ip: 72.57.81.197
Date: Tue, 28 Nov 2006 05:02:41 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: mismatch between default and defconfig LOG_BUF_SHIFT values
Message-ID: <Pine.LNX.4.64.0611280451010.13481@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  not like it's a big deal, but there's a minor incongruity between
the default values for LOG_BUF_SHIFT for IA64 depending on whether
you're configuring for the first time or not.

  if i'm configuring with a fresh tree for the first time (so that
there's no .config file) and i run:

  $ make ARCH=ia64 menuconfig    (on my x86 system, just for fun)

then the initial value for LOG_BUF_SHIFT is obtained from
arch/ia64/defconfig:

  CONFIG_LOG_BUF_SHIFT=20

however, once i do that initial config, if i deselect "Kernel
debugging" and later reselect it, the new default value of 16 for that
config option comes from lib/Kconfig.debug:

...
config LOG_BUF_SHIFT
        int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
        range 12 21
        default 17 if S390 || LOCKDEP
        default 16 if X86_NUMAQ || IA64     <-- 16, not 20
...

  is it worth trying to bring the Kconfig.debug default values into
line with the defconfig file values, to avoid any possible confusion?

rday



