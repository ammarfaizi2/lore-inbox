Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316379AbSEOMM0>; Wed, 15 May 2002 08:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316380AbSEOMMZ>; Wed, 15 May 2002 08:12:25 -0400
Received: from penguin-ext.wise.edt.ericsson.se ([193.180.251.47]:907 "EHLO
	penguin.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S316379AbSEOMMY>; Wed, 15 May 2002 08:12:24 -0400
Message-ID: <3CE250A5.47F71DF@uab.ericsson.se>
Date: Wed, 15 May 2002 14:12:21 +0200
From: Sverker Wiberg <Sverker.Wiberg@uab.ericsson.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: knfsd misses occasional writes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone, 

When copying lots of small files from multiple NFS clients to a kNFSd
filesystem (i.e. doing backup of a cluster), exported with `sync', I
find that some few files (1 out of 1000) were silently truncated to zero
size when checking locally with `ls' (the clients reported total
success). With `asynch' instead, all files were correctly copied. 

I have seen this behaviour in 2.4.17 (UP and SMP builds, UP hardware) as
well as 2.4.18, when using the NFSv2 protocol. I have not tried 2.5.x
and NFSv3 yet. The full /etc/exports line is:

   /opt/telorb 172.16.0.0/255.255.0.0(rw,sync,no_wdelay)

Removing `no_wdelay' makes no difference.

The clients are all 2.4.17, and the relevant .config lines (for both
server and clients) are:

   CONFIG_NFS_FS=y
   CONFIG_NFS_V3=y
   CONFIG_ROOT_NFS=y
   CONFIG_NFSD=y
   CONFIG_NFSD_V3=y
   CONFIG_SUNRPC=y
   CONFIG_LOCKD=y
   CONFIG_LOCKD_V4=y

Reading the source (fs/nfsd/*) seems to show that knfsd tries to do the
right thing.

/Sverker Wiberg
