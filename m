Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWJHLL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWJHLL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 07:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWJHLL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 07:11:27 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:57996 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751083AbWJHLL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 07:11:27 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 8 Oct 2006 13:10:27 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [GIT PULL] ieee1394 update (was 2.6.19-rc1: known regressions (v2))
To: Linus Torvalds <torvalds@osdl.org>
cc: Adrian Bunk <bunk@stusta.de>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20061007214620.GB8810@stusta.de>
Message-ID: <tkrat.6f789c8fb76aa7c3@s5r6.in-berlin.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
 <20061007214620.GB8810@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18
> that are not yet fixed Linus' tree.
[...]
> Subject    : strange ieee1394 messages
> References : http://lkml.org/lkml/2006/10/5/154
> Submitter  : "Alistair John Strachan" <s0348365@sms.ed.ac.uk>
> Guilty     : Stefan Richter <stefanr@s5r6.in-berlin.de>
>              commit d2f119fe319528da8c76a1107459d6f478cbf28c
> Handled-By : Stefan Richter <stefanr@s5r6.in-berlin.de>
> Patch      : http://lkml.org/lkml/2006/10/6/235
> Status     : harmless, patch available


Linus, please pull from the upstream-linus branch at

    git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394-2.6.git upstream-linus

to receive the following patch...

Stefan Richter:
      ieee1394: nodemgr: fix startup of knodemgrd

 drivers/ieee1394/nodemgr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

...or just apply it from this mail.


Date: Fri, 6 Oct 2006 19:49:52 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: ieee1394: nodemgr: fix startup of knodemgrd

Revert a thinko in commit d2f119fe319528da8c76a1107459d6f478cbf28c:
When knodemgrd starts, it needs to sleep until host->generation was
incremented above its initial value of 0.  My wrong logic caused it to
start sending requests when the bus wasn't completely ready.  Seen as
"AT dma reset ctx=0, aborting transmission" messages in 2.6.19-rc1.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-10-06 19:20:00.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-10-06 19:26:28.000000000 +0200
@@ -1614,7 +1614,7 @@ static int nodemgr_host_thread(void *__h
 {
 	struct host_info *hi = (struct host_info *)__hi;
 	struct hpsb_host *host = hi->host;
-	unsigned int g, generation = get_hpsb_generation(host) - 1;
+	unsigned int g, generation = 0;
 	int i, reset_cycles = 0;
 
 	/* Setup our device-model entries */


