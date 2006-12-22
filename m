Return-Path: <linux-kernel-owner+w=401wt.eu-S1753176AbWLVWuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbWLVWuk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 17:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbWLVWuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 17:50:40 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:41708 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbWLVWuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 17:50:39 -0500
Message-id: <2548619677109123490@wsc.cz>
Subject: [PATCH 1/3] Char: mxser, fix oops when removing opened
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <osv@javad.com>
Date: Fri, 22 Dec 2006 23:50:50 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser, fix oops when removing opened

tty_driver->owner is not set, so if somebody remove mxser_module, it might
oops (and doesn't tell the user: no way, it's in use). Set the .owner value.

Cc: <osv@javad.com>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit e3a36e41f423af467a95221598fd5754a8fb4032
tree b78cc8a59cb41f27781d115e285c447cf913a889
parent 5df5a993999b94d728cedfa669eba2b0b58e16d7
author Jiri Slaby <jirislaby@gmail.com> Fri, 22 Dec 2006 22:48:24 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 22 Dec 2006 22:48:24 +0059

 drivers/char/mxser.c     |    1 +
 drivers/char/mxser_new.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
index c063359..83f604b 100644
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -717,6 +717,7 @@ static int mxser_init(void)
 
 	/* Initialize the tty_driver structure */
 	memset(mxvar_sdriver, 0, sizeof(struct tty_driver));
+	mxvar_sdriver->owner = THIS_MODULE;
 	mxvar_sdriver->magic = TTY_DRIVER_MAGIC;
 	mxvar_sdriver->name = "ttyMI";
 	mxvar_sdriver->major = ttymajor;
diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index cd989dc..1bb030b 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2690,6 +2690,7 @@ static int __init mxser_module_init(void)
 		MXSER_VERSION);
 
 	/* Initialize the tty_driver structure */
+	mxvar_sdriver->owner = THIS_MODULE;
 	mxvar_sdriver->magic = TTY_DRIVER_MAGIC;
 	mxvar_sdriver->name = "ttyMI";
 	mxvar_sdriver->major = ttymajor;
