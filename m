Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbUKCSvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUKCSvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 13:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbUKCSvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 13:51:19 -0500
Received: from mail3.utc.com ([192.249.46.192]:47342 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261799AbUKCSvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 13:51:16 -0500
Message-ID: <41892899.6080400@cybsft.com>
Date: Wed, 03 Nov 2004 12:51:05 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sboyce@blueyonder.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
References: <4189108C.2050804@blueyonder.co.uk>
In-Reply-To: <4189108C.2050804@blueyonder.co.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce wrote:
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SYMLINK include/asm -> include/asm-x86_64
> scripts/kconfig/conf -s arch/x86_64/Kconfig
> #
> # using defaults found in .config
> #
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   CC      /usr/src/linux-2.6.10-rc1-mm2-RT-V0.7.7/include/asm/offsets.s
> In file included from include/asm/timex.h:12,
>                  from include/linux/timex.h:61,
>                  from include/linux/sched.h:11,
>                  from 
> /usr/src/linux-2.6.10-rc1-mm2-RT-V0.7.7/include/asm/offsets.c:7:
> include/asm/vsyscall.h:55: error: conflicting types for `xtime_lock'
> include/linux/time.h:83: error: previous declaration of `xtime_lock'
> make[1]: *** 
> [/usr/src/linux-2.6.10-rc1-mm2-RT-V0.7.7/include/asm/offsets.s] Error 1
> make: *** [prepare0] Error 2
> 
> Regards
> Sid.

You could try this untested patch that seems to follow Ingo's thinking 
for similar changes.

kr

--- linux-2.6.10-rc1-mm2/include/asm-x86_64/vsyscall.h.orig 
2004-11-03 12:43:03.966625798 -0600
+++ linux-2.6.10-rc1-mm2/include/asm-x86_64/vsyscall.h  2004-11-03 
12:44:19.430558964 -0600
@@ -45,14 +45,14 @@
  extern volatile unsigned long __jiffies;
  extern unsigned long __wall_jiffies;
  extern struct timezone __sys_tz;
-extern seqlock_t __xtime_lock;
+extern raw_seqlock_t __xtime_lock;

  /* kernel space (writeable) */
  extern struct vxtime_data vxtime;
  extern unsigned long wall_jiffies;
  extern struct timezone sys_tz;
  extern int sysctl_vsyscall;
-extern seqlock_t xtime_lock;
+extern raw_seqlock_t xtime_lock;

  #define ARCH_HAVE_XTIME_LOCK 1


