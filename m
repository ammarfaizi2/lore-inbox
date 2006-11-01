Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946369AbWKAFjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946369AbWKAFjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946380AbWKAFiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:38:54 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:30097 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946369AbWKAFih
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:38:37 -0500
Message-Id: <20061101053839.226970000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:01 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Marcel Holtmann <marcel@holtmann.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 21/61] Bluetooth: Check if DLC is still attached to the TTY
Content-Disposition: inline; filename=bluetooth-check-if-dlc-is-still-attached-to-the-tty.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Marcel Holtmann <marcel@holtmann.org>

[Bluetooth] Check if DLC is still attached to the TTY

If the DLC device is no longer attached to the TTY device, then it
makes no sense to go through with changing the termios settings.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 net/bluetooth/rfcomm/tty.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.18.1.orig/net/bluetooth/rfcomm/tty.c
+++ linux-2.6.18.1/net/bluetooth/rfcomm/tty.c
@@ -748,6 +748,9 @@ static void rfcomm_tty_set_termios(struc
 
 	BT_DBG("tty %p termios %p", tty, old);
 
+	if (!dev)
+		return;
+
 	/* Handle turning off CRTSCTS */
 	if ((old->c_cflag & CRTSCTS) && !(new->c_cflag & CRTSCTS)) 
 		BT_DBG("Turning off CRTSCTS unsupported");

--
