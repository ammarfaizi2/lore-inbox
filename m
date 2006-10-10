Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWJJRUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWJJRUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWJJRQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:16:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:55945 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964825AbWJJRPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:15:40 -0400
Date: Tue, 10 Oct 2006 10:14:29 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Chuck Lever <chuck.lever@oracle.com>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC traffic
Message-ID: <20061010171429.GD6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sunrpc-avoid-choosing-an-ipmi-port-for-rpc-traffic.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Chuck Lever <chuck.lever@oracle.com>

Some hardware uses port 664 for its hardware-based IPMI listener.  Teach
the RPC client to avoid using that port by raising the default minimum port
number to 665.

Test plan:
Find a mainboard known to use port 664 for IPMI; enable IPMI; mount NFS
servers in a tight loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/sunrpc/xprt.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.13.orig/include/linux/sunrpc/xprt.h
+++ linux-2.6.17.13/include/linux/sunrpc/xprt.h
@@ -37,7 +37,7 @@ extern unsigned int xprt_max_resvport;
 
 #define RPC_MIN_RESVPORT	(1U)
 #define RPC_MAX_RESVPORT	(65535U)
-#define RPC_DEF_MIN_RESVPORT	(650U)
+#define RPC_DEF_MIN_RESVPORT	(665U)
 #define RPC_DEF_MAX_RESVPORT	(1023U)
 
 /*

--
