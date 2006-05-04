Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWEDCoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWEDCoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 22:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWEDCoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 22:44:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39862 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750890AbWEDCoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 22:44:05 -0400
Date: Wed, 3 May 2006 22:44:04 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Remove silly messages from input layer.
Message-ID: <20060504024404.GA17818@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two messages in the input layer that seem to be
triggerable very easily, and they confuse end-users to no end.
"too many keys pressed? Should I press less keys?"
I actually got a complaint from one user that he had only
hit one key before being told to type less.

The latter message seems to trigger with certain keyboard switchers
and again, does nothing but confuse people.

Best of all, asides from the silly messages, none of the people suffering
them report any other misbehaviour, their keyboards work just fine.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.16.noarch/drivers/input/keyboard/atkbd.c~	2006-05-03 22:37:20.000000000 -0400
+++ linux-2.6.16.noarch/drivers/input/keyboard/atkbd.c	2006-05-03 22:39:58.000000000 -0400
@@ -340,7 +340,6 @@ static irqreturn_t atkbd_interrupt(struc
 			atkbd_report_key(atkbd->dev, regs, KEY_HANJA, 3);
 			goto out;
 		case ATKBD_RET_ERR:
-			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
 			goto out;
 	}
 
@@ -359,11 +358,7 @@ static irqreturn_t atkbd_interrupt(struc
 		case ATKBD_KEY_NULL:
 			break;
 		case ATKBD_KEY_UNKNOWN:
-			if (data == ATKBD_RET_ACK || data == ATKBD_RET_NAK) {
-				printk(KERN_WARNING "atkbd.c: Spurious %s on %s. Some program, "
-				       "like XFree86, might be trying access hardware directly.\n",
-				       data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);
-			} else {
+			if (data != ATKBD_RET_ACK && data != ATKBD_RET_NAK) {
 				printk(KERN_WARNING "atkbd.c: Unknown key %s "
 				       "(%s set %d, code %#x on %s).\n",
 				       atkbd->release ? "released" : "pressed",
