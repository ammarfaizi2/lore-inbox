Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286236AbRLJLaF>; Mon, 10 Dec 2001 06:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286235AbRLJL34>; Mon, 10 Dec 2001 06:29:56 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:269 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S286232AbRLJL3l>;
	Mon, 10 Dec 2001 06:29:41 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200112101129.MAA09485@nbd.it.uc3m.es>
Subject: [PATCH] 2.5.1-pre6 trivial pc110pad.c change
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Mon, 10 Dec 2001 12:29:20 +0100 (CET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pc110pad.c won't compile without this:

--- drivers/char/pc110pad.c.pre-ptb     Mon Dec 10 12:25:57 2001
+++ drivers/char/pc110pad.c     Mon Dec 10 12:26:50 2001
@@ -590,7 +590,7 @@
        spin_lock_irqsave(&pc110_lock, flags);
        if (!--active_count)
                outb(0x30, current_params.io+2);  /* switch off digitiser */
-       spin_unlock_irqrestore(&active_lock, flags);
+       spin_unlock_irqrestore(&pc110_lock, flags);
        return 0;
 }
 

I imagine active_lock was the wrongness, as it wasn't declared anywhere.

Peter
