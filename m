Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVAQWqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVAQWqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbVAQWoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:44:03 -0500
Received: from main.gmane.org ([80.91.229.2]:10437 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262933AbVAQWXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:23:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: How to detect ongoing activity on PCI/AGP?
Date: Mon, 17 Jan 2005 22:23:35 +0000 (UTC)
Message-ID: <slrncuoen7.19r.psavo@varg.dyndns.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
X-Face: $sk2zxhxVp'QPUj~kr+z:<m>#+84DO\Ab{4Hes1.P>]p=XhgsnwZM^[:"M?W#_x{W5[lu7i bqv7lOL`]5G%fH"Pgd5;+t"w)sOPDg::&T$Z9p#|xSMIb`$Udj6u14lh]imQ\z
User-Agent: slrn/0.9.8.1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
After upgrading my graphics, matrox g400 AGP to radeon rv280 AGP, I
noticed severe horizontal distortions in outputted image (parts move
randomly a pixel-or-two right or left).
I tracked it down to my use of amd76x_pm module, which supposedly
disconnects CPU's (this is 2xK7 SMP) from PCI bus. If I unload the
module or simply make it less aggressive (== effective), horizontal
distortions disappear.
Needless to say, matrox g400 hadn't these.

Similar distortions, although more visible and permanent, can be seen in
this grab from a bt878 card. These are not something new, I always
needed to remove amd76x_pm prior using the TV card.
<http://varg.dyndns.org/psi/random/tvtime-output.jpg.html>
Note that these distorted lines stay that way for a long time, sometimes
over a second, so there's clearly something getting broken while
transferring data via PCI.

So I've been thinking along the lines if there was a way to detect
active transfer on PCI and not do idling thing in amd76x_pm idle(). I
took a look at various places in the kernel, but didn't find anything
that matched.

Closest thing I found was this piece from drivers/pci/pci.c:pci_disable_device
- -
        pci_read_config_word(dev, PCI_COMMAND, &pci_command);
        if (pci_command & PCI_COMMAND_MASTER) {
- -

dev would likely to be northbridge, but would this work? Is there some
other Right(tm) way to do this?

Thanks,
-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

