Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVDLFVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVDLFVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVDLFU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:20:26 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:51628 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262016AbVDLDZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 23:25:11 -0400
Message-ID: <425B3F84.1090902@yahoo.com>
Date: Mon, 11 Apr 2005 20:24:52 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 6/6] Linux-iSCSI High-Performance Initiator
Content-Type: multipart/mixed;
 boundary="------------060403010302010800080703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060403010302010800080703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

             Documentation/scsi/iscsi.txt

             Signed-off-by: Alex Aizman <itn780@yahoo.com>
             Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>












--------------060403010302010800080703
Content-Type: text/plain;
 name="linux-iscsi-doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-iscsi-doc.patch"

diff -Nru linux-2.6.12-rc2.orig/Documentation/scsi/iscsi.txt linux-2.6.12-rc2.dima/Documentation/scsi/iscsi.txt
--- linux-2.6.12-rc2.orig/Documentation/scsi/iscsi.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc2.dima/Documentation/scsi/iscsi.txt	2005-04-11 18:13:12.000000000 -0700
@@ -0,0 +1,292 @@
+=================================================================
+
+                Linux* Open-iSCSI
+
+=================================================================
+
+                                                April 11, 2005
+
+Contents
+========
+
+- 1. In This Release
+- 2. Introduction
+- 3. Installation
+- 4. Open-iSCSI daemon
+- 5. Open-iSCSI Configuration Utility
+- 6. Configuration
+- 7. Getting Started
+- 8. TBD
+- Appendix A. SendTargets snapshot.
+
+
+
+1. In This Release
+==================
+
+This file describes the Linux* Open-iSCSI Initiator. The software was
+tested on AMD Opteron (TM) and Intel Xeon (TM). 
+
+The latest development release is available at:
+http://linux-iscsi.sf.net
+
+For questions, comments, contributions send e-mail to:
+linux-iscsi-devel@sourceforge.net and open-iscsi@googlegroups.com 
+
+    1.1. Features
+    
+    - highly optimized and very small-footprint data path;
+    - multiple outstanding R2Ts;
+    - persistent configuration database;
+    - SendTargets discovery;
+    - CHAP;
+    - PDU header Digest;
+    - multiple sessions;
+    - multi-connection sessions.
+    
+    For the most recent list of features please refer to:
+    http://www.open-iscsi.org/cgi-bin/wiki.pl/Roadmap
+
+    
+
+2. Introduction
+===============
+
+Open-iSCSI project is a high-performance, transport independent,
+multi-platform implementation of RFC3720 iSCSI.
+
+Open-iSCSI is partitioned into user and kernel parts.
+
+The kernel portion of Open-iSCSI is a from-scratch code
+licensed under GPL. The kernel part implements iSCSI data path
+(that is, iSCSI Read and iSCSI Write), and consists of two
+loadable modules: iscsi_if.ko and iscsi_tcp.ko.
+
+User space contains the entire control plane: configuration
+manager, iSCSI Discovery, Login and Logout processing,
+connection-level error processing, Nop-In and Nop-Out handling,
+and (in the future:) Text processing, iSNS, SLP, Radius, etc.
+
+The user space Open-iSCSI consists of a daemon process called
+iscsid, and a management utility iscsiadm.
+
+
+3. Installation
+===============
+
+As of today, the Open-iSCSI Initiator requires a host running the
+Linux operating system with kernel version 2.6.11, or later. You need to
+enable "Cryptographic API" under "Cryptographic options" in the
+kernel config. You also need to enable "CRC32c CRC algorithm" if
+you use header or data digests. They are the kernel options,
+CONFIG_CRYPTO and CONFIG_CRYPTO_CRC32C, respectively.
+
+Compilation of the kernel Opne-iSCSI modules requires a path
+to kernel sources:
+
+	make KSRC=<kernel-src>
+
+or cross-compilation:
+
+	make KSRC=<kernel-src> KARCH="ARCH=um"
+
+
+4. Open-iSCSI daemon
+====================
+
+The daemon implements control path of iSCSI protocol, plus some management
+facilities. For example, the daemon could be configured to automatically 
+re-start discovery at startup, based on the contents of persistent 
+iSCSI database (see next section).
+
+For help, run:
+
+	./iscsid --help
+
+Usage: iscsid [OPTION]
+
+  -c, --config=[path]     Execute in the config file (/etc/iscsid.conf).
+  -f, --foreground        run iscsid in the foreground
+  -d, --debug debuglevel  print debugging information
+  -u, --uid=uid           run as uid, default is current user
+  -g, --gid=gid           run as gid, default is current user group
+  -h, --help              display this help and exit
+  -v, --version           display version and exit
+
+
+
+5. Open-iSCSI Configuration Utility
+===================================
+
+Open-iSCSI persistent configuration is implemented as a DBM database
+available on all Linux installations.
+
+The database contains two tables:
+
+- Discovery table (discovery.db);
+- Node table (node.db).
+
+The regular place for iSCSI database files: /var/db/iscsi/*.db
+
+The iscsiadm utility is a command-line tool to manage (update, delete,
+insert, query) the persistent database.
+
+The utility presents set of operations that a user can perform 
+on iSCSI nodes, sessions, connections, and discovery records.
+
+Note that some of the iSCSI Node and iSCSI Discovery operations 
+do not require iSCSI daemon (iscsid) loaded.
+
+For help, run:
+
+	./iscsiadm --help
+
+Usage: iscsiadm [OPTION]
+
+  -m, --mode <op>         specify operational mode op = <discovery|node>
+  -m discovery --type=[type] --portal=[ip:port] --login
+                          perform [type] discovery for target portal with
+                          ip-address [ip] and port [port]. Initiate Login for
+                          each discovered target if --login is specified
+  -m discovery            display all discovery records from internal
+                          persistent discovery database
+  -m discovery --record=[id] --login
+                          perform discovery based on record [id] in database
+  -m discovery --record=[id] --op=[op] [--name=[name] --value=[value]]
+                          perform specific DB operation [op] for specific
+                          discovery record with [id]. It could be one of:
+                          [new], [delete], [update] or [show]. In case of
+                          [update], you have to provide [name] and [value]
+                          you wish to update
+  -m node                 display all discovered nodes from internal
+                          persistent discovery database
+  -m node --record=[id] [--login|--logout]
+  -m node --record=[id] --op=[op] [--name=[name] --value=[value]]
+                          perform specific DB operation [op] for specific
+                          node with record [id]. It could be one of:
+                          [new], [delete], [update] or [show]. In case of
+                          [update], you have to provide [name] and [value]
+                          you wish to update
+  -m session              display all active sessions and connections
+  -m session --record=[id[:cid]] [--logout]
+                          perform operation for specific session with
+                          record [id] or display statistics if no operation
+                          specified. Operation will affect one connection
+                          only if [:cid] is specified
+  -d, --debug debuglevel  print debugging information
+  -V, --version           display version and exit
+  -h, --help              display this help and exit
+
+
+    Usage Examples:
+
+    1) SendTargets iSCSI Discovery:
+
+	    ./iscsiadm -m discovery --type sendtargets --portal 192.168.1.1:3260
+
+    2) iSCSI Login:
+
+	    ./iscsiadm -m node --record 0f23e4 --login
+
+    3) iSCSI Logout:
+
+	    ./iscsiadm -m node --record 0f23e4 --logout
+
+    4) Changing iSCSI parameter:
+
+	    ./iscsiadm -m node --record 0f23e4 --op update \
+		    -n node.cnx[0].iscsi.MaxRecvDataSegmentLength -v 65536
+
+    5) Adding custom iSCSI Node:
+
+	    ./iscsiadm -m node --op new --portal 192.168.0.1:3260
+	    new iSCSI node record added: [0a45f8]
+
+    6) Removing iSCSI Node:
+
+	    ./iscsiadm -m node --op delete --record 0a45f8
+
+    7) Display iSCSI Node configuration:
+
+	    ./iscsiadm -m node --record 0a45f8
+
+	or
+
+	    ./iscsiadm -m node --op show --record 0a45f8
+
+
+6. Configuration
+================
+
+The default configuration file is /etc/iscsid.conf. This file contains
+only configuration that could be overwritten by iSCSI Discovery,
+or manualy updated via iscsiadm utility. Its OK if this file does not
+exist in which case compiled-in default configuration will take place
+for newer discovered Target nodes.
+
+See the man page and the example file for the current syntax.
+(no man page yet...)
+
+
+7. Getting Started
+==================
+
+Right now there is no installation script. Just load the module with
+command:
+
+	insmod iscsi_if.ko
+	insmod iscsi_tcp.ko
+
+after that start iSCSI daemon process:
+
+	./iscsid
+
+or alternatively, start it with debug enabled and with output
+redirected to the current console:
+
+	./iscsid -d8 -f &
+
+and use configuration utility to add/remove/update Discovery records,
+iSCSI Node records or monitor active iSCSI sessions:
+
+	./iscsiadm
+
+
+To login:
+
+	    ./iscsiadm -m node --record <node rec> --login
+
+where <node rec> is the record of a discovered or manually
+added iSCSI Target Node (for iscsiadm usage examples see
+previous sections).
+
+
+8. TBD
+======
+
+To be completed:
+
+    - Kernel tracing and Troubleshooting
+    - Immediate and not-so-immediate plans
+    - Useful scripts
+    - White paper on Open-iSCSI design
+
+
+Appendix A. SendTargets iSCSI Discovery session snapshot.
+=========================================================
+
+-bash-2.05b# ./iscsiadm -m discovery -tst -p 10.16.16.223:3260
+[02f611] 10.16.16.223:3260,1 iqn.2002-07.com.ttechnologies.target.a
+[01acd1] 17.1.1.223:3260,1 iqn.2002-07.com.ttechnologies.target.a
+-bash-2.05b#
+-bash-2.05b# ./iscsiadm -m node
+[02f611] 10.16.16.223:3260,1 iqn.2002-07.com.ttechnologies.target.a
+[01acd1] 17.1.1.223:3260,1 iqn.2002-07.com.ttechnologies.target.a
+-bash-2.05b#
+-bash-2.05b# ./iscsiadm -m discovery -tst -p 10.16.16.227:3260
+[02fb91] 10.16.16.227:3260,1 iqn.2001-04.com.example:storage.disk2.sys1.xyz
+-bash-2.05b#
+-bash-2.05b# ./iscsiadm -m node
+[02f611] 10.16.16.223:3260,1 iqn.2002-07.com.ttechnologies.target.a
+[02fb91] 10.16.16.227:3260,1 iqn.2001-04.com.example:storage.disk2.sys1.xyz
+[01acd1] 17.1.1.223:3260,1 iqn.2002-07.com.ttechnologies.target.a



--------------060403010302010800080703--
