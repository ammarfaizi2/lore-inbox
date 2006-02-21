Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWBUVwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWBUVwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWBUVwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:52:34 -0500
Received: from linuxhacker.ru ([217.76.32.60]:44992 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S932261AbWBUVwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:52:34 -0500
Date: Tue, 21 Feb 2006 23:53:40 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, trond.myklebust@fys.uio.no
Subject: [PATCH] Add lookup_instantiate_filp usage warning
Message-ID: <20060221215340.GA5091@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    I think it would be nice to put an usage warning in header of
    lookup_instantiate_filp() to indicate it is unsafe to use it on
    anything but regular files (even that is potentially unsafe, but there
    your ->open() is usually in your hands anyway), so that others won't
    fall into the same trap I did.

Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>

--- linux-2.6.16-rc4/fs/open.c.orig	2006-02-21 23:34:42.000000000 +0200
+++ linux-2.6.16-rc4/fs/open.c	2006-02-21 23:44:20.000000000 +0200
@@ -890,6 +890,10 @@ EXPORT_SYMBOL(filp_open);
  * a fully instantiated struct file to the caller.
  * This function is meant to be called from within a filesystem's
  * lookup method.
+ * Beware of calling it for non-regular files! Those ->open methods might block
+ * (e.g. in fifo_open), leaving you with parent locked (and in case of fifo,
+ * leading to a deadlock, as nobody can open that fifo anymore, because
+ * another process to open fifo will block on locked parent when doing lookup).
  * Note that in case of error, nd->intent.open.file is destroyed, but the
  * path information remains valid.
  * If the open callback is set to NULL, then the standard f_op->open()
