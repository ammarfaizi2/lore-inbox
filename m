Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUAZBpa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 20:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUAZBpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 20:45:30 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.27]:63087 "EHLO
	mwinf0402.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261500AbUAZBp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 20:45:29 -0500
Date: Mon, 26 Jan 2004 03:01:35 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: Richard Henderson <rth@twiddle.net>, John Levon <levon@movementarian.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] oprofile, typo in alpha driver
Message-ID: <20040126030135.GA3202@zaniah>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Richard Henderson <rth@twiddle.net>,
	John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless I miss something this look like a typo, one user reported to get error
from the daemon: 'Unknown event for counter 1' (alpha ev6) and the behavior
was better but not completly sane after trying this patch: he get spurious
event for counter 1 when enabling only counter 0 but rarely now. No alpha box
to test this.

regards,
Phil

Index: arch/alpha/oprofile/common.c
===================================================================
RCS file: /usr/local/cvsroot/linux-2.5/arch/alpha/oprofile/common.c,v
retrieving revision 1.5
diff -u -p -r1.5 common.c
--- arch/alpha/oprofile/common.c	21 Jun 2003 16:20:31 -0000	1.5
+++ arch/alpha/oprofile/common.c	26 Jan 2004 02:43:38 -0000
@@ -57,7 +57,7 @@ op_axp_setup(void)
 
 	/* Compute the mask of enabled counters.  */
 	for (i = e = 0; i < model->num_counters; ++i)
-		if (ctr[0].enabled)
+		if (ctr[i].enabled)
 			e |= 1 << i;
 	reg.enable = e;
 
