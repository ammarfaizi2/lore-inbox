Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263059AbSJHWma>; Tue, 8 Oct 2002 18:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263153AbSJHWma>; Tue, 8 Oct 2002 18:42:30 -0400
Received: from jdike.solana.com ([198.99.130.100]:31106 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S263059AbSJHWmX>;
	Tue, 8 Oct 2002 18:42:23 -0400
Message-Id: <200210082250.g98Mokx18208@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML network changes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Oct 2002 18:50:46 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull http://jdike.stearns.org/net-2.5

It makes a number of networking changes to UML
	Adds the pcap transport which makes a pcap packet stream look like
an ethernet device
	Removes the restriction of the number of network interfaces a UML
can have
	Cleans up the code

				Jeff


 arch/um/config_net.in                    |    1 
 arch/um/defconfig                        |    1 
 arch/um/drivers/Makefile                 |   17 +
 arch/um/drivers/daemon_kern.c            |   90 ++++------
 arch/um/drivers/daemon_kern.h            |    8 
 arch/um/drivers/mcast.h                  |    2 
 arch/um/drivers/mcast_kern.c             |  127 ++++++--------
 arch/um/drivers/mcast_kern.h             |    8 
 arch/um/drivers/net_kern.c               |  268 +++++++++++++++++++++----------
 arch/um/drivers/net_user.c               |   22 ++
 arch/um/drivers/pcap_kern.c              |  127 ++++++++++++++
 arch/um/drivers/pcap_user.c              |  143 ++++++++++++++++
 arch/um/drivers/pcap_user.h              |   31 +++
 arch/um/drivers/port_kern.c              |    2 
 arch/um/drivers/slip_kern.c              |   57 +++---
 arch/um/drivers/slip_kern.h              |    8 
 arch/um/include/kern.h                   |    1 
 arch/um/include/net_kern.h               |   19 +-
 arch/um/include/net_user.h               |    4 
 arch/um/include/time_user.h              |   17 +
 arch/um/include/user_util.h              |    6 
 arch/um/kernel/process.c                 |    1 
 arch/um/kernel/process_kern.c            |    1 
 arch/um/kernel/time.c                    |   22 ++
 arch/um/kernel/time_kern.c               |    1 
 arch/um/kernel/tlb.c                     |    2 
 arch/um/kernel/trap_user.c               |    8 
 arch/um/os-Linux/drivers/etap_kern.h     |   24 --
 arch/um/os-Linux/drivers/ethertap_kern.c |   68 +++----
 arch/um/os-Linux/drivers/tuntap.h        |    2 
 arch/um/os-Linux/drivers/tuntap_kern.c   |   65 +++----
 arch/um/os-Linux/drivers/tuntap_kern.h   |   24 --
 include/asm-um/pgtable.h                 |   20 +-

ChangeSet@1.710, 2002-10-07 20:26:32-04:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/net

ChangeSet@1.663.11.5, 2002-10-02 15:09:13-04:00, jdike@uml.karaya.com
  Changed my mind about having CONFIG_UML_NET_PCAP enabled by default
  in defconfig.  This would cause the default config to break on
  any system without libpcap, so disabling it by default is better.

ChangeSet@1.663.11.4, 2002-10-02 15:01:35-04:00, jdike@uml.karaya.com
  Fixed a build bug with CONFIG_UML_NET_PCAP.

ChangeSet@1.663.11.3, 2002-10-02 12:12:16-04:00, jdike@uml.karaya.com
  Fixed a bit of the last merge which I messed up.

ChangeSet@1.663.11.2, 2002-10-02 11:48:30-04:00, jdike@uml.karaya.com
  Updated defconfig with CONFIG_UML_NET_PCAP.

ChangeSet@1.663.11.1, 2002-10-02 11:33:50-04:00, jdike@uml.karaya.com
  A bunch of network updates from 2.4.19.
  Added the pcap transport, which makes a pcap packet stream look
  like a network interface inside UML.
  Lifted the limit on the number of network interfaces.
  Cleaned up and simplified the transport interface.

ChangeSet@1.663.3.1, 2002-10-01 10:02:05-04:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5

ChangeSet@1.579.15.2, 2002-09-23 21:09:49-04:00, jdike@uml.karaya.com
  Removed from user_util.h the declarations that are now in time_user.h.

ChangeSet@1.579.15.1, 2002-09-23 20:38:01-04:00, jdike@uml.karaya.com
  A number of bug fixes from UML 2.4.19-6 -
  
  Fixed the net crash seen when slab debugging is enabled
  Fixed PROT_NONE
  Fixed the 'tracing myself' bug seen on umlcoop.  This was caused by
  a number of SIGALRM handlers nesting on the idle thread stack because
  the system was busy enough that UML couldn't clear one before the
  next arrived.

