Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270495AbTGNC0w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 22:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270496AbTGNC0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 22:26:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:149 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S270495AbTGNC0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 22:26:50 -0400
Date: Mon, 14 Jul 2003 03:41:00 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH]: Set SOCK_DONE when TCP socket receives FIN
Message-ID: <20030714024100.GA23023@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SOCK_DONE flag is always clear and never set in 2.5.75.  Yet there
is code which tests it, and if it's clear, will return -ENOTCONN.
Admittedly I am confused as to how this is not noticed :)

This small patch sets it where it looks like it was intended.
Please check.

Enjoy,
-- Jamie

diff -ur orig-2.5.75/net/ipv4/tcp_input.c build-2.5.75/net/ipv4/tcp_input.c
--- orig-2.5.75/net/ipv4/tcp_input.c	2003-07-12 17:57:38.000000000 +0100
+++ build-2.5.75/net/ipv4/tcp_input.c	2003-07-14 02:29:15.000000000 +0100
@@ -2373,7 +2373,7 @@
 	tcp_schedule_ack(tp);
 
 	sk->sk_shutdown |= RCV_SHUTDOWN;
-	sock_reset_flag(sk, SOCK_DONE);
+	sock_set_flag(sk, SOCK_DONE);
 
 	switch (sk->sk_state) {
 		case TCP_SYN_RECV:
