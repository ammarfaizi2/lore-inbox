Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQLLAHD>; Mon, 11 Dec 2000 19:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131333AbQLLAGw>; Mon, 11 Dec 2000 19:06:52 -0500
Received: from catbert.rellim.com ([204.17.205.1]:49169 "EHLO
	catbert.rellim.com") by vger.kernel.org with ESMTP
	id <S129908AbQLLAGq>; Mon, 11 Dec 2000 19:06:46 -0500
Date: Mon, 11 Dec 2000 15:36:19 -0800 (PST)
From: "Gary E. Miller" <gem@rellim.com>
To: <linux-kernel@vger.kernel.org>
Subject: PATCH: SMBFS does not compile on test12-pre8
Message-ID: <Pine.LNX.4.30.0012111528531.28287-100000@catbert.rellim.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yo All!

Scott McDermott <vaxerdec@frontiernet.net> convinced me the way
to fix my problem with SMBFS was to use the INIT_LIST_HEAD() macro.

This allows SMBFS to compile and may even be correct:

--- sock.c.dist	Mon Dec 11 15:26:56 2000
+++ sock.c	Mon Dec 11 15:27:03 2000
@@ -163,7 +163,7 @@
 		found_data(sk);
 		return;
 	}
-	job->cb.next = NULL; // gem
+	INIT_LIST_HEAD(&job->cb.list);
 	job->cb.sync = 0;
 	job->cb.routine = smb_data_callback;
 	job->cb.data = job;

I am confused because INIT_LIST_HEAD() sets the next and prev
pointers to point to the current structure.  I just have to
assume the list folks know what they are doing and that is why they
made it a macro.

Could someone that knows lists and/or smbfs look at this?

RGDS
GARY
---------------------------------------------------------------------------
Gary E. Miller Rellim 20340 Empire Ave, Suite E-3, Bend, OR 97701
	gem@rellim.com  Tel:+1(541)382-8588 Fax: +1(541)382-8676


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
