Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316603AbSFDMg7>; Tue, 4 Jun 2002 08:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSFDMg6>; Tue, 4 Jun 2002 08:36:58 -0400
Received: from sol.mixi.net ([208.131.233.11]:29077 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S316603AbSFDMg5>;
	Tue, 4 Jun 2002 08:36:57 -0400
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.2.90.1 (via feedmail 8 I);
	VM 7.05 under Emacs 21.2.90.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15612.46167.22304.227476@rtfm.ofc.tekinteractive.com>
Date: Tue, 4 Jun 2002 07:36:39 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: + 1000000000 bug still in 2.4.19-pre10 (proc_misc.c)
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4.19-pre10 patch still contains the following bug:

@@ -279,10 +335,11 @@
        );
 #if !defined(CONFIG_ARCH_S390)
        for (i = 0 ; i < NR_IRQS ; i++)
-               len += sprintf(page + len, " %u", kstat_irqs(i));
+               proc_sprintf(page, &off, &len,
+                            " %u", kstat_irqs(i) + 1000000000);
 #endif
 

Ben LaHaise confirmed that the "+ 1000000000" part was a brown paper
bag.  (The addition of a billion was test code that triggered the bug
which the rest of the proc_misc change fixes.)


Todd

