Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263299AbRFAB1p>; Thu, 31 May 2001 21:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263304AbRFAB1f>; Thu, 31 May 2001 21:27:35 -0400
Received: from patan.Sun.COM ([192.18.98.43]:56749 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S263300AbRFAB1Z>;
	Thu, 31 May 2001 21:27:25 -0400
Message-ID: <3B16EFE0.D0C44FB8@sun.com>
Date: Thu, 31 May 2001 18:29:04 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davem@redhat.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: [PATCH] save source address on accept()
Content-Type: multipart/mixed;
 boundary="------------E18F680DD682FF74A7D63225"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E18F680DD682FF74A7D63225
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

attached is a (small) patch which saves the src address on tcp_accept(). 
Please let me know if there are any problems taking this for general
inclusion.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------E18F680DD682FF74A7D63225
Content-Type: text/plain; charset=us-ascii;
 name="tcp-saveaddr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tcp-saveaddr.diff"

diff -ruN dist-2.4.5/net/ipv4/tcp.c cobalt-2.4.5/net/ipv4/tcp.c
--- dist-2.4.5/net/ipv4/tcp.c	Wed May 16 10:31:27 2001
+++ cobalt-2.4.5/net/ipv4/tcp.c	Thu May 31 14:33:23 2001
@@ -2138,6 +2138,7 @@
 		tp->accept_queue_tail = NULL;
 
  	newsk = req->sk;
+	newsk->rcv_saddr = req->af.v4_req.loc_addr;
 	tcp_acceptq_removed(sk);
 	tcp_openreq_fastfree(req);
 	BUG_TRAP(newsk->state != TCP_SYN_RECV);

--------------E18F680DD682FF74A7D63225--

