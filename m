Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262594AbSJBVMp>; Wed, 2 Oct 2002 17:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262596AbSJBVMp>; Wed, 2 Oct 2002 17:12:45 -0400
Received: from lab1.ISTS.dartmouth.edu ([129.170.248.130]:52353 "EHLO
	karaya.com") by vger.kernel.org with ESMTP id <S262594AbSJBVMn>;
	Wed, 2 Oct 2002 17:12:43 -0400
Message-Id: <200210022120.g92LKjS26976@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML networking update
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Oct 2002 17:20:45 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull http://jdike.stearns.org:5000/net-2.5

It updates the UML networking by
	adding a transport that makes a pcap packet stream look like a UML
ethernet device
	cleaning up and simplifying the transport interface.

				Jeff

 arch/um/config_net.in                    |    1 
 arch/um/defconfig                        |    1 
 arch/um/drivers/Makefile                 |   17 ++
 arch/um/drivers/daemon_kern.c            |   90 +++++------
 arch/um/drivers/daemon_kern.h            |    8 -
 arch/um/drivers/mcast.h                  |    2 
 arch/um/drivers/mcast_kern.c             |  127 +++++++---------
 arch/um/drivers/mcast_kern.h             |    8 -
 arch/um/drivers/net_kern.c               |  234 ++++++++++++++++++++-----------
 arch/um/drivers/net_user.c               |   22 ++
 arch/um/drivers/pcap_kern.c              |  127 ++++++++++++++++
 arch/um/drivers/pcap_user.c              |  143 ++++++++++++++++++
 arch/um/drivers/pcap_user.h              |   31 ++++
 arch/um/drivers/slip_kern.c              |   57 +++----
 arch/um/drivers/slip_kern.h              |    8 -
 arch/um/include/net_kern.h               |   19 +-
 arch/um/include/net_user.h               |    4 
 arch/um/os-Linux/drivers/etap_kern.h     |   24 ---
 arch/um/os-Linux/drivers/ethertap_kern.c |   68 +++------
 arch/um/os-Linux/drivers/tuntap.h        |    2 
 arch/um/os-Linux/drivers/tuntap_kern.c   |   65 +++-----
 arch/um/os-Linux/drivers/tuntap_kern.h   |   24 ---
 22 files changed, 690 insertions(+), 392 deletions(-)

ChangeSet@1.669, 2002-10-02 15:09:13-04:00, jdike@uml.karaya.com
  Changed my mind about having CONFIG_UML_NET_PCAP enabled by default
  in defconfig.  This would cause the default config to break on
  any system without libpcap, so disabling it by default is better.

ChangeSet@1.668, 2002-10-02 15:01:35-04:00, jdike@uml.karaya.com
  Fixed a build bug with CONFIG_UML_NET_PCAP.

ChangeSet@1.667, 2002-10-02 12:12:16-04:00, jdike@uml.karaya.com
  Fixed a bit of the last merge which I messed up.

ChangeSet@1.666, 2002-10-02 11:48:30-04:00, jdike@uml.karaya.com
  Updated defconfig with CONFIG_UML_NET_PCAP.

ChangeSet@1.665, 2002-10-02 11:33:50-04:00, jdike@uml.karaya.com
  A bunch of network updates from 2.4.19.
  Added the pcap transport, which makes a pcap packet stream look
  like a network interface inside UML.
  Lifted the limit on the number of network interfaces.
  Cleaned up and simplified the transport interface.


