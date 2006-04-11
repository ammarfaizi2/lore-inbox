Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWDKEWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWDKEWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 00:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWDKEWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 00:22:23 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:32206 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751202AbWDKEWX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 00:22:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cR0/2s15byeu1Yuz5TNZmk1rZvxdP1gazaR+GBCUMTEB84EnCdIGPumnwqjqfzttD9Ewd6u/NnNjcGnzBX6MM8TZfeLQSx+wKBm2/A0a429xbWhvoK2QmALVh9V7HsFLnF4G98xvsmwWH12SVlGyqPvZ5VbhbGStuggqu9XNcug=
Message-ID: <6d6a94c50604102122vd3d116ah18c8b87c9095a01e@mail.gmail.com>
Date: Tue, 11 Apr 2006 12:22:21 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_PACKET_MMAP should depend on MMU
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The option CONFIG_PACKET_MMAP should depend on MMU.
When enable CONFIG_PACKET_MMAP, the file "af_packet.c" has
vm_insert_page() call.
The routine vm_insert_page() is defined in the file "./mm/memory.c"
which depends on MMU.

Signed-off-by: aubrey li <aubreylee@gmail.com>

--- Kconfig.orig        2006-04-11 12:17:25.000000000 +0800
+++ Kconfig     2006-04-11 12:16:18.000000000 +0800
@@ -17,7 +17,7 @@

 config PACKET_MMAP
        bool "Packet socket: mmapped IO"
-       depends on PACKET
+       depends on PACKET && MMU
        help
          If you say Y here, the Packet protocol driver will use an IO
          mechanism that results in faster communication.

Thanks,
-Aubrey
