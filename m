Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTDURqs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbTDURqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:46:48 -0400
Received: from verein.lst.de ([212.34.181.86]:14096 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261804AbTDURqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:46:46 -0400
Date: Mon, 21 Apr 2003 19:58:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
Message-ID: <20030421195847.A28684@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com> <20030421195555.A28583@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030421195555.A28583@lst.de>; from hch@lst.de on Mon, Apr 21, 2003 at 07:55:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 07:55:55PM +0200, Christoph Hellwig wrote:
> Could you please try this patch?

Better this one :)  Sorry.

--- 1.11/drivers/char/pty.c	Mon Mar 31 03:16:19 2003
+++ edited/drivers/char/pty.c	Mon Apr 21 18:37:00 2003
@@ -448,17 +448,14 @@
 			init_waitqueue_head(&ptm_state[i][j].open_wait);
 		
 		pts_driver[i] = pty_slave_driver;
-#ifdef CONFIG_DEVFS_FS
-		pts_driver[i].name = "pts/%d";
-#else
 		pts_driver[i].name = "pts";
-#endif
 		pts_driver[i].proc_entry = 0;
 		pts_driver[i].major = UNIX98_PTY_SLAVE_MAJOR+i;
 		pts_driver[i].minor_start = 0;
 		pts_driver[i].name_base = i*NR_PTYS;
 		pts_driver[i].num = ptm_driver[i].num;
 		pts_driver[i].other = &ptm_driver[i];
+		pts_driver[i].flags |= TTY_DRIVER_NO_DEVFS;
 		pts_driver[i].table = pts_table[i];
 		pts_driver[i].termios = pts_termios[i];
 		pts_driver[i].termios_locked = pts_termios_locked[i];
