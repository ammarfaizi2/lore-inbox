Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265474AbUGGVR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbUGGVR1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUGGVR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:17:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265474AbUGGVRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 17:17:24 -0400
Date: Wed, 7 Jul 2004 14:14:06 -0700
From: "David S. Miller" <davem@redhat.com>
To: Bryce Harrington <bryce@osdl.org>
Cc: akpm@osdl.org, wli@holomorphy.com, ltp-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, testdev@osdl.org
Subject: Re: [LTP] Re: Recent changes in LTP test results
Message-Id: <20040707141406.2a46cf82.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0407071334460.22452-100000@osdlab.pdx.osdl.net>
References: <20040706191009.279aed14.akpm@osdl.org>
	<Pine.LNX.4.33.0407071334460.22452-100000@osdlab.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004 13:48:52 -0700 (PDT)
Bryce Harrington <bryce@osdl.org> wrote:

> I have retested with ltp-full-20040603.  This version of LTP hangs on
> our system but fortunately completes most of the tests before doing so.
> It indicates that it still encounters the same errors, e.g.:

It hangs (actually, it OOPS's) on accept01, which is fixed in the current
BK sources via this patch:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/06 22:02:06-07:00 davem@nuts.davemloft.net 
#   [IPV4]: Set UDP accept back to sock_no_accept.
#   
#   Setting it to inet_accept causes UDP accept attempts
#   to OOPS.  In particular, accept01 from LTP tries this.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# net/ipv4/af_inet.c
#   2004/07/06 22:01:31-07:00 davem@nuts.davemloft.net +1 -1
#   [IPV4]: Set UDP accept back to sock_no_accept.
#   
#   Setting it to inet_accept causes UDP accept attempts
#   to OOPS.  In particular, accept01 from LTP tries this.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	2004-07-07 14:09:13 -07:00
+++ b/net/ipv4/af_inet.c	2004-07-07 14:09:13 -07:00
@@ -823,7 +823,7 @@
 	.bind =		inet_bind,
 	.connect =	inet_dgram_connect,
 	.socketpair =	sock_no_socketpair,
-	.accept =	inet_accept,
+	.accept =	sock_no_accept,
 	.getname =	inet_getname,
 	.poll =		datagram_poll,
 	.ioctl =	inet_ioctl,
