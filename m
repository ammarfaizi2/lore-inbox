Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKCWeI>; Fri, 3 Nov 2000 17:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130543AbQKCWd6>; Fri, 3 Nov 2000 17:33:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55462 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129033AbQKCWdk>;
	Fri, 3 Nov 2000 17:33:40 -0500
Date: Fri, 3 Nov 2000 14:18:35 -0800
Message-Id: <200011032218.OAA12790@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: phil@fifi.org
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <87n1fgvl7a.fsf@tantale.fifi.org> (message from Philippe Troin on
	03 Nov 2000 12:45:29 -0800)
Subject: Re: 2.2.x BUG & PATCH: recvmsg() does not check msg_controllen correctly
In-Reply-To: <87n1fgvl7a.fsf@tantale.fifi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The real bug is in the setting of MSG_TRUNC (which is the only side
effect of your change).  So the better fix is:

--- net/core/scm.c.~1~	Tue Jun 15 09:19:30 1999
+++ net/core/scm.c	Fri Nov  3 14:18:06 2000
@@ -251,7 +251,7 @@
 			msg->msg_controllen -= cmlen;
 		}
 	}
-	if (i < fdnum)
+	if (i < fdnum || (fdnum && fdmax <= 0))
 		msg->msg_flags |= MSG_CTRUNC;
 
 	/*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
