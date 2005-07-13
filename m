Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVGMVyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVGMVyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVGMSpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:45:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:17379 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262313AbVGMSow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:44:52 -0400
Date: Wed, 13 Jul 2005 11:43:57 -0700
From: Greg KH <gregkh@suse.de>
To: kambarov@berkeley.edu
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [08/11] coverity: tty_ldisc_ref return null check
Message-ID: <20050713184357.GJ9330@kroah.com>
References: <20050713184130.GA9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184130.GA9330@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: KAMBAROV, ZAUR <kambarov@berkeley.edu>

We add a check of the return value of tty_ldisc_ref(), which
is checked 7 out of 8 times, e.g.:

149  		ld = tty_ldisc_ref(tty);
150  		if (ld != NULL) {
151  			if (ld->set_termios)
152  				(ld->set_termios)(tty, &old_termios);
153  			tty_ldisc_deref(ld);
154  		}

This defect was found automatically by Coverity Prevent, a static analysis
tool.

(akpm: presumably `ld' is never NULL.  Oh well)

Signed-off-by: Zaur Kambarov <zkambarov@coverity.com>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/tty_ioctl.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.12.2.orig/drivers/char/tty_ioctl.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/drivers/char/tty_ioctl.c	2005-07-13 10:56:39.000000000 -0700
@@ -476,11 +476,11 @@
 			ld = tty_ldisc_ref(tty);
 			switch (arg) {
 			case TCIFLUSH:
-				if (ld->flush_buffer)
+				if (ld && ld->flush_buffer)
 					ld->flush_buffer(tty);
 				break;
 			case TCIOFLUSH:
-				if (ld->flush_buffer)
+				if (ld && ld->flush_buffer)
 					ld->flush_buffer(tty);
 				/* fall through */
 			case TCOFLUSH:
