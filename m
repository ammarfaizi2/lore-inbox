Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbTIQOOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 10:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTIQOOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 10:14:05 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:63343 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262769AbTIQOOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 10:14:03 -0400
Message-ID: <3F686D4C.3070407@wanadoo.fr>
Date: Wed, 17 Sep 2003 16:18:52 +0200
From: Remi Colinet <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5-bk4 : compile error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
net/built-in.o: In function `__vcc_seq_open':
net/built-in.o(.text+0x8a27e): undefined reference to `try_atm_clip_ops'
make: *** [.tmp_vmlinux1] Error 1

Compiled error caused by net/atm/proc.c line 195. I was able to compile 
with :

--- net/atm/proc.c.org  2003-09-17 16:14:30.000000000 +0200
+++ net/atm/proc.c      2003-09-17 16:16:53.000000000 +0200
@@ -192,7 +192,9 @@
                goto out_kfree;

        state->family = family;
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
        state->clip_info = try_atm_clip_ops();
+#endif

        seq = file->private_data;
        seq->private = state;

Remi

