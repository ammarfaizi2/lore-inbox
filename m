Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030633AbWFOREM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030633AbWFOREM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 13:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030648AbWFOREM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 13:04:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1555 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030633AbWFOREK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 13:04:10 -0400
Date: Thu, 15 Jun 2006 18:04:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, sdhci-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] PATCH: Fix 32bitism in SDHCI
Message-ID: <20060615170403.GB8694@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, sdhci-devel@list.drzeus.cx,
	linux-kernel@vger.kernel.org
References: <1150385605.3490.85.camel@localhost.localdomain> <449191EE.2090309@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449191EE.2090309@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 06:59:26PM +0200, Pierre Ossman wrote:
> Alan Cox wrote:
> > The data field is ulong, pointers fit in ulongs. Casting them to int is
> > bad for 64bit systems.
> 
> It's in my (rather large) queue. I'm just waiting for a merge window. :)

I didn't see the original message, but I suspect this is about the
following, which you can see is already queued up for Linus.

# Base git commit: 0e838b72d54ed189033939258a961f2a0cd59647
#	(Merge branch 'upstream-linus' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev)
#
# Author:    Andrew Morton (Mon Jun 12 22:10:22 BST 2006)
# Committer: Russell King (Mon Jun 12 22:10:22 BST 2006)
#	
#	[MMC] sdhci truncated pointer fix
#	
#	On 64-bit machines, we just lost the uppermost 32 bits.
#	
#	Signed-off-by: Andrew Morton
#	Signed-off-by: Russell King
#
#	 drivers/mmc/sdhci.c |    2 +-
#	 1 files changed, 1 insertions(+), 1 deletions(-)
#
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -1073,7 +1073,7 @@ static int __devinit sdhci_probe_slot(st
 	tasklet_init(&host->finish_tasklet,
 		sdhci_tasklet_finish, (unsigned long)host);
 
-	setup_timer(&host->timer, sdhci_timeout_timer, (int)host);
+	setup_timer(&host->timer, sdhci_timeout_timer, (long)host);
 
 	ret = request_irq(host->irq, sdhci_irq, SA_SHIRQ,
 		host->slot_descr, host);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
