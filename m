Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTJMLmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbTJMLmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:42:25 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:33952 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id S261687AbTJMLmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:42:22 -0400
Date: Mon, 13 Oct 2003 13:42:20 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.0-test6-mm1] Problem in hotplug?
Message-ID: <20031013114220.GA21177@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

I've found some strange behavior of kernel:

# ps -afx
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:05 init [2]  
    2 ?        SWN    0:00 [ksoftirqd/0]
    3 ?        SW<    0:01 [events/0]
   99 ?        Z<     0:00  \_ [events/0] <defunct>
  112 ?        Z<     0:00  \_ [hotplug] <defunct>
  113 ?        Z<     0:00  \_ [hotplug] <defunct>
  114 ?        Z<     0:00  \_ [hotplug] <defunct>
  127 ?        Z<     0:00  \_ [hotplug] <defunct>
  136 ?        Z<     0:00  \_ [hotplug] <defunct>
  142 ?        Z<     0:00  \_ [hotplug] <defunct>
  148 ?        Z<     0:00  \_ [hotplug] <defunct>
  153 ?        Z<     0:00  \_ [hotplug] <defunct>
  159 ?        Z<     0:00  \_ [hotplug] <defunct>
  165 ?        Z<     0:00  \_ [hotplug] <defunct>
  170 ?        Z<     0:00  \_ [hotplug] <defunct>
  176 ?        Z<     0:00  \_ [hotplug] <defunct>
  218 ?        Z<     0:00  \_ [hotplug] <defunct>
  224 ?        Z<     0:00  \_ [hotplug] <defunct>
 1233 ?        Z<     0:00  \_ [hotplug] <defunct>
 1238 ?        Z<     0:00  \_ [hotplug] <defunct>
 1239 ?        Z<     0:00  \_ [hotplug] <defunct>
 1254 ?        Z<     0:00  \_ [hotplug] <defunct>
 1350 ?        Z<     0:00  \_ [events/0] <defunct>
 2290 ?        Z<     0:00  \_ [hotplug] <defunct>
 2291 ?        Z<     0:00  \_ [hotplug] <defunct>
 2321 ?        Z<     0:00  \_ [hotplug] <defunct>
 2326 ?        Z<     0:00  \_ [hotplug] <defunct>
 2335 ?        Z<     0:00  \_ [hotplug] <defunct>
 2467 ?        Z<     0:00  \_ [events/0] <defunct>
 2474 ?        Z<     0:00  \_ [hotplug] <defunct>
 2479 ?        Z<     0:00  \_ [hotplug] <defunct>
 2484 ?        Z<     0:00  \_ [hotplug] <defunct>
 2490 ?        Z<     0:00  \_ [events/0] <defunct>
 2492 ?        Z<     0:00  \_ [events/0] <defunct>
 5949 ?        Z<     0:00  \_ [hotplug] <defunct>
 5951 ?        Z<     0:00  \_ [hotplug] <defunct>
 5953 ?        Z<     0:00  \_ [hotplug] <defunct>
 5955 ?        Z<     0:00  \_ [hotplug] <defunct>
 6901 ?        Z<     0:00  \_ [hotplug] <defunct>
 6902 ?        Z<     0:00  \_ [hotplug] <defunct>
 6905 ?        Z<     0:00  \_ [hotplug] <defunct>
 6936 ?        Z<     0:00  \_ [hotplug] <defunct>
 6937 ?        Z<     0:00  \_ [hotplug] <defunct>
 6938 ?        Z<     0:00  \_ [hotplug] <defunct>
 6939 ?        Z<     0:00  \_ [hotplug] <defunct>
 6940 ?        Z<     0:00  \_ [hotplug] <defunct>
 7014 ?        Z<     0:00  \_ [hotplug] <defunct>
 7019 ?        Z<     0:00  \_ [hotplug] <defunct>
 7024 ?        Z<     0:00  \_ [hotplug] <defunct>
 7035 ?        Z<     0:00  \_ [hotplug] <defunct>
 7042 ?        Z<     0:00  \_ [hotplug] <defunct>
 7050 ?        Z<     0:00  \_ [hotplug] <defunct>
 7072 ?        Z<     0:00  \_ [hotplug] <defunct>
 7078 ?        Z<     0:00  \_ [hotplug] <defunct>
 7088 ?        Z<     0:00  \_ [hotplug] <defunct>
 7093 ?        Z<     0:00  \_ [hotplug] <defunct>
 7098 ?        Z<     0:00  \_ [hotplug] <defunct>
 7103 ?        Z<     0:00  \_ [hotplug] <defunct>
 7108 ?        Z<     0:00  \_ [hotplug] <defunct>
 7113 ?        Z<     0:00  \_ [hotplug] <defunct>
 7118 ?        Z<     0:00  \_ [hotplug] <defunct>
 7129 ?        Z<     0:00  \_ [hotplug] <defunct>
25947 ?        Z<     0:00  \_ [events/0] <defunct>
14496 ?        Z<     0:00  \_ [hotplug] <defunct>
14503 ?        Z<     0:00  \_ [hotplug] <defunct>
14508 ?        Z<     0:00  \_ [hotplug] <defunct>
14514 ?        Z<     0:00  \_ [hotplug] <defunct>
    4 ?        SW<    0:07 [kblockd/0]
    5 ?        SW     0:00 [khubd]
    6 ?        SW     0:02 [kapmd]
    9 ?        SW     1:18 [kswapd0]
   10 ?        SW<    0:00 [aio/0]
   11 ?        SW<    0:00 [aio_fput/0]
   12 ?        SW<    0:03 [xfslogd/0]
   13 ?        SW<    0:00 [xfsdatad/0]
   14 ?        SW     0:00 [pagebufd]
   16 ?        SW     0:00 [kseriod]
   17 ?        SW     0:00 [i2oevtd]
   18 ?        SW     0:00 [i2oblock]
   19 ?        SW     0:00 [xfs_syncd]
   33 ?        S      0:00 /sbin/devfsd /dev
  587 ?        S      0:06 /sbin/syslog-ng
  ...etc...

I'm using package hotplug from Debian sid distro:
ii  hotplug        0.0.20031008-1 Linux Hotplug Scripts

I think, its abnormal operation: what if kernel will have not free PID?

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
