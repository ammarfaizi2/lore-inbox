Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWIEIOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWIEIOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 04:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWIEIOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 04:14:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46498 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932178AbWIEIOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 04:14:42 -0400
Date: Tue, 5 Sep 2006 10:14:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: bcollins@debian.org, scjody@modernduck.com,
       linux1394-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: set power state of firewire host during suspend
Message-ID: <20060905081426.GA4105@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Put firewire host controller in PCI Dx state for system suspend.
(I was not able to measure any power savings, but it sounds like right
thing to do, anyway.)

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 099774f95904ca16463b9383d812d20621553555
tree 9173983914ccf142ce948dc03f7ae493b489c28f
parent c0aceb8cda90a681ee8028e22b45c00e98b7c33c
author <pavel@amd.ucw.cz> Tue, 05 Sep 2006 10:13:37 +0200
committer <pavel@amd.ucw.cz> Tue, 05 Sep 2006 10:13:37 +0200

 drivers/ieee1394/ohci1394.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
index 448df27..12b6dfa 100644
--- a/drivers/ieee1394/ohci1394.c
+++ b/drivers/ieee1394/ohci1394.c
@@ -3565,6 +3565,7 @@ static int ohci1394_pci_suspend (struct 
 	}
 #endif
 
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	return 0;
 }
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
