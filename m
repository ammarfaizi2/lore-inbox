Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319080AbSHMWvt>; Tue, 13 Aug 2002 18:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319081AbSHMWvs>; Tue, 13 Aug 2002 18:51:48 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:9613 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319080AbSHMWvr>; Tue, 13 Aug 2002 18:51:47 -0400
Date: Tue, 13 Aug 2002 18:55:35 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 01/38: switches in fs/Config.in, fs/Config.help
Message-ID: <Pine.SOL.4.44.0208131854000.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch defines new switches in fs/Config.in -
  CONFIG_NFS_V4:  enables nfsv4 client
  CONFIG_NFSD_V4: enables nfsv4 server
  CONFIG_SUNRPC_GSSD_CLNT: enables in-kernel client for GSSD

[Background: GSSD is a service which runs in userspace, whose
 purpose in life (for now) is to provide translation between
 strings of the form user@realm, which are used in the NFSv4
 protocol, and numerical uid/gid's, which the kernel can
 understand.  The kernel communicates with GSSD through
 loopback RPC calls.]

--- old/fs/Config.in	Wed Jul 24 16:03:29 2002
+++ new/fs/Config.in	Thu Aug  8 09:41:58 2002
@@ -109,10 +109,12 @@ if [ "$CONFIG_NET" = "y" ]; then
    dep_tristate 'InterMezzo file system support (replicating fs) (EXPERIMENTAL)' CONFIG_INTERMEZZO_FS $CONFIG_INET $CONFIG_EXPERIMENTAL
    dep_tristate 'NFS file system support' CONFIG_NFS_FS $CONFIG_INET
    dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
+   dep_mbool '  Provide NFSv4 client support (EXPERIMENTAL)' CONFIG_NFS_V4 $CONFIG_NFS_FS $CONFIG_EXPERIMENTAL
    dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS $CONFIG_IP_PNP

    dep_tristate 'NFS server support' CONFIG_NFSD $CONFIG_INET
    dep_mbool '  Provide NFSv3 server support' CONFIG_NFSD_V3 $CONFIG_NFSD
+   dep_mbool '  Provide NFSv4 server support (EXPERIMENTAL)' CONFIG_NFSD_V4 $CONFIG_NFSD_V3 $CONFIG_EXPERIMENTAL
    dep_mbool '  Provide NFS server over TCP support (EXPERIMENTAL)' CONFIG_NFSD_TCP $CONFIG_NFSD $CONFIG_EXPERIMENTAL

    if [ "$CONFIG_NFS_FS" = "y" -o "$CONFIG_NFSD" = "y" ]; then
@@ -130,6 +132,9 @@ if [ "$CONFIG_NET" = "y" ]; then
    if [ "$CONFIG_NFSD_V3" = "y" -o "$CONFIG_NFS_V3" = "y" ]; then
      define_bool CONFIG_LOCKD_V4 y
    fi
+   if [ "$CONFIG_NFSD_V4" = "y" -o "$CONFIG_NFS_V4" = "y" ]; then
+     define_bool CONFIG_SUNRPC_GSSD_CLNT y
+   fi
    define_tristate CONFIG_EXPORTFS $CONFIG_NFSD

    dep_tristate 'SMB file system support (to mount Windows shares etc.)' CONFIG_SMB_FS $CONFIG_INET
--- old/fs/Config.help	Wed Jul 24 16:03:30 2002
+++ new/fs/Config.help	Wed Aug  7 12:24:03 2002
@@ -514,6 +514,13 @@ CONFIG_NFS_V3

   If unsure, say N.

+CONFIG_NFS_V4
+  Say Y here if you want your NFS client to be able to speak the newer
+  version 4 of the NFS protocol.  This feature is experimental, and
+  should only be used if you are interested in helping to test NFSv4.
+
+  If unsure, say N.
+
 CONFIG_ROOT_NFS
   If you want your Linux box to mount its whole root file system (the
   one containing the directory /) from some other computer over the
@@ -555,6 +562,12 @@ CONFIG_NFSD_V3
   If you would like to include the NFSv3 server as well as the NFSv2
   server, say Y here.  If unsure, say Y.

+CONFIG_NFSD_V4
+  If you would like to include the NFSv4 server as well as the NFSv2
+  server, say Y here.  This feature is experimental, and should only
+  be used if you are interested in helping to test NFSv4.  If unsure,
+  say N.
+
 CONFIG_NFSD_TCP
   Enable NFS service over TCP connections.  This the officially
   still experimental, but seems to work well.

