Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268919AbUHUI6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268919AbUHUI6n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268918AbUHUI6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:58:43 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:65260 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268939AbUHUI61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:58:27 -0400
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
From: Lee Revell <rlrevell@joe-job.com>
To: Josan Kadett <corporate@superonline.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1093078213.854.76.camel@krustophenia.net>
References: <1093078213.854.76.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1093078705.854.77.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 04:58:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 05:50, Josan Kadett wrote:
> Here is the very original linux-kernel mailing list, and if I cannot find an
> answer here, then nowhere on earth can this answer be found. I also saw some
> other messages regarding the same issue on the net. None of them is answered
> correctly; and also as if this is a very "forbidden" thing to disable the
> checksums, most replies are as if they are "unbreakable rules of god".
> Really, I am losing my patience with this. It is also very odd to write a
> low-level application in order to just disable a "feature" of the kernel to
> deal with a faulty piece of embedded firmware.
> 

Try this.  I have no idea whether it will work.  If it breaks you get to
keep both halves.

--- net/ipv4/tcp_input.c	2004-08-20 16:37:12.000000000 -0400
+++ net/ipv4/tcp_input.c-new	2004-08-21 04:56:51.000000000 -0400
@@ -4234,8 +4234,7 @@
 				}
 			}
 			if (!eaten) {
-				if (tcp_checksum_complete_user(sk, skb))
-					goto csum_error;
+				tcp_checksum_complete_user(sk, skb);
 
 				/* Predicted packet is in window by definition.
 				 * seq == rcv_nxt and rcv_wup <= rcv_nxt.
@@ -4291,7 +4290,7 @@
 
 slow_path:
 	if (len < (th->doff<<2) || tcp_checksum_complete_user(sk, skb))
-		goto csum_error;
+		;
 
 	/*
 	 * RFC1323: H1. Apply PAWS check first.

Lee

