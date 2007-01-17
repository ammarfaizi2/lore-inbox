Return-Path: <linux-kernel-owner+w=401wt.eu-S932548AbXAQQ5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbXAQQ5i (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbXAQQ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:57:38 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:59328 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548AbXAQQ5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:57:37 -0500
X-Originating-Ip: 74.109.98.130
Date: Wed, 17 Jan 2007 11:51:27 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: "obsolete" versus "deprecated", and a new config option?
Message-ID: <Pine.LNX.4.64.0701171134440.1878@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.723, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, TW_EV 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  a couple random thoughts on the notion of obsolescence and
deprecation.

  first, there are places in the kernel (primarily Kconfig files) and
the documentation that unnecessarily conflate these two properties.
as a simple example, consider drivers/pcmcia/Kconfig:
==========================================================
config PCMCIA_IOCTL
        bool "PCMCIA control ioctl (obsolete)"
        depends on PCMCIA
        default y
        help
          If you say Y here, the deprecated ioctl interface to the PCMCIA
          subsystem will be built. It is needed by cardmgr and cardctl
          (pcmcia-cs) to function properly.

          You should use the new pcmciautils package instead (see
          <file:Documentation/Changes> for location and details).

          If unsure, say Y.
==========================================================

  so is that ioctl obsolete or deprecated?  those aren't the same
things, a good distinction being drawn here by someone discussing
devfs:

http://kerneltrap.org/node/1893

"Devfs is deprecated.  This means it's still available but you should
consider moving to other options when available.  Obsolete means it
shouldn't be used.  Some 2.6 docs have confused these two terms WRT
devfs."

  yes, and that confusion continues to this day, when a single feature
is described as both deprecated and obsolete.  not good.  (also, i'm
guessing that anything that's "obsolete" might deserve a default of
"n" rather than "y", but that's just me.  :-)

  in any event, what about introducing a new config variable,
OBSOLETE, under "Code maturity level options"?  this would seem to be
a quick and dirty way to prune anything that is *supposed* to be
obsolete from the build, to make sure you're not picking up dead code
by accident.

  i think it would be useful to be able to make that kind of
distinction since, as the devfs writer pointed out above, the point of
labelling something "obsolete" is not to *discourage* someone from
using a feature, it's to imply that they *shouldn't* be using that
feature.  period.  which suggests there should be an easy, one-step
way to enforce that absolutely in a build.

  thoughts?

rday





