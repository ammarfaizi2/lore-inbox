Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161198AbWFVS7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbWFVS7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161199AbWFVS7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:59:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:10216 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161198AbWFVS7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:59:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=apykWn/JfcyCImULJEL0V2qrksJtf9rPiXi5am+V1XrcGSWESXJc8G6v6bNvSUr15MAQA7+FId7Xy0+x5llxmBo9TMZwbZJ+6RN+AOCqqIN5ZTPdGvfPJMzuY0zqJR1pflUC54EkC+l305sq3FZgnbIFrTPmgzzRCayvNXvy+dI=
Message-ID: <449AE8A0.7010102@gmail.com>
Date: Thu, 22 Jun 2006 12:59:44 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 09/11 ] gpio-patchset-fixups: 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff.19-fix-call-init-shadow

Must actually call pc8736x_init_shadow().  Without it, gpio_current() 
may return
wrong values until pin is written once.

Signed-off-by:   Jim Cromie <jim.cromie@gmail.com>

---

diff -ruNp -X dontdiff -X exclude-diffs 17-mm-pre0/drivers/char/pc8736x_gpio.c 19-extern/drivers/char/pc8736x_gpio.c
--- 17-mm-pre0/drivers/char/pc8736x_gpio.c	2006-06-20 20:42:39.000000000 -0600
+++ 19-extern/drivers/char/pc8736x_gpio.c	2006-06-21 09:48:22.000000000 -0600
@@ -311,6 +309,7 @@ static int __init pc8736x_gpio_init(void
 		dev_dbg(&pdev->dev, "got dynamic major %d\n", major);
 	}
 
+	pc8736x_init_shadow();
 	return 0;
 }
 


