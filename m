Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271883AbTGYBYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 21:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271886AbTGYBYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 21:24:25 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:38811 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S271883AbTGYBYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 21:24:24 -0400
Date: Thu, 24 Jul 2003 21:29:08 -0400
From: Ben Collins <bcollins@debian.org>
To: Torrey Hoffman <thoffman@arnor.net>, gaxt <gaxt@rogers.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725012908.GT1512@phunnypharm.org>
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com> <20030725012723.GF23196@ruvolo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725012723.GF23196@ruvolo.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 06:27:24PM -0700, Chris Ruvolo wrote:
> On Thu, Jul 24, 2003 at 06:13:37PM -0700, Torrey Hoffman wrote:
> > Sometimes the driver seems to go into an loop of "unsolicted packet
> > received" messages and attempted resets.  Here's what the log looks like
> > when that happens:  (this was on 2.5.75)
> [..]
> > (this sequence repeats until I turn off or unplug the drive.)
> 
> This sounds like what happens to me when I turn on my DV cam.  CPU usage
> goes up to 40% kernel and loops like that until the device goes off.
> 
> What hardware do you have?  lspci?
> 
> Marcello's latest 2.4.22-pre8 updates to rev 1010 of the 1394 modules, so
> I'm curious if I can reproduce this in 2.4 now.

Could both you guys try this workaround? Should prove or disprove my
theory.

Index: linux-2.6/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-2.6/drivers/ieee1394/ohci1394.c	(revision 1013)
+++ linux-2.6/drivers/ieee1394/ohci1394.c	(working copy)
@@ -2366,7 +2366,7 @@
 			ohci1394_stop_context(ohci, d->ctrlClear,
 					      "respTxComplete");
 		else
-			tasklet_schedule(&d->task);
+			dma_trm_tasklet ((unsigned long)d);
 		event &= ~OHCI1394_respTxComplete;
 	}
 	if (event & OHCI1394_RQPkt) {

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
