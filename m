Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbUKSKDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUKSKDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 05:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbUKSKDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 05:03:17 -0500
Received: from dachs.cyberlink.ch ([62.12.136.4]:20960 "HELO
	dachs.cyberlink.ch") by vger.kernel.org with SMTP id S261336AbUKSKDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 05:03:14 -0500
X-Qmail-Scanner-Mail-From: manfred99@gmx.ch via dachs
X-Qmail-Scanner: 1.16 (Clear:. Processed in 0.069911 secs)
From: Manfred Schwarb <manfred99@gmx.ch>
To: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, patrick@tykepenguin.com
Cc: Manfred Schwarb <manfred99@gmx.ch>
Message-Id: <20041119100310.32498.18004.31511@tp-meteodat6.cyberlink.ch>
Subject: [2.4.28] Build Error 1: missing THIS_MODULE in dn_neigh.c
Date: Fri, 19 Nov 2004 05:03:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
building vanilla 2.4.28, I got this:

dn_neigh.c:584: error: `THIS_MODULE' undeclared here (not in a function)
dn_neigh.c:584: error: initializer element is not constant
dn_neigh.c:584: error: (near initialization for `dn_neigh_seq_fops.owner')
make[2]: *** [dn_neigh.o] Error 1
make[1]: *** [_modsubdir_decnet] Error 2
make: *** [_mod_net] Error 2


I think, a patch could look like this:

--- linux-2.4.28/net/decnet/dn_neigh.c.orig	2004-11-18 22:24:38.000000000 +0100
+++ linux-2.4.28/net/decnet/dn_neigh.c	2004-11-18 22:25:24.000000000 +0100
@@ -26,6 +26,7 @@
 
 #include <linux/config.h>
 #include <linux/net.h>
+#include <linux/module.h>
 #include <linux/socket.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
