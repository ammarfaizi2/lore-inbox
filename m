Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130913AbQLJWyH>; Sun, 10 Dec 2000 17:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131014AbQLJWx5>; Sun, 10 Dec 2000 17:53:57 -0500
Received: from [212.32.186.211] ([212.32.186.211]:59608 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S130913AbQLJWxu>; Sun, 10 Dec 2000 17:53:50 -0500
Date: Sun, 10 Dec 2000 23:23:14 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre8
In-Reply-To: <3A33E0DE.81720F77@haque.net>
Message-ID: <Pine.LNX.4.21.0012102259450.21029-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Mohammad A. Haque wrote:

> Could someome who knows what they are doing check over the following
> patch please?

I wouldn't say that I do, but no one else seems to be answering this.
list_add_tail does head->prev and making the call with a NULL 'head' looks
bad to me. I would prefer:

diff -ur -X exclude linux-2.4.0-test12-pre8-orig/fs/smbfs/sock.c linux-2.4.0-test12-pre8-smbfs/fs/smbfs/sock.c
--- linux-2.4.0-test12-pre8-orig/fs/smbfs/sock.c	Sun Dec 10 21:01:16 2000
+++ linux-2.4.0-test12-pre8-smbfs/fs/smbfs/sock.c	Sun Dec 10 23:07:15 2000
@@ -163,7 +163,7 @@
 		found_data(sk);
 		return;
 	}
-	job->cb.next = NULL;
+	INIT_LIST_HEAD(&job->cb.list);
 	job->cb.sync = 0;
 	job->cb.routine = smb_data_callback;
 	job->cb.data = job;

or just leaving the list as it is. It will be initialized anyway by
schedule_task (queue_task), but using the init macro seems like a nice
thing to do.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
