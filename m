Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265746AbUF2MjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265746AbUF2MjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 08:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUF2MjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 08:39:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15848 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265746AbUF2MjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 08:39:03 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16609.25187.339622.762531@segfault.boston.redhat.com>
Date: Tue, 29 Jun 2004 08:36:51 -0400
To: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
In-Reply-To: <16608.20014.220537.339589@segfault.boston.redhat.com>
References: <16519.58589.773562.492935@segfault.boston.redhat.com>
	<20040425191543.GV28459@waste.org>
	<16527.42815.447695.474344@segfault.boston.redhat.com>
	<20040428140353.GC28459@waste.org>
	<16527.47765.286783.249944@segfault.boston.redhat.com>
	<20040428142753.GE28459@waste.org>
	<16527.63123.869014.733258@segfault.boston.redhat.com>
	<16604.18881.850162.785970@segfault.boston.redhat.com>
	<20040625232711.GE25826@waste.org>
	<16608.12233.39964.940020@segfault.boston.redhat.com>
	<20040628151954.GH25826@waste.org>
	<16608.20014.220537.339589@segfault.boston.redhat.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[snip]

@@ -70,9 +73,12 @@
 	np->dev->poll_controller(np->dev);
 
 	/* If scheduling is stopped, tickle NAPI bits */
-	if(trapped && np->dev->poll &&
-	   test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
+	if (np->dev->poll && 
+	    test_bit(__LINK_STATE_RX_SCHED, &np->dev->state)) {
+		np->dev->netpoll_rx |= NETPOLL_RX_DROP;
 		np->dev->poll(np->dev, &budget);
+		np->dev->netpoll_rx &= ~NETPOLL_RX_DROP;
+	}
 	zap_completion_queue();
 }
 
Silly me.  This still needs to set trapped (and still needs more thinking
about smp issues).

-Jeff
