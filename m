Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUCATsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 14:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbUCATsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 14:48:36 -0500
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:47108 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S261410AbUCATse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 14:48:34 -0500
Message-ID: <4043938C.9090504@lbsd.net>
Date: Mon, 01 Mar 2004 19:48:28 +0000
From: Nigel Kukard <nkukard@lbsd.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.3] Sysfs breakage - tun.ko
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Loading tun.ko module breaks on sysfs...

 > [root@localhost misc]# pwd
 > /sys/class/misc
 > [root@localhost misc]# ls
 > dac960_gam  device-mapper  net/tun  psaux
 > [root@localhost misc]# cd net\/tun
 > bash: cd: net/tun: No such file or directory
 > [root@localhost misc]#


Why not just make it in misc? why net/tun seeing as everything else is 
just dumped there. Patch below.



--- drivers/net/tun.c.old   2004-02-27 18:18:55.000000000 +0200
+++ drivers/net/tun.c       2004-02-27 18:19:02.000000000 +0200
@@ -605,7 +605,7 @@

  static struct miscdevice tun_miscdev = {
         .minor = TUN_MINOR,
-       .name = "net/tun",
+       .name = "tun",
         .fops = &tun_fops
  };

