Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264402AbUFPXqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUFPXqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 19:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUFPXqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 19:46:15 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:40905 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264402AbUFPXqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 19:46:11 -0400
Date: Wed, 16 Jun 2004 19:48:04 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH][2.6] fix bridge sysfs improperly initialised knobject
Message-ID: <Pine.LNX.4.58.0406161247140.1944@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bridge sysfs interface introduced around 2.6.7-rc1 created a bad
entry in /sys because it didn't initialise the name member of the kobject.

zwane@montezuma /sys {0:0} ls -l
total 0
?---------   ? ?    ?    ?            ?
drwxr-xr-x  17 root root 0 Jun 15 15:47 block
drwxr-xr-x   7 root root 0 Jun 15 15:47 bus
drwxr-xr-x  16 root root 0 Jun 15 15:47 class
drwxr-xr-x   5 root root 0 Jun 15 15:47 devices
drwxr-xr-x   3 root root 0 Jun 15 15:47 firmware
drwxr-xr-x   8 root root 0 Jun 15 19:55 module

Index: linux-2.6.7-rc3-mm2/net/bridge/br_sysfs_br.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-rc3-mm2/net/bridge/br_sysfs_br.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 br_sysfs_br.c
--- linux-2.6.7-rc3-mm2/net/bridge/br_sysfs_br.c	14 Jun 2004 12:49:12 -0000	1.1.1.1
+++ linux-2.6.7-rc3-mm2/net/bridge/br_sysfs_br.c	16 Jun 2004 16:45:20 -0000
@@ -305,9 +305,7 @@ static struct bin_attribute bridge_forwa
  * This is a dummy kset so bridge objects don't cause
  * hotplug events
  */
-struct subsystem bridge_subsys = {
-	.kset = { .hotplug_ops = NULL },
-};
+decl_subsys_name(bridge, net_bridge, NULL, NULL);

 void br_sysfs_init(void)
 {
