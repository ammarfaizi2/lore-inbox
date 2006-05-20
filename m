Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWETEpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWETEpS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 00:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWETEpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 00:45:18 -0400
Received: from xenotime.net ([66.160.160.81]:24283 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751104AbWETEpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 00:45:17 -0400
Date: Fri, 19 May 2006 21:47:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: tali@admingilde.org, akpm <akpm@osdl.org>
Subject: [PATCH 1/2] kernel-doc: drop leading space in sections
Message-Id: <20060519214747.3d1be1d2.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Drop leading space of kernel-doc section contents.

"Section" data (contents) are split from the section header
(e.g., Note: below is a section header:
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
).
Currently the data/contents begins with a space and is left
that way, which causes it to look bad when printed (in text mode;
see example below), so just remove the leading space.

Note:

 list_empty on entry does not return true after this, the entry is
in an undefined state.


Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/kernel-doc |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2617-rc4.orig/scripts/kernel-doc
+++ linux-2617-rc4/scripts/kernel-doc
@@ -1762,6 +1762,9 @@ sub process_file($) {
 
 		$contents = $newcontents;
 		if ($contents ne "") {
+		    if (substr($contents, 0, 1) eq " ") {
+			$contents = substr($contents, 1);
+		    }
 		    $contents .= "\n";
 		}
 		$section = $newsection;


---
