Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751964AbWAEGSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbWAEGSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbWAEGSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:18:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6579 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751964AbWAEGSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:18:18 -0500
Date: Thu, 5 Jan 2006 01:18:11 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: don't freeze firewire on suspend.
Message-ID: <20060105061810.GA10700@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had a report from one loony user who tried out suspend to disk
using a swap partition on a firewire drive.  As the firewire thread
was put to sleep it didn't work out too well.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/ieee1394/ieee1394_core.c~	2005-10-06 00:18:56.000000000 -0400
+++ linux-2.6/drivers/ieee1394/ieee1394_core.c	2005-10-06 00:19:21.000000000 -0400
@@ -1030,6 +1030,8 @@ static int hpsbpkt_thread(void *__hi)
 
 	daemonize("khpsbpkt");
 
+	current->flags |= PF_NOFREEZE;
+
 	while (1) {
 		if (down_interruptible(&khpsbpkt_sig)) {
 			if (try_to_freeze())
