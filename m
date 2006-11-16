Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162266AbWKPCwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162266AbWKPCwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162261AbWKPCv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:51:26 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:7560 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162248AbWKPCrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:47:18 -0500
Message-Id: <20061116024839.150127000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:58 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, maks@sternwelten.at,
       Jiri Slaby <jirislaby@gmail.com>
Subject: [patch 26/30] Char: isicom, fix close bug
Content-Disposition: inline; filename=char-isicom-fix-close-bug.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jiri Slaby <jirislaby@gmail.com>

[PATCH] Char: isicom, fix close bug

port is dereferenced even if it is NULL.  Dereference it _after_ the
check if (!port)...  Thanks Eric <ef87@yahoo.com> for reporting this.

This fixes

	http://bugzilla.kernel.org/show_bug.cgi?id=7527

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/char/isicom.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.18.2.orig/drivers/char/isicom.c
+++ linux-2.6.18.2/drivers/char/isicom.c
@@ -1062,11 +1062,12 @@ static void isicom_shutdown_port(struct 
 static void isicom_close(struct tty_struct *tty, struct file *filp)
 {
 	struct isi_port *port = tty->driver_data;
-	struct isi_board *card = port->card;
+	struct isi_board *card;
 	unsigned long flags;
 
 	if (!port)
 		return;
+	card = port->card;
 	if (isicom_paranoia_check(port, tty->name, "isicom_close"))
 		return;
 

--
