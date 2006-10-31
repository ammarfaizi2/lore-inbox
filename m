Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161490AbWJaAg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161490AbWJaAg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161492AbWJaAg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:36:26 -0500
Received: from mx0.karneval.cz ([81.27.192.122]:39976 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1161490AbWJaAgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:36:25 -0500
Message-id: <1930913791828827916@karneval.cz>
Subject: [PATCH 1/1] Char: isicom, fix tty index check
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Tue, 31 Oct 2006 01:36:22 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, fix tty index check

Since tty->index is signed and may be < 0, we should assign this to int not
uint. There is already a check to ensure if it is not negative, but
gcc complains with -W flag enabled and it is perfectly correct:
drivers/char/isicom.c:953: warning: comparison of unsigned expression < 0
is always false
Fix this issue by converting `line' variable from uint to int.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit d78c239943b72de4f541fcbe178569a78642110e
tree 6ab760f3466acc3f3ef941d18687315d9e75add2
parent d5f297a8d4df43d1d2a5f6146ed2f72a11832abe
author Jiri Slaby <jirislaby@gmail.com> Mon, 30 Oct 2006 14:29:32 +0100
committer Jiri Slaby <jirislaby@gmail.com> Mon, 30 Oct 2006 14:29:32 +0100

 drivers/char/isicom.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 9a61d0c..18a3a40 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -946,8 +946,8 @@ static int isicom_open(struct tty_struct
 {
 	struct isi_port *port;
 	struct isi_board *card;
-	unsigned int line, board;
-	int error;
+	unsigned int board;
+	int error, line;
 
 	line = tty->index;
 	if (line < 0 || line > PORT_COUNT-1)
