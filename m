Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWEPIgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWEPIgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 04:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWEPIgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 04:36:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:23496 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751682AbWEPIgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 04:36:12 -0400
X-Authenticated: #704063
Date: Tue, 16 May 2006 10:36:06 +0200
From: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [Patch] Overrun in isdn_tty.c
Message-ID: <20060516083606.GB15781@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snake-basket.de
X-Operating-System: Linux/2.6.17-rc4 (i686)
X-Uptime: 10:34:02 up  1:27,  5 users,  load average: 0.45, 0.47, 0.60
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity bug id #1237. After the while loop,
it is possible for i == ISDN_LMSNLEN. If this happens
the terminating '\0' is written after the end of the array.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>


--- linux-2.6.17-rc4-git2/drivers/isdn/i4l/isdn_tty.c.orig	2006-05-16 10:27:29.000000000 +0200
+++ linux-2.6.17-rc4-git2/drivers/isdn/i4l/isdn_tty.c	2006-05-16 10:27:50.000000000 +0200
@@ -2880,7 +2880,7 @@ isdn_tty_cmd_ATand(char **p, modem_info 
 			p[0]++;
 			i = 0;
 			while (*p[0] && (strchr("0123456789,-*[]?;", *p[0])) &&
-			       (i < ISDN_LMSNLEN))
+			       (i < ISDN_LMSNLEN - 1))
 				m->lmsn[i++] = *p[0]++;
 			m->lmsn[i] = '\0';
 			break;

