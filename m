Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966581AbWKOEam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966581AbWKOEam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966586AbWKOEal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:30:41 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:16500 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S966581AbWKOEak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:30:40 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	<20061114.192117.112621278.davem@davemloft.net>
	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
	<455A938A.4060002@garzik.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 14 Nov 2006 20:30:36 -0800
In-Reply-To: <455A938A.4060002@garzik.org> (Jeff Garzik's message of "Tue, 14 Nov 2006 23:11:54 -0500")
Message-ID: <ada8xidz5zn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Nov 2006 04:30:36.0462 (UTC) FILETIME=[CBF53CE0:01C7086E]
Authentication-Results: sj-dkim-6; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim6002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > That reminds me of a potential driver bug -- MSI-aware drivers need to
 > call pci_intx(pdev,0) to turn off the legacy PCI interrupt, before
 > enabling MSI interrupts.

Huh?  The device can't generate any legacy interrupts once MSI is
enabled.  As the PCI spec says:

    "While enabled for MSI or MSI-X operation, a function is prohibited
    from using its INTx# pin (if implemented) to request service (MSI,
    MSI-X, and INTx# are mutually exclusive)."

Although the MSI core does do pci_intx() for PCIe devices only, for
some reason I can't grok.

 > The only thing that has changed recently is that people are trying to
 > get it working on AMD/NV as well.  (Brice Goglin's stuff starting at
 > 6397c75cbc4d7dbc3d07278b57c82a47dafb21b5 in 'git log')

Actually NVidia/AMD was working on some systems long before that -- I
had it working at least 2 years ago.

 - R.
