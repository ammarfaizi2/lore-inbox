Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270929AbTHQUiS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270986AbTHQUiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:38:18 -0400
Received: from maile.telia.com ([194.22.190.16]:16624 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id S270929AbTHQUiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:38:17 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       hgfelger@hgfelger.de
Subject: Re: 2.6.0-test3-mm2
References: <20030813013156.49200358.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 17 Aug 2003 22:37:50 +0200
In-Reply-To: <20030813013156.49200358.akpm@osdl.org>
Message-ID: <m2n0e858bl.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm resending this because I previously had sendmail configuration
problems. Sorry if you receive this message twice.)

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm2/

Here is a fix for synaptics touchpads with "multi buttons". The patch
comes from Hartwig Felger, who wrote the original multi button support
patch (p00003_synaptics-multi-button.patch). The same bug fix has been
included in the XFree86 driver for a few weeks, and seems to work
fine. (That part of the X driver is only used for 2.4 kernels.)


 linux-petero/drivers/input/mouse/synaptics.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/input/mouse/synaptics.c~syn-multi-btn-fix drivers/input/mouse/synaptics.c
--- linux/drivers/input/mouse/synaptics.c~syn-multi-btn-fix	2003-08-13 22:48:49.000000000 +0200
+++ linux-petero/drivers/input/mouse/synaptics.c	2003-08-13 22:48:49.000000000 +0200
@@ -433,7 +433,8 @@ static void synaptics_parse_hw_state(uns
 			if (hw->right)
 				hw->down = !hw->down;
 		}
-		if (buf[3] == 0xC2 && SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)) {
+		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
+		    ((buf[3] & 2) ? !hw->right : hw->right)) {
 			switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
 			default:
 				; /* we did comment while initialising... */

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
