Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270717AbTHAKqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272498AbTHAKqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:46:21 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:56593 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S272519AbTHAKoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:44:24 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.22-pre10] SAK: If a process is killed by SAK, give us an info about which one was killed
Date: Fri, 1 Aug 2003 12:40:23 +0200
User-Agent: KMail/1.5.2
Organization: Working Overloaded Linux Kernel
MIME-Version: 1.0
Message-Id: <200307312254.16964.m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XOkK/ZicBTj+I5H"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_XOkK/ZicBTj+I5H
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

$subject says it all.

Please apply for 2.4.22-pre10. Thank you :)

ciao, Marc

--Boundary-00=_XOkK/ZicBTj+I5H
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.4-SAK-info.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4-SAK-info.patch"

--- a/drivers/char/tty_io.c	Fri Jan 25 15:49:44 2002
+++ b/drivers/char/tty_io.c	Tue Mar 19 08:28:27 2002
@@ -1888,6 +1888,9 @@
	for_each_task(p) {
		if ((p->tty == tty) ||
		    ((session > 0) && (p->session == session))) {
+				printk(KERN_NOTICE "SAK: killed process %d"
+				" (%s): p->session==tty->session\n",
+				p->pid, p->comm);
			send_sig(SIGKILL, p, 1);
			continue;
		}
@@ -1898,6 +1898,9 @@
				filp = fcheck_files(p->files, i);
				if (filp && (filp->f_op == &tty_fops) &&
				    (filp->private_data == tty)) {
+						printk(KERN_NOTICE "SAK: killed process %d"
+						" (%s): fd#%d opened to the tty\n",
+						p->pid, p->comm, i);
					send_sig(SIGKILL, p, 1);
					break;
				}

--Boundary-00=_XOkK/ZicBTj+I5H--


