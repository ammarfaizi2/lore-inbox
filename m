Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbRIFWHV>; Thu, 6 Sep 2001 18:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbRIFWHK>; Thu, 6 Sep 2001 18:07:10 -0400
Received: from mout1.freenet.de ([194.97.50.132]:38350 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S267852AbRIFWHB>;
	Thu, 6 Sep 2001 18:07:01 -0400
Date: Thu, 6 Sep 2001 23:52:22 +0200
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Wrong signal in SIGBUS's siginfo.
Message-ID: <20010906235222.A3329@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moi!

The page fault handler for i386 contains a typo that will cause
SIGBUS errors to disguise as SIGSEGVs in their siginfo structs.
Here's a trivial fix to sort out the who is who. Patch applies
at least to 2.4.9 and (with a little fuzz) 2.4.9-ac2.

Regards,

Daniel.

---[snip]---

--- arch/i386/mm/fault.c.vanilla	Thu Jul 12 11:52:05 2001
+++ arch/i386/mm/fault.c	Thu Sep  6 23:38:45 2001
@@ -313,7 +313,7 @@
 	tsk->thread.cr2 = address;
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = 14;
-	info.si_code = SIGBUS;
+	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void *)address;
