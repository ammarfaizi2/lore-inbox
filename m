Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbTIVTqL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTIVTqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:46:11 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:2581 "EHLO
	mwinf0504.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263329AbTIVTqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:46:08 -0400
Message-ID: <3F6F52AE.3080206@wanadoo.fr>
Date: Mon, 22 Sep 2003 21:51:10 +0200
From: Remi Colinet <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Patch] Compile fix for 2.6.0-test5-mm4 in net/atm/proc.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

--- linux-2.6.0-test5-mm4/net/atm/proc.c        2003-09-22 
21:42:09.000000000 +0200
+++ linux-2.6.0-test5-mm4-new/net/atm/proc.c    2003-09-22 
21:44:24.000000000 +0200
@@ -192,7 +192,9 @@
                goto out_kfree;

        state->family = family;
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
        state->clip_info = try_atm_clip_ops();
+#endif

        seq = file->private_data;
        seq->private = state;

This patch fixes the following compile error :

  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
net/built-in.o: In function `__vcc_seq_open':
/usr/src/mm/net/atm/proc.c:195: undefined reference to `try_atm_clip_ops'
make: *** [.tmp_vmlinux1] Error 1

Remi


