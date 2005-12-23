Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbVLWWcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbVLWWcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbVLWWcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:32:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:43720 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161086AbVLWW2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:28:43 -0500
Date: Fri, 23 Dec 2005 14:27:36 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [patch 05/11] tcp: BIC max increment too large
Message-ID: <20051223222736.GF18252@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="tcp-bic-max-increment-too-large.patch"
In-Reply-To: <20051223222652.GA18252@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>

The max growth of BIC TCP is too large. Original code was based on
BIC 1.0 and the default there was 32. Later code (2.6.13) included
compensation for delayed acks, and should have reduced the default
value to 16; since normally TCP gets one ack for every two packets sent.

The current value of 32 makes BIC too aggressive and unfair to other
flows.

Submitted-by: Injong Rhee <rhee@eos.ncsu.edu>
Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/tcp_bic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.1.orig/net/ipv4/tcp_bic.c
+++ linux-2.6.14.1/net/ipv4/tcp_bic.c
@@ -27,7 +27,7 @@
 					  */
 
 static int fast_convergence = 1;
-static int max_increment = 32;
+static int max_increment = 16;
 static int low_window = 14;
 static int beta = 819;		/* = 819/1024 (BICTCP_BETA_SCALE) */
 static int low_utilization_threshold = 153;

--
