Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270983AbTGVSHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270984AbTGVSHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:07:12 -0400
Received: from gandalph.mad.hu ([193.225.158.7]:6410 "EHLO gandalph.mad.hu")
	by vger.kernel.org with ESMTP id S270983AbTGVSHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:07:10 -0400
Date: Tue, 22 Jul 2003 20:22:54 +0200
From: Gergely Nagy <algernon@bonehunter.rulez.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.0-test1 on PPC
Message-ID: <20030722182254.GA15636@gandalph.mad.hu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've tried to compile linux 2.6.0-test1 on ppc, and so far, ran into two
easily fixable problems: first, in arch/ppc/kernel/time.c
do_settimeofday has new_sec and new_nsec defined twice. When I removed
one of the definitions (I chose to remove the ones that were not
explictly initialised). Then drivers/ide/ppc/pmac.c failed to compile,
due to a missing ide_dma_intr and others. I looked into
includes/linux/ide.h, and noticed that these are only defined if
CONFIG_BLK_DEV_IDE_DMA_PCI is defined, and my config didn't have that,
only CONFIG_BLK_DEV_IDE_DMA_PPC. So - as a quick and rude solution - I
changed the ifdef in ide.h, which is probably the wrong solution.

The kernel is still compiling, but I don't expect other failures.. If
anyone wants a patch for the above two trivial thingies, or has a
pointer to a ppc tree that is likely to be more up-to-date, please shout
:)

Cheers,
-- 
Gergely Nagy
