Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbUJ0Wmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbUJ0Wmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbUJ0Wgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:36:49 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:49807 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262957AbUJ0WgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:36:12 -0400
Message-ID: <418017B5.7080706@free.fr>
Date: Wed, 27 Oct 2004 23:48:37 +0200
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a trivial compile fix :

CC      lib/string.o
  CC      lib/vsprintf.o
  AR      lib/lib.a
  CC      arch/i386/lib/bitops.o
  CC      arch/i386/lib/dec_and_lock.o
  CC      arch/i386/lib/delay.o
  CC      arch/i386/lib/memcpy.o
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o(.text+0x8450): In function `cpu_callback':
kernel/fork.c:1421: undefined reference to `takeover_tasklets'
make: *** [.tmp_vmlinux1] Error 1


--- kernel/softirq.c.orig       2004-10-27 23:44:14.160948016 +0200
+++ kernel/softirq.c    2004-10-27 23:44:34.571845088 +0200
@@ -464,7 +464,7 @@
        BUG();
 }
 
-static void takeover_tasklets(unsigned int cpu)
+void takeover_tasklets(unsigned int cpu)
 {
        struct tasklet_struct **i;
 

Remi
