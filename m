Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279640AbRKFPnj>; Tue, 6 Nov 2001 10:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279704AbRKFPna>; Tue, 6 Nov 2001 10:43:30 -0500
Received: from etna.trivadis.com ([193.73.126.2]:8186 "EHLO lttit")
	by vger.kernel.org with ESMTP id <S279640AbRKFPnN>;
	Tue, 6 Nov 2001 10:43:13 -0500
Date: Tue, 6 Nov 2001 16:41:41 +0100
From: Tim Tassonis <timtas@cubic.ch>
To: diemer@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 breaks block/loop.c (loopback device)
X-Mailer: Sylpheed version 0.6.4cvs16 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1618MA-0006Rn-00@lttit>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Hi!
>
> The latest kernel seems to breake the loop device. I used 2.4.13 before,
and
> everything was fine. I didn't change my kernel config when upgrading.
>
> I compile the loop device as a module. trying to modprobe/insmod it, I
get the
> following error message:
>
> unresolved symbol in loop.o: deactivate_page


You can apply below patch to fix this. Worked for me with no problem. This
was already discussed on the list and Linus said this would be the
appropriate fix.


diff -ru linux/drivers/block/loop.c linux-patched/drivers/block/loop.c
--- linux/drivers/block/loop.c  Tue Nov  6 10:41:15 2001
+++ linux-patched/drivers/block/loop.c  Tue Nov  6 10:43:51 2001
@@ -218,14 +218,12 @@
        index++;
        pos += size;
        UnlockPage(page);
-       deactivate_page(page);
        page_cache_release(page);
    }
    return 0;

 unlock:
    UnlockPage(page);
-   deactivate_page(page);
    page_cache_release(page);
 fail:
    return -1;

