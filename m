Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132523AbQKKVBQ>; Sat, 11 Nov 2000 16:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132522AbQKKVBH>; Sat, 11 Nov 2000 16:01:07 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:28937 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132521AbQKKVAw>; Sat, 11 Nov 2000 16:00:52 -0500
Date: Sat, 11 Nov 2000 21:01:53 GMT
Message-Id: <200011112101.VAA31747@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda6 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda6 (was: Re: The IrDA patches)
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are the new IrDA patches for Linux-2.4.0-test10. Please apply them to
your latest 2.4 code. If you decide to apply them, then I suggest you start
with the first one (irda1.diff) and work your way to the last one 
(irda24.diff) since most of them are not commutative. 

The name of this patch is irda6.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda6.diff :
----------------
	o [CORRECT] Handle properly the MSG_EOR flag on SEQPACKET sockets

idiff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 13:36:27 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 13:37:09 2000
@@ -1291,7 +1291,8 @@ static int irda_sendmsg(struct socket *s
 
 	IRDA_DEBUG(4, __FUNCTION__ "(), len=%d\n", len);
 
-	if (msg->msg_flags & ~MSG_DONTWAIT)
+	/* Note : socket.c set MSG_EOR on SEQPACKET sockets */
+	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_EOR))
 		return -EINVAL;
 
 	if (sk->shutdown & SEND_SHUTDOWN) {


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
