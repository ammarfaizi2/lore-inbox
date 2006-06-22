Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161183AbWFVSyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbWFVSyI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161188AbWFVSyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:54:08 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:21028 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161183AbWFVSyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:54:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=fsZXMbqN8iXLhVjvk9gh7EITEHjM0a9qNVi6lQjwyksLKhlKNvX4P0RyLtcBDJV1ZbPKA30t0xy2VIjPzkUs8WepvDczrMBXI3qpTkHKdgdtgGFBkQ6EFE3tobJUzDV60D7AfvwMN16CKUA7oYgfYIbAt6eBR3MbBG/Wk1zeP+A=
Message-ID: <449AE74C.60601@gmail.com>
Date: Thu, 22 Jun 2006 12:54:04 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 08/11 ] gpio-patchset-fixups:  make precedence explicit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff.16-fix-explicit-precedence

make evaluation explicit, rather than relying on precedence.

Signed-off-by:   Jim Cromie <jim.cromie@gmail.com>

---

diff -ruNp -X dontdiff -X exclude-diffs 17-mm-pre0/drivers/char/pc8736x_gpio.c 16-precedence/drivers/char/pc8736x_gpio.c
--- 17-mm-pre0/drivers/char/pc8736x_gpio.c	2006-06-20 20:42:39.000000000 -0600
+++ 16-precedence/drivers/char/pc8736x_gpio.c	2006-06-21 09:28:49.000000000 -0600
@@ -204,7 +204,7 @@ static int pc8736x_gpio_current(unsigned
 	minor &= 0x1f;
 	port = minor >> 3;
 	bit = minor & 7;
-	return pc8736x_gpio_shadow[port] >> bit & 0x01;
+	return ((pc8736x_gpio_shadow[port] >> bit) & 0x01);
 }
 
 static void pc8736x_gpio_change(unsigned index)


