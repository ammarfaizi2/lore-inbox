Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTJDQrf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 12:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTJDQrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 12:47:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:4510 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262761AbTJDQrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 12:47:33 -0400
Date: Sat, 4 Oct 2003 09:49:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rhino <rhino9@terra.com.br>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: Re: 2.6.0-test6-mm3
Message-Id: <20031004094913.77d878ec.akpm@osdl.org>
In-Reply-To: <20031004105227.7e63240c.rhino9@terra.com.br>
References: <20031004021255.3fefbacb.akpm@osdl.org>
	<20031004105227.7e63240c.rhino9@terra.com.br>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rhino <rhino9@terra.com.br> wrote:
>
> got these endless messages :
> 
>  pid 4220 pgrp 4220 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
>  pid 4221 pgrp 4220 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
>  pid 4219 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0

I don't know why that was added actually; maybe it is just left-over
debugging code. 

 drivers/char/tty_io.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff -puN drivers/char/tty_io.c~job-control-remove-debug drivers/char/tty_io.c
--- 25/drivers/char/tty_io.c~job-control-remove-debug	2003-10-04 09:46:56.000000000 -0700
+++ 25-akpm/drivers/char/tty_io.c	2003-10-04 09:47:21.000000000 -0700
@@ -1591,22 +1591,13 @@ static int tiocspgrp(struct tty_struct *
 	pid_t pgrp;
 	int retval = tty_check_change(real_tty);
 
-	if (retval == -EIO) {
-		printk(KERN_WARNING "pid %d pgrp %d tty_check_change EIO\n",
-			current->pid, current->signal->pgrp);
+	if (retval == -EIO)
 		return -ENOTTY;
-	}
 	if (retval)
 		return retval;
 	if (!process_tty(current) || (process_tty(current) != real_tty) ||
-			(real_tty->session != process_session(current))) {
-		printk(KERN_WARNING "pid %d pgrp %d sid %d tty %p "
-				"ENOTTY vs tty %p sid %d\n",
-			current->pid, process_group(current),
-			process_session(current), process_tty(current),
-			real_tty, real_tty->session);
+			(real_tty->session != process_session(current)))
 		return -ENOTTY;
-	}
 	if (get_user(pgrp, (pid_t *) arg))
 		return -EFAULT;
 	if (pgrp < 0)

_
 
