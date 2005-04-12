Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVDLFDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVDLFDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVDLFBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:01:35 -0400
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:19588 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261980AbVDLDXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 23:23:42 -0400
Message-ID: <425B3F2C.1050300@yahoo.com>
Date: Mon, 11 Apr 2005 20:23:24 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 0/6] Linux-iSCSI High-Performance Initiator
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to announce Linux-iSCSI project: High-Performance iSCSI 
Initiator v5.0.0.2.

The corresponding user space tools:

http://sourceforge.net/project/showfiles.php?group_id=26396

1. Performance Results
=================

1.1 SETUP
========
See http://www.open-iscsi.org/cgi-bin/wiki.pl/Performance-setup

1.2 SUMMARY
============
256K block Write: 810 MBytes/sec
256K blocks Read: 550 MBytes/sec
1K block Read: 75,000 IOPS


1.3 Disktest results
==============

256K block size WRITE operation:
--------------------------------

Session #0: /dev/sda

| 2005/04/11-09:39:42 | STAT  | 9796 | v1.1.12 | /dev/sda | Write 
throughput: 430646600.1B/s (410.70MB/s), IOPS 1642.9/s.
| 2005/04/11-09:39:43 | STAT  | 9796 | v1.1.12 | /dev/sda | Write 
throughput: 430876514.5B/s (410.92MB/s), IOPS 1643.8/s.


Session #1: /dev/sdb

| 2005/04/11-09:40:11 | STAT  | 9811 | v1.1.12 | /dev/sdb | Write 
throughput: 419816033.3B/s (400.37MB/s), IOPS 1601.6/s.
| 2005/04/11-09:40:12 | STAT  | 9811 | v1.1.12 | /dev/sdb | Write 
throughput: 419868739.1B/s (400.42MB/s), IOPS 1601.8/s.


Total: ~810 MBytes/sec from a single iSCSI Initiator.


256K block size READ operation:
----------------------------------------

Session #0: /dev/sda

| 2005/04/11-09:47:00 | STAT  | 9988 | v1.1.12 | /dev/sda | Read 
throughput: 278883766.9B/s (265.96MB/s), IOPS 1065.3/s.
| 2005/04/11-09:47:01 | STAT  | 9988 | v1.1.12 | /dev/sda | Read 
throughput: 281018368.0B/s (268.00MB/s), IOPS 1073.2/s.

Session #1: /dev/sdb

| 2005/04/11-09:47:04 | STAT  | 9976 | v1.1.12 | /dev/sdb | Read 
throughput: 294106843.4B/s (280.48MB/s), IOPS 1122.6/s.
| 2005/04/11-09:47:05 | STAT  | 9976 | v1.1.12 | /dev/sdb | Read 
throughput: 294842094.9B/s (281.18MB/s), IOPS 1125.4/s.

Total: ~550 MBytes/sec from single iSCSI Initiator machine


1K block size READ operation:
-----------------------------

Session #0: /dev/sda

| 2005/04/11-09:57:28 | STAT  | 10067 | v1.1.12 | /dev/sda | Read 
throughput: 38327973.2B/s (36.55MB/s), IOPS 37430.2/s.
| 2005/04/11-09:57:29 | STAT  | 10067 | v1.1.12 | /dev/sda | Read 
throughput: 38321291.3B/s (36.55MB/s), IOPS 37423.7/s.

Session #1: /dev/sdb

| 2005/04/11-09:57:30 | STAT  | 10000 | v1.1.12 | /dev/sdb | Read 
throughput: 39967796.7B/s (38.12MB/s), IOPS 39031.5/s.
| 2005/04/11-09:57:31 | STAT  | 10000 | v1.1.12 | /dev/sdb | Read 
throughput: 40131755.9B/s (38.27MB/s), IOPS 39191.6/s.

Total: ~76,000 IOPS from single iSCSI Initiator machine


2. Patches
========

The following 6 patches alltogether represent the Open-iSCSI Initiator:

Patch 1:
 SCSI LLDD consists of 3 files:
 - iscsi_if.c (iSCSI open interface over netlink);
 - iscsi_tcp.[ch] (iSCSI transport over TCP/IP).

Patch 2:
 Common header files:
 - iscsi_if.h (user/kernel #defines);
 - iscsi_proto.h (RFC3720 #defines and types);
 - iscsi_iftrans.h (iscsi transport interface).
  - iscsi_ifev.h (user/kernel events).

Patch 3:
 drivers/scsi/Kconfig changes.

Patch 4:
 drivers/scsi/Makefile changes.

Patch 5:
 include/linux/netlink.h changes (added new protocol NETLINK_ISCSI)

Patch 6:
 Documentation/scsi/iscsi.txt


3. Changelog since v5.0.0.1 (Open-iSCSI v 0.1)
===================================
* ERL=0 in kernel support
* fixed scsi discovery
* highmem fix
* more acurate asserts
* host-put fix
* r2t vs. sendhdr race fix
* minor fixes
* discovery fix, small write cleanup
* serialization between conn_destroy(), xmitworker() and data_recv()
* xmit code cleanup
* read regression fix
* more accurate command line handling
* adding tname to the node rec key
* mempool preallocation
* recv pdu OOM-safe
* fix r2t->sg
* buf_left() fix
* trim skb on alloc
* immqueue leak fix
* more accurate error reporting
* do not check for LUN on R2T receive in ERL=0.
* flush xmit queues on conn_stop()
* Ming's patch to have default port for discovery
* do not close session on bad cmd_rsp() from target
* write optimization: send iSCSI PDU header as a part of the same TCP 
payload
* ctask->sg vs. sg_count cleanup
* refcounting on session create/destroy fix
* unblock eh_abort() in case of TMF timedout
* 256 LUNS support fix
* race fixed: rmmod concurrent with session_destroy()
* cleanup comments (Matt Mackall) - implemented
* recovery optimization: avoid big allocations on re-open
* initial scsi_transport_iscsi implementation
* introduced host, session and connection contexts on the iscsi_if level
* iscsi_if parameters validation
* no mallocs on datapath during netlink operations in user-space for 
down calls
* initial resource error detection
* task abort sent after session gets reopened - fixed
* greater than 2TB support
* iscsid fork now works.
* to sync caches, delete session's LUNs before actual logout task
* added get_param(); used in iscsi transport class
* regression.sh: device parameter added
* transport register/unregister path cleanup
* transport api vs. user/kernel definitions split
* idbm node and discovery records version check
* IPC via netlink + mempool_zones initial implementation
* immediate task's data pool preallocation
* added protection from SIGTERM
* added protection from OOM-killer using oom_adj == -17
* allocate cache aligned iscsi_taskcache
* tx latency: transmitting from queuecommand() if trylock succeeds
* reduced context switching in queuecommand
* max_xmit_dlength properly negotiated
* enable Nagle
* netlink reply cleanup
* kernel/user IPC cleanup: added and implemented iscsi_ipc callback 
structure
* receive pool for control PDU's per-connection added
* using predefined macro for max_sg SG_ALL
* kernel IPC transport header file added
* picking unique OUI ISID for the same target based on session's SID


Regards,

Alex Aizman & Dmitry Yusupov
