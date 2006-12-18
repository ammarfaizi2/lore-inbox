Return-Path: <linux-kernel-owner+w=401wt.eu-S1754477AbWLRToH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbWLRToH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbWLRToH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:44:07 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:52878 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477AbWLRToF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:44:05 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 14:38:47 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Adrian Bunk <bunk@stusta.de>
cc: zippel@linux-m68k.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] kconfig: remove the unused "requires" syntax
In-Reply-To: <20061218193111.GH10316@stusta.de>
Message-ID: <Pine.LNX.4.64.0612181432140.5909@localhost.localdomain>
References: <Pine.LNX.4.64.0612181138360.27491@localhost.localdomain>
 <20061218180447.GF10316@stusta.de> <Pine.LNX.4.64.0612181341090.28308@localhost.localdomain>
 <20061218193111.GH10316@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006, Adrian Bunk wrote:

> On Mon, Dec 18, 2006 at 01:46:27PM -0500, Robert P. J. Day wrote:

> > p.s.  i didn't look closely enough to see if your patch took out
> > support for both "depends" *and* "requires".  at this point,
> > neither of those are necessary anymore -- it's all "depends on"
> > except for three remaining Kconfig files.
>
> It takes out only "requires" (as the patch description says).

which makes perfect sense, of course.

> Whether to remove the plain "depends" (opposed to "depends on") is a
> different (and perhaps more controversial) question, but it should
> anyway not happen before the last usage is removed.

agreed on that last point.  my patch submission to change "depends" to
"depends on" globally *did* get applied recently:


commit 775ba7ad491a154f99871fe603f03366e84ae159
Merge: d940505... 18b36c7...
Author: Linus Torvalds <torvalds@woody.osdl.org>
Date:   Tue Dec 12 18:51:51 2006 -0800

    Merge git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial

    * git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial:
      ...
      kconfig: Standardize "depends" -> "depends on" in Kconfig files
      ...

so it's clear that that transformation was approved.  now we just wait
for the patch to deal with the last three files to go through and
we're all set.

$ grep "depends" $(find . -name Kconfig) | grep -v "depends on"
./arch/arm/mm/Kconfig:  depends !MMU && CPU_CP15 && !CPU_ARM740T
./arch/arm/Kconfig:     depends CPU_XSCALE || CPU_XSC3
./arch/v850/Kconfig:      depends !V850E2_SIM85E2C


rday
