Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbUDNAkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbUDNAkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:40:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:36023 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263836AbUDNAkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:40:07 -0400
Date: Tue, 13 Apr 2004 17:40:05 -0700
From: Chris Wright <chrisw@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: mq_open() and close_on_exec?
Message-ID: <20040413174005.Q22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SUSv3 doesn't seem to specify one way or the other.  I don't have the
POSIX specs, and the old docs I have suggest that mq_open() creates an
object which is to be closed upon exec.  Anyone have a clue if this is
actually required?  Patch below sets this as default (if indeed it's
valid/required).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== ipc/mqueue.c 1.6 vs edited =====
--- 1.6/ipc/mqueue.c	Mon Apr 12 10:54:17 2004
+++ edited/ipc/mqueue.c	Tue Apr 13 16:05:36 2004
@@ -641,6 +641,7 @@
 		goto out_putfd;
 	}
 
+	set_close_on_exec(fd, 1);
 	fd_install(fd, filp);
 	goto out_upsem;
 
