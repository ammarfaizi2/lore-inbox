Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbUCTNiM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 08:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUCTNiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 08:38:12 -0500
Received: from mx.laposte.net ([81.255.54.11]:43462 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S263411AbUCTNiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 08:38:08 -0500
From: Sebastien B <sebastien.bourdeauducq@laposte.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial bugfix in tipar
Date: Sat, 20 Mar 2004 14:44:13 +0100
User-Agent: KMail/1.6
Cc: rlievin@free.fr
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403201444.13432.sebastien.bourdeauducq@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
This small patch for drivers/char/tipar.c fixes a divide-by-zero error when 
you try to read/write data after setting the timeout to 0.
Please apply,
Seb

--- tipar.c     Sat Mar 20 13:48:55 2004
+++ /usr/src/linux/drivers/char/tipar.c Sat Mar 20 14:06:53 2004
@@ -364,7 +364,7 @@
          delay = (int)arg;    //get_user(delay, &arg);
          break;
        case IOCTL_TIPAR_TIMEOUT:
-         timeout = (int)arg;  //get_user(timeout, &arg);
+         if (arg != 0) timeout = (int)arg; else retval = -EINVAL; //
get_user(timeout, &arg);
          break;
        default:
                retval = -ENOTTY;
@@ -399,7 +399,7 @@
        str = get_options(str, ARRAY_SIZE(ints), ints);

        if (ints[0] > 0) {
-               timeout = ints[1];
+               if (ints[1] != 0) timeout = ints[1]; else printk("tipar: wrong 
timeout value (0), using default value");
                if (ints[0] > 1) {
                        delay = ints[2];
                }
