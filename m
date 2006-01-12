Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWALGDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWALGDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWALGDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:03:51 -0500
Received: from [203.2.177.25] ([203.2.177.25]:34876 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1030307AbWALGDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:03:49 -0500
Subject: [PATCH 4/4 -2.6.15]: 32 bit (socket layer) ioctl emulation for 64
	bit kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Andi Kleen <ak@muc.de>, linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>,
       "David S. Miller" <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 17:03:43 +1100
Message-Id: <1137045823.5221.25.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small fix for the following error, when trying to run a 64 bit x25
server application.

T2 kernel: schedule_timeout: 
 wrong timeout value ffffffffffffffff from ffffffff88164796

diff -uprN -X dontdiff linux-2.6.15-vanilla/net/x25/af_x25.c
linux-2.6.15/net/x25/af_x25.c
--- linux-2.6.15-vanilla/net/x25/af_x25.c	2006-01-12 16:15:46.000000000
+1100
+++ linux-2.6.15/net/x25/af_x25.c	2006-01-12 16:14:27.000000000 +1100
@@ -747,7 +747,7 @@ out:
 	return rc;
 }
 
-static int x25_wait_for_data(struct sock *sk, int timeout)
+static int x25_wait_for_data(struct sock *sk, long timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int rc = 0;


