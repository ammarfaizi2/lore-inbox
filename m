Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWIFXJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWIFXJl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965286AbWIFXJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:09:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:25549 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965057AbWIFXDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:01 -0400
Date: Wed, 6 Sep 2006 15:57:21 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Duncan Sands <baldrick@free.fr>, Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 24/37] uhci-hcd: fix list access bug
Message-ID: <20060906225721.GY15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="uhci-hcd-fix-list-access-bug.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Alan Stern <stern@rowland.harvard.edu>

When skipping to the last TD of an URB, go to the _last_ entry in the
list instead of the _first_ entry (as780).  This fixes Bugzilla #6747 and
possibly others.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/host/uhci-q.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.11.orig/drivers/usb/host/uhci-q.c
+++ linux-2.6.17.11/drivers/usb/host/uhci-q.c
@@ -264,7 +264,7 @@ static void uhci_fixup_toggles(struct uh
 		 * need to change any toggles in this URB */
 		td = list_entry(urbp->td_list.next, struct uhci_td, list);
 		if (toggle > 1 || uhci_toggle(td_token(td)) == toggle) {
-			td = list_entry(urbp->td_list.next, struct uhci_td,
+			td = list_entry(urbp->td_list.prev, struct uhci_td,
 					list);
 			toggle = uhci_toggle(td_token(td)) ^ 1;
 

--
