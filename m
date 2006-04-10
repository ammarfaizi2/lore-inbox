Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWDJOmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWDJOmn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 10:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWDJOmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 10:42:43 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:38344 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751183AbWDJOmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 10:42:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=AD8pihU/Gb4MGGHKdzrdpwLmuLVkdTS6G/CKcEx1fDn4Afl4M/0JYdNXr1PaGfcm3jDI8fuH8yEZ7C+yBPFTxFdDHurDF84gtf3EhweBRyBo0OuQzSOy0pirgdz7UPRcDOyuTVVMRVMZCD1BriGhuwwYkwOch6bPPMwE/9VCZ0E=
Message-ID: <4b73d43f0604100742s5b7fa0e6ge2df5e011068e4c2@mail.gmail.com>
Date: Mon, 10 Apr 2006 08:42:41 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Roman Zippel" <zippel@linux-m68k.org>
Subject: Subject: [PATCH] Allow menuconfig to hotkey cycle through choices
Cc: lkml <linux-kernel@vger.kernel.org>, "Sam Ravnborg" <sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3579_18847937.1144680161863"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3579_18847937.1144680161863
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Same patch as before now with better description added as requested by Roma=
n.

------=_Part_3579_18847937.1144680161863
Content-Type: text/plain; 
	name=0001-Allow-menuconfig-to-cycle-through-choices.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eluwxkow
Content-Disposition: attachment; filename="0001-Allow-menuconfig-to-cycle-through-choices.txt"

Subject: [PATCH] Allow menuconfig to hotkey cycle through choices

If you have multiple configs inside a choice with prompts that start with the
same character typing the first character takes you to the first one under
the old behavior.  You have to use arrow or +/- keys to go to the other choices.

With the patch typing the first character will cycle between all the
prompts starting with that character.

This behavior has always been available in normal "menus" which are handled by
dialog_menu.  This patch adds the same functionality to dialog_checklist.

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


------=_Part_3579_18847937.1144680161863--
