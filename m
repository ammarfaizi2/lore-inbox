Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267697AbTASVaf>; Sun, 19 Jan 2003 16:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267698AbTASVaf>; Sun, 19 Jan 2003 16:30:35 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:44178 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S267697AbTASVae>;
	Sun, 19 Jan 2003 16:30:34 -0500
Subject: problems with nfs-server in 2.5 bk as of 030115
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043012373.7986.94.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Jan 2003 22:39:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

This is the first time I've tried running an nfs-server in 2.5 and I
believe the problem I'm seeing is caused by your recent changes.

This kernel includes the two fixes you made.
"[PATCH] Fix RPC client warning in 2.5.58..."
and
"[PATCH] Fix NFS root mount handling"

I havn't seen any nfs/rpc related changes since these patches.

This is what I get when trying to start the nfs-server
(/etc/init.d/nfs-kernel-server in debian):

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
RPC: Couldn't create pipefs entry /portmap/clntcfac0540
RPC: Couldn't create pipefs entry /portmap/clntcfac0540
RPC: Couldn't create pipefs entry /portmap/clntcfac0540

I've mounted the rpc_pipefs filesystem and the directory
portmap/clntcfac0540 is created. It's empty but created.
It gets created with 500 as permissions.

the directories at the root of the rpc_pipefs filesystem get created
correctly with the permissions that your patch changed but not the
entries in these directories.

portmap does run as user daemon on this system.

I did check to make sure your patches were included and they were.

Output from rpcinfo:
# rpcinfo -p localhost
   program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100005    1   udp  32832  mountd
    100005    1   tcp  35561  mountd
    100005    2   udp  32832  mountd
    100005    2   tcp  35561  mountd

modules loaded:

nfsd                  118640  0 
exportfs                4224  1 nfsd
lockd                  61040  1 nfsd
sunrpc                115844  3 nfsd,lockd

relevant parts of .config:
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y 
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m

kernel compiled with gcc 3.2.2 if that matters.

Looking forward to suggestions/patches to test :)

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
