Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTE0Shv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTE0Shv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:37:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7331 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262811AbTE0Shu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:37:50 -0400
Date: Tue, 27 May 2003 19:51:04 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: ALSA problems: sound lockup, modules, 2.5.70
Message-ID: <20030527185104.GB27916@parcelfarce.linux.theplanet.co.uk>
References: <3ED3AC36.5050503@trollprod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED3AC36.5050503@trollprod.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Argh.  Missing initialization in char_dev.c - it's definitely
responsible for crap on unload.  Load side appears to be something else,
though...

--- C70/fs/char_dev.c	Mon May 26 22:21:39 2003
+++ linux/fs/char_dev.c	Tue May 27 14:48:53 2003
@@ -89,6 +89,8 @@
 	if (cd == NULL)
 		return ERR_PTR(-ENOMEM);
 
+	memset(cd, 0, sizeof(struct char_device_struct));
+
 	write_lock_irq(&chrdevs_lock);
 
 	/* temporary */
