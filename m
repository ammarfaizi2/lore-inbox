Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270904AbTGQUZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270899AbTGQUZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:25:37 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:12714 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S270872AbTGQUZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:25:29 -0400
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030717201039.GC25759@charite.de>
References: <20030717141847.GF7864@charite.de>
	 <m38yqxf2ab.fsf@lugabout.jhcloos.org>  <20030717201039.GC25759@charite.de>
Content-Type: multipart/mixed; boundary="=-qAhXBkzZToplTEV4SPQt"
Organization: iNES Group SRL
Message-Id: <1058474421.1724.3.camel@LNX.iNES.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Jul 2003 23:40:21 +0300
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qAhXBkzZToplTEV4SPQt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-07-17 at 23:10, Ralf Hildebrandt wrote:
> * James H. Cloos Jr. <cloos@jhcloos.com>:
> > Ralf> atkbd.c: Unknown key (set 2, scancode 0xa2, on isa0060/serio0) pressed.
> > Ralf> atkbd.c: Unknown key (set 2, scancode 0x92, on isa0060/serio0) pressed.

> But this happened while typing NORMALLY, with no frills :) I mean, I
> was just typing in some unix commands - so I never even came close to
> the keys I never use anyway...


I noticed the same oddity on my Toshiba Sattelite Pro 6100 and choosed
to silece it with the following (trivial) patch. No side effects so
far..




-- 
Cioby

--=-qAhXBkzZToplTEV4SPQt
Content-Disposition: attachment; filename=atkbd-silent.patch
Content-Type: text/plain; name=atkbd-silent.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.5.74/drivers/input/keyboard/atkbd.c.original	2003-07-06 12:08:45.122831824 +0300
+++ linux-2.5.74/drivers/input/keyboard/atkbd.c	2003-07-06 12:09:41.183309336 +0300
@@ -191,8 +191,8 @@
 		case ATKBD_KEY_NULL:
 			break;
 		case ATKBD_KEY_UNKNOWN:
-			printk(KERN_WARNING "atkbd.c: Unknown key (set %d, scancode %#x, on %s) %s.\n",
-				atkbd->set, code, serio->phys, atkbd->release ? "released" : "pressed");
+/*			printk(KERN_WARNING "atkbd.c: Unknown key (set %d, scancode %#x, on %s) %s.\n", 
+				atkbd->set, code, serio->phys, atkbd->release ? "released" : "pressed"); */
 			break;
 		default:
 			input_regs(&atkbd->dev, regs);

--=-qAhXBkzZToplTEV4SPQt--

