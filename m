Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWGLRUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWGLRUN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWGLRUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:20:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:40608 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932138AbWGLRUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:20:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=HuqEbo9mftxUbEth57V6jI5YaFAeF4DNeUHXy2pht/VY4xbsxbd+5kqkAy4ObjuzWOzAfk2Yazc5SU2vyu4sZFyJ14gQ6lAyxdvYXG2myvgHwusjaMcQ8wOTmkZ/N46B4y3vo3fNgFlvnVpIS5VPXcrGzMg9tQW3bKtHSTTNtxY=
Message-ID: <44B52F51.6040005@gmail.com>
Date: Wed, 12 Jul 2006 11:20:17 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [ patch -mm1 01/03 ] gpio: drop vtable members .gpio_set_high .gpio_set_low
   gpio_set is enough.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1 - drops gpio_set_high, gpio_set_low from the nsc_gpio_ops vtable.
While we can't drop them from scx200_gpio (or can we?), we dont need them
for new users of the exported vtable;  gpio_set(1),  gpio_set(0) work fine.

Signed-off-by  Jim Cromie  <jim.cromie@gmail.com>
---

[jimc@harpo fxd3]$ diffstat diff.nosethilo
 drivers/char/pc8736x_gpio.c |    2 --
 drivers/char/scx200_gpio.c  |    2 --
 include/linux/nsc_gpio.h    |    2 --
 3 files changed, 6 deletions(-)


diff -ruNp -X dontdiff -X exclude-diffs aa-0/drivers/char/pc8736x_gpio.c a0-nohilo/drivers/char/pc8736x_gpio.c
--- aa-0/drivers/char/pc8736x_gpio.c	2006-07-09 10:37:54.000000000 -0600
+++ a0-nohilo/drivers/char/pc8736x_gpio.c	2006-07-12 09:21:58.000000000 -0600
@@ -218,8 +218,6 @@ static struct nsc_gpio_ops pc8736x_acces
 	.gpio_dump	= nsc_gpio_dump,
 	.gpio_get	= pc8736x_gpio_get,
 	.gpio_set	= pc8736x_gpio_set,
-	.gpio_set_high	= pc8736x_gpio_set_high,
-	.gpio_set_low	= pc8736x_gpio_set_low,
 	.gpio_change	= pc8736x_gpio_change,
 	.gpio_current	= pc8736x_gpio_current
 };
diff -ruNp -X dontdiff -X exclude-diffs aa-0/drivers/char/scx200_gpio.c a0-nohilo/drivers/char/scx200_gpio.c
--- aa-0/drivers/char/scx200_gpio.c	2006-07-11 12:14:57.000000000 -0600
+++ a0-nohilo/drivers/char/scx200_gpio.c	2006-07-12 09:20:55.000000000 -0600
@@ -41,8 +41,6 @@ struct nsc_gpio_ops scx200_access = {
 	.gpio_dump	= nsc_gpio_dump,
 	.gpio_get	= scx200_gpio_get,
 	.gpio_set	= scx200_gpio_set,
-	.gpio_set_high	= scx200_gpio_set_high,
-	.gpio_set_low	= scx200_gpio_set_low,
 	.gpio_change	= scx200_gpio_change,
 	.gpio_current	= scx200_gpio_current
 };
diff -ruNp -X dontdiff -X exclude-diffs aa-0/include/linux/nsc_gpio.h a0-nohilo/include/linux/nsc_gpio.h
--- aa-0/include/linux/nsc_gpio.h	2006-07-06 13:20:28.000000000 -0600
+++ a0-nohilo/include/linux/nsc_gpio.h	2006-07-12 09:20:14.000000000 -0600
@@ -25,8 +25,6 @@ struct nsc_gpio_ops {
 	void	(*gpio_dump)	(struct nsc_gpio_ops *amp, unsigned iminor);
 	int	(*gpio_get)	(unsigned iminor);
 	void	(*gpio_set)	(unsigned iminor, int state);
-	void	(*gpio_set_high)(unsigned iminor);
-	void	(*gpio_set_low)	(unsigned iminor);
 	void	(*gpio_change)	(unsigned iminor);
 	int	(*gpio_current)	(unsigned iminor);
 	struct device*	dev;	/* for dev_dbg() support, set in init  */


