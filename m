Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbSJYIyc>; Fri, 25 Oct 2002 04:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSJYIyc>; Fri, 25 Oct 2002 04:54:32 -0400
Received: from cygnus-ext.enyo.de ([212.9.189.162]:58372 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S261320AbSJYIyb>;
	Fri, 25 Oct 2002 04:54:31 -0400
To: linux-kernel@vger.kernel.org
Subject: [SECURITY] CERT/CC VU#464113, SYN plus RST/FIN
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 25 Oct 2002 11:00:43 +0200
Message-ID: <87vg3qq4ec.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents SYN+RST and SYN+FIN segments which arrive in the
LISTEN state from initiating a three-way handshake.

I'm not sure if it is correct, but it's better than nothing (so far, I
haven't seen any patch for this issue).

--- tcp_input.c	2002/10/25 08:45:20	1.1
+++ tcp_input.c	2002/10/25 08:49:21
@@ -3668,6 +3668,8 @@
 	case TCP_LISTEN:
 		if(th->ack)
 			return 1;
+		if(th->rst || th->fin)
+			goto discard;
 
 		if(th->syn) {
 			if(tp->af_specific->conn_request(sk, skb) < 0)

