Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129806AbQKQVm4>; Fri, 17 Nov 2000 16:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130347AbQKQVmq>; Fri, 17 Nov 2000 16:42:46 -0500
Received: from hera.cwi.nl ([192.16.191.1]:32453 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129806AbQKQVmh>;
	Fri, 17 Nov 2000 16:42:37 -0500
Date: Fri, 17 Nov 2000 22:12:25 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011172112.WAA135348.aeb@aak.cwi.nl>
To: Andries.Brouwer@cwi.nl, koenig@tat.physik.uni-tuebingen.de
Subject: Re: BUG: isofs broken (2.2 and 2.4)
Cc: aeb@veritas.com, emoenke@gwdg.de, eric@andante.org,
        kobras@tat.physik.uni-tuebingen.de, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> memory leak

Aha. Must be a missing kfree().
Does this help?

--- namei.c~    Fri Nov 17 00:48:37 2000
+++ namei.c     Fri Nov 17 21:59:49 2000
@@ -197,6 +197,8 @@
                        bh = NULL;
                        break;
                }
+               if (cpnt)
+                       kfree(cpnt);
        }
        if (page)
                free_page((unsigned long) page);

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
