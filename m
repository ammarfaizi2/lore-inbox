Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266255AbRF3T3L>; Sat, 30 Jun 2001 15:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266256AbRF3T3C>; Sat, 30 Jun 2001 15:29:02 -0400
Received: from [211.108.47.117] ([211.108.47.117]:55564 "EHLO progress.plw.net")
	by vger.kernel.org with ESMTP id <S266255AbRF3T2o>;
	Sat, 30 Jun 2001 15:28:44 -0400
Date: Sun, 1 Jul 2001 04:28:16 +0900 (KST)
From: Byeong-ryeol Kim <jinbo21@hananet.net>
Reply-To: Byeong-ryeol Kim <jinbo21@hananet.net>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: compile error about do_softirq in 2.4.5-ac21 
In-Reply-To: <31885.993874778@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.33.0107010417090.5456-100000@progress.plw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2001, Keith Owens wrote:

>On Sat, 30 Jun 2001 10:07:20 +0900 (KST),
>Byeong-ryeol Kim <jinbo21@hananet.net> wrote:
>>>>background.c:57: `do_softirq_Rf0a529b7' undeclared (first use in \
>>>>                this function)
>
>Missing include in fs/jffs2/background.c.  spin_unlock_bh() needs the
>definition of do_softirq().  Against 2.4.5-ac21, will fit -ac22 as well.
>
>Index: 5.52/fs/jffs2/background.c
>--- 5.52/fs/jffs2/background.c Sun, 22 Apr 2001 07:25:55 +1000 kaos (linux-2.4/Z/d/7_background 1.1 644)
>+++ 5.52(w)/fs/jffs2/background.c Sat, 30 Jun 2001 14:13:12 +1000 kaos (linux-2.4/Z/d/7_background 1.1 644)
>@@ -43,6 +43,7 @@
> #include <linux/jffs2.h>
> #include <linux/mtd/mtd.h>
>+#include <linux/interrupt.h>
> #include <linux/smp_lock.h>
> #include "nodelist.h"
...

Thank you.
But, it is proved to be that jffs2/background.c includes 'linux/smp_lock.h',
'linux/smp_lock.h' includes 'asm/smplock.h' and 'asm/smplock.h' includes
'linux/interrupt.h'.
Is it correct to put 'linux/interrupt.h' into jffs2/background.c in this
situation?

-- 
Where there is a will, there is a way.       jinbo21@hananet.net
  For the future of you and me!              jinbo21@hitel.net
fingerprint = 1429 8AAF 8A2C 6043 DA2E  BD4C 964C 2698 687D 4B7D

