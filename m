Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbRERUNf>; Fri, 18 May 2001 16:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbRERUNZ>; Fri, 18 May 2001 16:13:25 -0400
Received: from www.topmail.de ([212.255.16.226]:60619 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S261450AbRERUNM>;
	Fri, 18 May 2001 16:13:12 -0400
From: mirabilos <eccesys@topmail.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: 00_rwsem-11, 2.4.4-ac11 and gcc-3(2001-05-14)
Message-Id: <20010518200837.ED2FDA5AF76@www.topmail.de>
Date: Fri, 18 May 2001 22:08:37 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,
I applied rwsem-11 (a bit by hand) to -ac11 and tried to
compile. By changing CFLAGS_sys.o to -O (instead of -O2)
as I read earlier I nearly could compile, it only barfed
when it came to assemble the xaddl procedure by itself:

static inline long rwsem_xchgadd(long value, long * count)
{
        __asm__ __volatile__(LOCK "xaddl %0,%1"
                             : "+r" (value), "+m" (*count));
        return value;
}

changing from "inline" to "" yields a kernel which stops just
before mounting root (sysrq still works, but nothing else).
I now try again with GENERIC, and it actually is compiling...
lets look whether it works.
I hope a non-generic will solve the sound freeze :)

-mirabilos
-- 
by telnet
