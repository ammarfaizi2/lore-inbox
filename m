Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281215AbRKPHSS>; Fri, 16 Nov 2001 02:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281216AbRKPHSI>; Fri, 16 Nov 2001 02:18:08 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:22291 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281215AbRKPHSD>; Fri, 16 Nov 2001 02:18:03 -0500
Message-ID: <3BF4BD81.C3E4A4DC@zip.com.au>
Date: Thu, 15 Nov 2001 23:17:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: pmhahn@titan.lahn.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [OOPS] net/8139too
In-Reply-To: <Pine.LNX.4.33.0111160721120.6043-100000@titan.lahn.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Matthias Hahn wrote:
> 
> Hello LKML!
> 
> Since linux-2.4.15-pre[14]+kdb+freeswan I get an oops when stopping my
> 8139too network:
> 
> # ifdown eth0
> eth0: unable to signal thread

Oh gawd. What now?

Could you please tell us what the return value is from kill_proc()?


--- linux-2.4.15-pre4/drivers/net/8139too.c	Mon Nov 12 11:16:11 2001
+++ linux-akpm/drivers/net/8139too.c	Thu Nov 15 23:14:14 2001
@@ -2064,7 +2064,7 @@ static int rtl8139_close (struct net_dev
 		wmb();
 		ret = kill_proc (tp->thr_pid, SIGTERM, 1);
 		if (ret) {
-			printk (KERN_ERR "%s: unable to signal thread\n", dev->name);
+			printk (KERN_ERR "%s: unable to signal thread: %d\n", dev->name, ret);
 			return ret;
 		}
 		wait_for_completion (&tp->thr_exited);

-
