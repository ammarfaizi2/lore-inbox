Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWFSSFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWFSSFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWFSSFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:05:15 -0400
Received: from xenotime.net ([66.160.160.81]:44450 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751130AbWFSSFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:05:13 -0400
Date: Mon, 19 Jun 2006 11:07:56 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: tali@admingilde.org, akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc: don't use XML escapes in text or man output
 mode
Message-Id: <20060619110756.d0f7e6fa.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

For kernel-doc output modes of text and man, do not use XML escapes
for less-than, greater-than, and ampersand characters.  I.e., leave
the text and man output clean and readable.


Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/kernel-doc |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2617-pv.orig/scripts/kernel-doc
+++ linux-2617-pv/scripts/kernel-doc
@@ -1673,6 +1673,9 @@ sub process_state3_type($$) {
 # replace <, >, and &
 sub xml_escape($) {
 	my $text = shift;
+	if (($output_mode eq "text") || ($output_mode eq "man")) {
+		return $text;
+	}
 	$text =~ s/\&/\\\\\\amp;/g;
 	$text =~ s/\</\\\\\\lt;/g;
 	$text =~ s/\>/\\\\\\gt;/g;


---
