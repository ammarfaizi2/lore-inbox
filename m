Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVBUNsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVBUNsn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 08:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVBUNs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 08:48:26 -0500
Received: from mail.nuim.ie ([149.157.1.19]:28130 "EHLO LARCH.MAY.IE")
	by vger.kernel.org with ESMTP id S261969AbVBUNrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 08:47:37 -0500
Date: Mon, 21 Feb 2005 13:47:29 +0000
From: Yee-Ting Li <Yee-Ting.Li@nuim.ie>
Subject: BicTCP Implementation Bug
To: linux-net@vger.kernel.org, end2end-interest@postel.org,
       linux-kernel@vger.kernel.org
Cc: Douglas Leith <doug.leith@nuim.ie>,
       Richard Hughes-Jones <r.hughes-jones@man.ac.uk>,
       Baruch Even <baruch@ev-en.org>,
       Les Cottrell <cottrell@slac.stanford.edu>, davem@davemloft.net,
       rhee@ncsu.edu
Message-id: <fd9de42cb9cca9589da8a65bb6e719d5@may.ie>
MIME-version: 1.0
X-Mailer: Apple Mail (2.619.2)
Content-type: text/plain; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have discovered a serious implementation bug in BicTCP on the Linux 
kernels. Note that because BicTCP is ON by default, this affects all 
users of kernel versions 2.6.8 and above.

For further details please see: 
http://www.hamilton.ie/net/bic-fix/Linux%20BicTCP.pdf

and the patch is:

Index: linux-2.6.10/include/net/tcp.h
===================================================================
--- linux-2.6.10.orig/include/net/tcp.h Fri Dec 24 21:34:00 2004
+++ linux-2.6.10/include/net/tcp.h      Thu Feb 17 14:13:14 2005
@@ -1280,8 +1280,7 @@
                 if (sysctl_tcp_bic_fast_convergence &&
                     tp->snd_cwnd < tp->bictcp.last_max_cwnd)
                         tp->bictcp.last_max_cwnd
-                               = (tp->snd_cwnd * 
(2*BICTCP_1_OVER_BETA-1))
-                               / (BICTCP_1_OVER_BETA/2);
+                           = tp->snd_cwnd - ( tp->snd_cwnd / 
(BICTCP_1_OVER_BETA*2) );
                 else
                         tp->bictcp.last_max_cwnd = tp->snd_cwnd;

