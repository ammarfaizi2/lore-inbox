Return-Path: <linux-kernel-owner+w=401wt.eu-S1754506AbWL3NyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbWL3NyV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 08:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754514AbWL3NyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 08:54:21 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:60957 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbWL3NyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 08:54:20 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 30 Dec 2006 14:53:53 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [GIT PULL] ieee1394 fixes
To: Linus Torvalds <torvalds@osdl.org>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-ID: <tkrat.2268a38bd4a73f53@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from the for-linus branch at

    git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394-2.6.git for-linus

to receive two IEEE 1394 subsystem fixes for 2.6.20-rc2.
One addresses a grossly incorrect patch of mine after 2.6.19.
(Andreas Schwab 2006-12-29, "2.6.20-rc2: kernel BUG at
include/asm/dma-mapping.h:110!")

The other fixes an old minor bug which was discovered recently.
(Jeff Garzik 2006-12-05, "Re: [PATCH 3/3] Import fw-sbp2 driver.")


 drivers/ieee1394/sbp2.c |   83 +++++++++++++++++++++++------------------------
 1 files changed, 40 insertions(+), 43 deletions(-)


commit 97d552e35d9404df3254e1157df3340e4e2eaedc
Author: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date:   Fri Dec 29 23:47:04 2006 +0100

    ieee1394: sbp2: fix bogus dma mapping
    
    Need to use a PCI device, not a FireWire host device.  Problem found by
    Andreas Schwab, mistake pointed out by Benjamin Herrenschmidt.
    http://ozlabs.org/pipermail/linuxppc-dev/2006-December/029595.html
    
    Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
    Tested-by: Andreas Schwab <schwab@suse.de>

commit b2bb550c4a10c44e99fe469cfaee81e2e3109994
Author: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date:   Thu Dec 28 19:57:49 2006 +0100

    ieee1394: sbp2: pass REQUEST_SENSE through to the target
    
    Delete some incorrect code, left over from the initial driver submission
    in March 2001.
    
    SBP-2 targets should provide sense data via the SBP-2 status block
    (autosense).  We have to pass the REQUEST_SENSE command through to
    targets which don't implement autosense, if there are any, and to
    accomodate application clients which use this command.
    
    Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

-- 
Stefan Richter
-=====-=-==- ==-- ====-
http://arcgraph.de/sr/

