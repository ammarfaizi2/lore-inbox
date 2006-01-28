Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422798AbWA1CYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbWA1CYE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWA1CXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:23:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:955 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422798AbWA1CXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:23:00 -0500
Date: Fri, 27 Jan 2006 18:21:41 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       ralf@linux-mips.org
Subject: [patch 12/12] Fix mkiss locking bug
Message-ID: <20060128022141.GM17001@kroah.com>
References: <20060128020629.908825000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-mkiss-locking-bug.patch"
In-Reply-To: <20060128022023.GA17001@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15.2 -stable review patch.  If anyone has any objections, please let 
us know.

------------------

From: Ralf Baechle DL5RB <ralf@linux-mips.org>

ax_encaps() forgot to drop the bufferlock at the end of the function.
Patch is already in 2.6.16-rc1.

Signed-off-by: Ralf Baechle DL5RB <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/hamradio/mkiss.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.15.1.orig/drivers/net/hamradio/mkiss.c
+++ linux-2.6.15.1/drivers/net/hamradio/mkiss.c
@@ -515,6 +515,7 @@ static void ax_encaps(struct net_device 
 			count = kiss_esc(p, (unsigned char *)ax->xbuff, len);
 		}
   	}
+	spin_unlock_bh(&ax->buflock);
 
 	set_bit(TTY_DO_WRITE_WAKEUP, &ax->tty->flags);
 	actual = ax->tty->driver->write(ax->tty, ax->xbuff, count);

--
