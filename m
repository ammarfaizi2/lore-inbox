Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWDDDP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWDDDP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 23:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWDDDP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 23:15:58 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:3501 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S964986AbWDDDP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 23:15:57 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 3 Apr 2006 20:15:45 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <mtk-manpages@gmx.net>,
       michael.kerrisk@gmx.net
Subject: [patch] uniform POLLRDHUP handling between epoll and poll/select
 ...
Message-ID: <Pine.LNX.4.64.0604032011040.30048@alien.or.mcafeemobile.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Like reported by Michael Kerrisk, POLLRDHUP handling was not consistent 
between epoll and poll/select, since in epoll it was unmaskeable. This 
patch brings uniformity in POLLRDHUP handling.



Signed-off-by: Davide Libenzi <davidel@xmailserver.org>


- Davide



diff -Nru linux-2.6.16/fs/eventpoll.c linux-2.6.16.mod/fs/eventpoll.c
--- linux-2.6.16/fs/eventpoll.c	2006-04-03 20:08:23.000000000 -0700
+++ linux-2.6.16.mod/fs/eventpoll.c	2006-04-03 20:09:51.000000000 -0700
@@ -599,7 +599,7 @@
  	switch (op) {
  	case EPOLL_CTL_ADD:
  		if (!epi) {
-			epds.events |= POLLERR | POLLHUP | POLLRDHUP;
+			epds.events |= POLLERR | POLLHUP;

  			error = ep_insert(ep, &epds, tfile, fd);
  		} else
@@ -613,7 +613,7 @@
  		break;
  	case EPOLL_CTL_MOD:
  		if (epi) {
-			epds.events |= POLLERR | POLLHUP | POLLRDHUP;
+			epds.events |= POLLERR | POLLHUP;
  			error = ep_modify(ep, epi, &epds);
  		} else
  			error = -ENOENT;
