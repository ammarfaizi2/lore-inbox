Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVGZKy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVGZKy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVGZKwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:52:45 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:14999 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261694AbVGZKvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:51:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (0/2)
Date: Tue, 26 Jul 2005 12:47:05 +0200
User-Agent: KMail/1.8.1
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507261247.05684.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following two patches are necessary to prevent my box (Asus L5D) from
hanging solid during resume from disk.

The problem is that, apparently, some out-of-order interrupts may be
generated during resume and if some drivers do not call free_irq() on
suspend, these interrupts are mishandled.  For reference please see
http://bugzilla.kernel.org/show_bug.cgi?id=4416
and
http://sourceforge.net/mailarchive/message.php?msg_id=12448907

The first patch adds free_irq() and request_irq() to the suspend and resume
routines, respectively, in the snd_intel8x0 driver.

The second one adds basic suspend/resume support to the sk98lin driver.

Please consider for applying,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

