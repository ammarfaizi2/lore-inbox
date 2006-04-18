Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWDRRrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWDRRrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 13:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWDRRrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 13:47:45 -0400
Received: from iona.labri.fr ([147.210.8.143]:21436 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932213AbWDRRro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 13:47:44 -0400
Date: Tue, 18 Apr 2006 19:47:28 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Enhancing accessibility of lxdialog
Message-ID: <20060418174728.GA4407@implementation>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20060412002125.GG5491@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060412002125.GG5491@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some fix that I forgot for good accessibility of lxdialog (the cursor
should always be left at the focus location):


Have the checklist display the currently highlighted entry last, for
having the cursor left on it (rather than on the last line of the list).

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index be0200e..7988641 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -187,9 +187,12 @@ int dialog_checklist(const char *title, 
 
 	/* Print the list */
 	for (i = 0; i < max_choice; i++) {
-		print_item(list, items[(scroll + i) * 3 + 1],
-			   status[i + scroll], i, i == choice);
+		if (i != choice)
+			print_item(list, items[(scroll + i) * 3 + 1],
+				   status[i + scroll], i, 0);
 	}
+	print_item(list, items[(scroll + choice) * 3 + 1],
+		   status[choice + scroll], choice, 1);
 
 	print_arrows(dialog, choice, item_no, scroll,
 		     box_y, box_x + check_x + 5, list_height);
