Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUFNAfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUFNAfw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUFNAfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:35:52 -0400
Received: from holomorphy.com ([207.189.100.168]:28317 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261426AbUFNAfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:35:00 -0400
Date: Sun, 13 Jun 2004 17:34:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [2/12] lower priority of "too many keys" msg in atkbd.c
Message-ID: <20040614003459.GQ1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614003331.GP1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * Lowered priority of "too many keys" message in drivers/input/keyboard/atkbd.c
This fixes Debian BTS #239036.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=239036

	From: "Jon Thackray" <jgt@pobox.com>
	Message-ID: <16476.11084.179640.444619@localhost.localdomain>
	To: submit@bugs.debian.org
	Subject: Keyboard misbehaving

The keyboard under 2.6.4 seems to be behaving strangely, reporting
unknown key codes and too many keys pressed, even when no keys have
been pressed. The keyboard is connected via an 8 way KVM switch, but
was working quite acceptably under 2.4.25 with no such messages.
Trying 2.6.3 is not an option as it doesn't support the hardware
properly, as previously reported.


Index: linux-2.5/drivers/input/keyboard/atkbd.c
===================================================================
--- linux-2.5.orig/drivers/input/keyboard/atkbd.c	2004-06-13 11:57:13.000000000 -0700
+++ linux-2.5/drivers/input/keyboard/atkbd.c	2004-06-13 12:08:54.000000000 -0700
@@ -288,7 +288,7 @@
 			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
 			goto out;
 		case ATKBD_RET_ERR:
-			printk(KERN_WARNING "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
+			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
 			goto out;
 	}
 
