Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWDFU6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWDFU6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 16:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWDFU6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 16:58:37 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:15464 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751275AbWDFU6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 16:58:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=gbmCgaQtBGy3XHeHUCFw+gWnT5UWKpSvz1YqKdruBepR3kmzvJopdJMJjRIjphIWYP20zAAonafbNCqKzK0EUlGAkFMV2J8uevoMrQYjcxLL1JtkkpLlxdPS6oPSvH7dTsjUDApwbZYxQJcsFATD3aFlDxvPqTYs3SPbCZpWOZs=
Message-ID: <4b73d43f0604061358v1c619e21rc6f3af2cdc4545a3@mail.gmail.com>
Date: Thu, 6 Apr 2006 14:58:34 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Roman Zippel" <zippel@linux-m68k.org>
Subject: [PATCH] Allow menuconfig to cycle through choices
Cc: "Sam Ravnborg" <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4b73d43f0604061339n35a4d98ha08bf8d7fc0bef0b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_28581_26538231.1144357114180"
References: <4b73d43f0604061338i1c5315f1t34761380b620fc57@mail.gmail.com>
	 <4b73d43f0604061339n35a4d98ha08bf8d7fc0bef0b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_28581_26538231.1144357114180
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



------=_Part_28581_26538231.1144357114180
Content-Type: text/plain; 
	name=0001-Allow-menuconfig-to-cycle-through-choices.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_elpjydot
Content-Disposition: attachment; filename="0001-Allow-menuconfig-to-cycle-through-choices.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: John Rigby <jrigby@freescale.com>
Date: Thu Apr 6 14:25:19 2006 -0600
Subject: [PATCH] Allow menuconfig to cycle through choices

Added cycling logic to dialog_checklist identical to what
dialog_menu already has.

Signed-off-by: John Rigby <jrigby@freescale.com>

---

 scripts/kconfig/lxdialog/checklist.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

8c5500ea727987ea35a7ccaa463dcaf50eb731b2
diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index db07ae7..af41cb1 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -203,10 +203,15 @@ int dialog_checklist(const char *title, 
 	while (key != ESC) {
 		key = wgetch(dialog);
 
-		for (i = 0; i < max_choice; i++)
+		for (i = choice + 1; i < max_choice; i++)
 			if (toupper(key) ==
 			    toupper(items[(scroll + i) * 3 + 1][0]))
 				break;
+		if (i == max_choice)
+			for (i = 0; i < max_choice; i++)
+			    if (toupper(key) ==
+				toupper(items[(scroll + i) * 3 + 1][0]))
+				    break;
 
 		if (i < max_choice || key == KEY_UP || key == KEY_DOWN ||
 		    key == '+' || key == '-') {
-- 
1.2.4





------=_Part_28581_26538231.1144357114180--
