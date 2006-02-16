Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWBPFqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWBPFqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 00:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWBPFqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 00:46:05 -0500
Received: from [203.2.177.25] ([203.2.177.25]:39948 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S932485AbWBPFqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 00:46:03 -0500
Subject: [PATCH 4/6] x25: Allow 32 bit socket ioctl in 64 bit kernel
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 16:44:13 +1100
Message-Id: <1140068654.4941.22.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

32 bit modular socket ioctl emulation for 64 bit kernel

This patch allows an x25 server application to run on a 64 bit kernel, by
fixing the following error message from the kernel. 

T2 kernel: schedule_timeout:
 wrong timeout value ffffffffffffffff from ffffffff88164796
  
Signed-off-by:Shaun Pereira <spereira@tusc.com.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>

diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/net/x25/af_x25.c linux-2.6.16-rc3/net/x25/af_x25.c
--- linux-2.6.16-rc3-vanilla/net/x25/af_x25.c	2006-02-16 15:28:58.000000000 +1100
+++ linux-2.6.16-rc3/net/x25/af_x25.c	2006-02-16 15:29:04.000000000 +1100
@@ -743,7 +743,7 @@ out:
 	return rc;
 }
 
-static int x25_wait_for_data(struct sock *sk, int timeout)
+static int x25_wait_for_data(struct sock *sk, long timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int rc = 0;

