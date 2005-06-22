Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVFVGQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVFVGQY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVFVGQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:16:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:53660 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262818AbVFVFWS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:18 -0400
Cc: se.witt@gmx.net
Subject: [PATCH] I2C: i2c-vid.h: Support for VID to reg conversion
In-Reply-To: <11194174612548@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:41 -0700
Message-Id: <1119417461270@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: i2c-vid.h: Support for VID to reg conversion

Adds conversion from VID (mV) to register value. Used by the atxp1 I2C module.
Removed uneeded switch case.

Signed-off-by: Sebastian Witt <se.witt@gmx.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3886246a257e828248ce1e72ced00408a3557f0d
tree ef1a71bf68f653b277de964d5c3156c90f21cd2f
parent 792f156d61d327671f58829dc04ad5609152e393
author Sebastian Witt <se.witt@gmx.net> Wed, 13 Apr 2005 22:25:39 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:49 -0700

 include/linux/i2c-vid.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-vid.h b/include/linux/i2c-vid.h
--- a/include/linux/i2c-vid.h
+++ b/include/linux/i2c-vid.h
@@ -97,3 +97,15 @@ static inline int vid_from_reg(int val, 
 		                     2050 - (val) * 50);
 	}
 }
+
+static inline int vid_to_reg(int val, int vrm)
+{
+	switch (vrm) {
+	case 91:		/* VRM 9.1 */
+	case 90:		/* VRM 9.0 */
+		return ((val >= 1100) && (val <= 1850) ?
+			((18499 - val * 10) / 25 + 5) / 10 : -1);
+	default:
+		return -1;
+	}
+}

