Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129105AbQKLNEw>; Sun, 12 Nov 2000 08:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129936AbQKLNEm>; Sun, 12 Nov 2000 08:04:42 -0500
Received: from s340-modem1553.dial.xs4all.nl ([194.109.166.17]:4224 "HELO
	sjoerd.sjoerdnet") by vger.kernel.org with SMTP id <S129105AbQKLNEc>;
	Sun, 12 Nov 2000 08:04:32 -0500
Date: Sun, 12 Nov 2000 14:03:27 +0100 (CET)
From: Arjan Filius <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: f5ibh <f5ibh@db0bm.ampr.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] net/ax25/sysctl_net_ax25.c Re: 2.4.0-test11-pre3 doesn't
 compile
In-Reply-To: <200011121149.MAA22970@db0bm.ampr.org>
Message-ID: <Pine.LNX.4.21.0011121400450.1799-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 12 Nov 2000, f5ibh wrote:

> 
> Hi!
> 
> here is the message :
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
> -march=i586 -DMODULE   -c -o sysctl_net_ax25.o sysctl_net_ax25.c
> sysctl_net_ax25.c: In function `ax25_register_sysctl':
> sysctl_net_ax25.c:117: warning: left-hand operand of comma expression has no
> effect
> sysctl_net_ax25.c:117: parse error before `;'

The folowing patch did fix this for me:
--- ./net/ax25/sysctl_net_ax25.c~	Sun Nov 12 09:31:39 2000
+++ ./net/ax25/sysctl_net_ax25.c	Sun Nov 12 13:45:11 2000
@@ -114,7 +114,7 @@
 	memset(ax25_table, 0x00, ax25_table_size);
 
 	for (n = 0, ax25_dev = ax25_dev_list; ax25_dev != NULL; ax25_dev = ax25_dev->next) {
-		ctl_table *child = kmalloc(sizeof(ax25_param_table, GFP_ATOMIC);
+		ctl_table *child = kmalloc(sizeof(ax25_param_table), GFP_ATOMIC);
 		if (!child) {
 			while (n--)
 				kfree(ax25_table[n].child);


Arjan Filius
mailto:iafilius@xs4all.nl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
