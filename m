Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbTAXVgr>; Fri, 24 Jan 2003 16:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTAXVgr>; Fri, 24 Jan 2003 16:36:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54508 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265711AbTAXVgp>;
	Fri, 24 Jan 2003 16:36:45 -0500
Date: Fri, 24 Jan 2003 13:34:34 -0800 (PST)
Message-Id: <20030124.133434.66251483.davem@redhat.com>
To: Jeff.Wiedemeier@hp.com
Cc: jgarzik@pobox.com, ink@jurassic.park.msu.ru, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030124163341.A4366@dsnt25.mro.cpqcorp.net>
References: <20030124154635.A4161@dsnt25.mro.cpqcorp.net>
	<20030124.125121.78932406.davem@redhat.com>
	<20030124163341.A4366@dsnt25.mro.cpqcorp.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
   Date: Fri, 24 Jan 2003 16:33:41 -0500
   
   If it needs to be made a driver decision, there needs to be some way to
   communicate the correct vector information for whichever option the
   driver is using (if there already is and I missed it, please let me
   know). Otherwise, it seems that trying to match spec behavior given the
   hardware design or disabling MSI at config time for these devices (such
   as through quirks) are the options.

Right, the whole issue is that we're generally MSI ignorant in our PCI
layer right now.  And you're trying to make use of MSI on some
platform :-)

So because the driver has no way to ask the platform "are you going
to use MSI for this device?" there is no way for tg3 to portably
deal with this issue.

That being said, why don't we add "pci_using_msi(pdev)" to asm/pci.h?
Once we have that, tg3.c can then go and set the tg3 specific MSI
enable bit to match whatever pci_using_msi(pdev) returns.  This, plus
the extended state save/restore, should solve all the problems.

