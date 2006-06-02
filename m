Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWFBTsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWFBTsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWFBTqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:46:40 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:3200 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751465AbWFBTqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:21 -0400
Message-Id: <20060602194739.825347000@sous-sol.org>
References: <20060602194618.482948000@sous-sol.org>
Date: Fri, 02 Jun 2006 00:00:05 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Dmitry Torokhov <dtor@mail.ru>, Daniel Drake <dsd@gentoo.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/11] Input: psmouse - fix new device detection logic
Content-Disposition: inline; filename=input-psmouse-fix-new-device-detection-logic.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Dmitry Torokhov <dtor_core@ameritech.net>

Reported to fix http://bugs.gentoo.org/130846

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Cc: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/input/mouse/psmouse-base.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.16.19.orig/drivers/input/mouse/psmouse-base.c
+++ linux-2.6.16.19/drivers/input/mouse/psmouse-base.c
@@ -300,8 +300,10 @@ static irqreturn_t psmouse_interrupt(str
  * Check if this is a new device announcement (0xAA 0x00)
  */
 	if (unlikely(psmouse->packet[0] == PSMOUSE_RET_BAT && psmouse->pktcnt <= 2)) {
-		if (psmouse->pktcnt == 1)
+		if (psmouse->pktcnt == 1) {
+			psmouse->last = jiffies;
 			goto out;
+		}
 
 		if (psmouse->packet[1] == PSMOUSE_RET_ID) {
 			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);

--
