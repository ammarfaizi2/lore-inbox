Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTEDXka (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 19:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTEDXka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 19:40:30 -0400
Received: from qix.net ([207.40.214.9]:9745 "EHLO neocygnus.qix.net")
	by vger.kernel.org with ESMTP id S261840AbTEDXk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 19:40:29 -0400
Subject: [TRIVIAL][PATCH 2.4] Help dummies configure QoS
From: Dave Maietta <dave@qix.net>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1052092397.5844.33.camel@hell>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 May 2003 19:53:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the packet schedulers section of the config scripts, neither the
Ingress Qdisc nor any comment about its existence are displayed in
Menuconfig if some dependencies are not met in other places.  To help
dummies like me know that it's there, please consider the following
patch:

--- linux/net/sched/Config.in.orig	2003-05-04 18:50:54.000000000 -0400
+++ linux/net/sched/Config.in	2003-05-04 18:43:32.000000000 -0400
@@ -16,9 +16,6 @@
 tristate '  TBF queue' CONFIG_NET_SCH_TBF
 tristate '  GRED queue' CONFIG_NET_SCH_GRED
 tristate '  Diffserv field marker' CONFIG_NET_SCH_DSMARK
-if [ "$CONFIG_NETFILTER" = "y" ]; then
-   tristate '  Ingress Qdisc' CONFIG_NET_SCH_INGRESS
-fi
 bool '  QoS support' CONFIG_NET_QOS
 if [ "$CONFIG_NET_QOS" = "y" ]; then
    bool '    Rate estimator' CONFIG_NET_ESTIMATOR
@@ -38,4 +35,12 @@
       bool '    Traffic policing (needed for in/egress)'
CONFIG_NET_CLS_POLICE
    fi
 fi
+if [ "$CONFIG_NETFILTER" = "n" -o "$CONFIG_NET_QOS" = "n" -o \
+   "$CONFIG_NET_CLS" = "n" -o "$CONFIG_NET_CLS_POLICE" = "n" ]; then
+   comment '  Ingress Qdisc:  To enable, please include'
+   comment '    Network Packet Filtering, QoS Support,'
+   comment '    and Packet Classifier API/Traffic Policing'
+else
+   tristate '  Ingress Qdisc' CONFIG_NET_SCH_INGRESS
+fi
 


Thanks,
Dave Maietta
dave$qix,net

