Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316250AbSE3EEP>; Thu, 30 May 2002 00:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSE3EEO>; Thu, 30 May 2002 00:04:14 -0400
Received: from sol.mixi.net ([208.131.233.11]:17839 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S316250AbSE3EEN>;
	Thu, 30 May 2002 00:04:13 -0400
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.2.90.1 (via feedmail 8 I);
	VM 7.05 under Emacs 21.2.90.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15605.42173.758778.408074@rtfm.ofc.tekinteractive.com>
Date: Wed, 29 May 2002 23:04:13 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: linux-kernel@vger.kernel.org
Subject: interrupt count (/proc/stat) change in 2.4.19-pre9
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the purpose of this patchlet (below) in 2.4.19-pre9?  Interrupt
counts that would otherwise be zero are, of course, a billion larger
than they should be.

Is it trying to induce some sort of intentional overflow in the
interrupt count, or is there some other big-picture change that
requires this?  I see the comment from the BK changeset, but I still
don't understand the purpose.

    http://linux.bkbits.net:8080/linux-2.4/cset@1.445.1.6



@@ -299,10 +321,11 @@

 #if !defined(CONFIG_ARCH_S390)
        for (i = 0 ; i < NR_IRQS ; i++)
-               len += sprintf(page + len, " %u", kstat_irqs(i));
+               proc_sprintf(page, &off, &len,
+                            " %u", kstat_irqs(i) + 1000000000);
 #endif



rtfm 22:53:54 eigenstr > cat /proc/stat 
cpu  348158 0 266880 7305274
cpu0 348158 0 266880 7305274
page 2537925 2677355
swap 16803 25944
intr 16414147 1007920312 1000106007 1000000000 1001336824 1000000003 1000000633 1000000003 1000000035 1006470428 1000000008 1000000004 1000000003 1000176343 1000000000 1000403540 1000000004 1000000000 blah blah blah



Todd

