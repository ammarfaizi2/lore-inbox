Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161657AbWAMDTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161657AbWAMDTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161651AbWAMDTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:19:22 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43139 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161650AbWAMDTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:20 -0500
Message-Id: <20060113032248.205414000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:53 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Alan Cox <alan@redhat.com>
Subject: [PATCH 15/17] [PATCH] moxa serial: add proper capability check
Content-Disposition: inline; filename=moxa-serial-add-proper-capability-check.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This requires the proper capabilities for the moxa bios update ioctl's.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/char/moxa.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.15.y.orig/drivers/char/moxa.c
+++ linux-2.6.15.y/drivers/char/moxa.c
@@ -1661,6 +1661,8 @@ int MoxaDriverIoctl(unsigned int cmd, un
 	case MOXA_FIND_BOARD:
 	case MOXA_LOAD_C320B:
 	case MOXA_LOAD_CODE:
+		if (!capable(CAP_SYS_RAWIO))
+			return -EPERM;
 		break;
 	}
 

--
