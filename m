Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135498AbRDWB0v>; Sun, 22 Apr 2001 21:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135499AbRDWB0b>; Sun, 22 Apr 2001 21:26:31 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:1297 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S135498AbRDWB0W>;
	Sun, 22 Apr 2001 21:26:22 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15075.33972.459979.808211@tango.linuxcare.com.au>
Date: Mon, 23 Apr 2001 11:26:12 +1000 (EST)
To: Byeong-ryeol Kim <jinbo21@hananet.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <alan@redhat.com>, <buhr@stat.wisc.edu>
Subject: Re: [PATCH] PPP update against 2.4.4-pre5
In-Reply-To: <Pine.LNX.4.33.0104211428570.1780-100000@progress.plw.net>
In-Reply-To: <15072.6787.66773.470992@argo.ozlabs.ibm.com.au>
	<Pine.LNX.4.33.0104211428570.1780-100000@progress.plw.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byeong-ryeol Kim writes:

> I met 'unresolved symbol sk_chk_filter ...' after applying this patch
> and rebooting.( with CONFIG_PPP_FILTER=y )
> There shoud be folling lines in linux/net/netsyms.c or so:
> 
> #ifdef CONFIG_PPP_FILTER
> EXPORT_SYMBOL(sk_chk_filter);
> #endif

Good idea, actually let's put it next to the export of sk_run_filter,
as in the patch below.  Linus, could you apply this patch please?

Paul.

diff -urN linux/net/netsyms.c pmac/net/netsyms.c
--- linux/net/netsyms.c	Sun Apr 22 17:07:40 2001
+++ pmac/net/netsyms.c	Mon Apr 23 11:24:31 2001
@@ -158,6 +158,7 @@
 
 #ifdef CONFIG_FILTER
 EXPORT_SYMBOL(sk_run_filter);
+EXPORT_SYMBOL(sk_chk_filter);
 #endif
 
 EXPORT_SYMBOL(neigh_table_init);
