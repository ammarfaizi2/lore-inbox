Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTFNWI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 18:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTFNWI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 18:08:59 -0400
Received: from nycsmtp4out-eri0.rdc-nyc.rr.com ([24.29.99.227]:15526 "EHLO
	nycsmtp4out-eri0.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261300AbTFNWI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 18:08:57 -0400
Message-ID: <3EEBA088.30807@sixbit.org>
Date: Sat, 14 Jun 2003 18:24:08 -0400
From: John Weber <weber@sixbit.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Clements <clem@clem.clem-digital.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 fails compile (net/built-in.o)
References: <20030614221008$62f5@gated-at.bofh.it>
In-Reply-To: <20030614221008$62f5@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Clements wrote:
> FYI:
> 
> 
>   CPP     arch/i386/vmlinux.lds.s
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> net/built-in.o: In function `flow_cache_init':
> net/built-in.o(.init.text+0x282): undefined reference to `register_cpu_notifier'
> make: *** [.tmp_vmlinux1] Error 1
> 
Just a missing #include in net/core/flow.c

--- flow.old    2003-06-14 18:17:35.000000000 -0400
+++ flow.c      2003-06-14 18:13:03.000000000 -0400
@@ -5,6 +5,7 @@
   */

  #include <linux/kernel.h>
+#include <linux/cpu.h>
  #include <linux/list.h>
  #include <linux/jhash.h>
  #include <linux/interrupt.h>

