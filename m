Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbUKWXsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbUKWXsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUKWXqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:46:42 -0500
Received: from mail.dif.dk ([193.138.115.101]:31969 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261631AbUKWXpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:45:30 -0500
Date: Wed, 24 Nov 2004 00:55:03 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: lksctp developers <lksctp-developers@lists.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix weird placement of inline and static keywords in sctp.h
Message-ID: <Pine.LNX.4.61.0411240046310.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch that moves the keywords  inline  and  static  to the 
beginning of the declaration for a few functions in sctp.h

This has no impact on functionality and is completely safe, the only 
bennefit is less cluttered output from the compiler when building with 
gcc -W .  This is nice for people like me who build with -W to find 
potential troublespots to review (the less warnings to sift through the 
better). I can find no argument against fixing this.

This patch elliminates a whole bunch of 
include/net/sctp/sctp.h:610: warning: `static' is not at beginning of declaration
include/net/sctp/sctp.h:610: warning: `inline' is not at beginning of declaration
include/net/sctp/sctp.h:617: warning: `static' is not at beginning of declaration
include/net/sctp/sctp.h:617: warning: `inline' is not at beginning of declaration
include/net/sctp/sctp.h:625: warning: `static' is not at beginning of declaration
include/net/sctp/sctp.h:625: warning: `inline' is not at beginning of declaration
when building with -W

Please consider applying.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk6-orig/include/net/sctp/sctp.h linux-2.6.10-rc2-bk6/include/net/sctp/sctp.h
--- linux-2.6.10-rc2-bk6-orig/include/net/sctp/sctp.h	2004-11-17 01:20:27.000000000 +0100
+++ linux-2.6.10-rc2-bk6/include/net/sctp/sctp.h	2004-11-24 00:33:41.000000000 +0100
@@ -607,14 +607,14 @@ struct sctp6_sock {
 
 /* Is a socket of this style? */
 #define sctp_style(sk, style) __sctp_style((sk), (SCTP_SOCKET_##style))
-int static inline __sctp_style(const struct sock *sk, sctp_socket_type_t style)
+static inline int __sctp_style(const struct sock *sk, sctp_socket_type_t style)
 {
 	return sctp_sk(sk)->type == style;
 }
 
 /* Is the association in this state? */
 #define sctp_state(asoc, state) __sctp_state((asoc), (SCTP_STATE_##state))
-int static inline __sctp_state(const struct sctp_association *asoc,
+static inline int __sctp_state(const struct sctp_association *asoc,
 			       sctp_state_t state)
 {
 	return asoc->state == state;
@@ -622,7 +622,7 @@ int static inline __sctp_state(const str
 
 /* Is the socket in this state? */
 #define sctp_sstate(sk, state) __sctp_sstate((sk), (SCTP_SS_##state))
-int static inline __sctp_sstate(const struct sock *sk, sctp_sock_state_t state)
+static inline int __sctp_sstate(const struct sock *sk, sctp_sock_state_t state)
 {
 	return sk->sk_state == state;
 }



Please CC me on replies from the lksctp developers list.



