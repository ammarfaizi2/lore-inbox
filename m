Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265145AbTGKUhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbTGKUhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:37:10 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:44442 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S265145AbTGKUhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:37:07 -0400
Date: Fri, 11 Jul 2003 23:51:47 +0300
From: Erkki Seppala <flux@modeemi.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre3 nfs-client write-problems
Message-ID: <20030711205147.GA6556@modeemi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've experienced the problem with versions vanilla 2.4.20, vanilla
2.4.21 and 2.4.22-pre3+device-mapper.

The problem appears when I write big files relatively fast over
nfs. My client is Dual-Athlon 1900+, and the servers are Dual P3
500MHz (with 2.4.18) and Pentium 2 200MHz (with 2.4.18 debian bf-2.4
default kernel).

Both servers use kernel-nfsd. However, as things work perfectly with a
2.4.19-client and between the servers, it would hardly seem to be a
server-matter.

There is a gigabit-link between the Athlon and P3.

Reproducing: dd if=/dev/zero of=new-file-on-nfs-file-system -> dies on
I/O error.

If I dd if=/dev/zero bs=1024 count=1000000 of=existing-one-GB-file,
things fail similarly. (Last attempt failed at record 3073.) 

It might be just luck, but it would seem to me that the Dual-P3 server
behind the gigabit-link fails faster than the slow P2-server (which is
infact network-topographically behind the P3).

Relevant lines from .config:

CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y

I'm willing to try patches :).
-- 
  _____________________________________________________________________
     / __// /__ ____  __               http://www.modeemi.fi/~flux/\   \
    / /_ / // // /\ \/ /                                            \  /
   /_/  /_/ \___/ /_/\_\@modeemi.fi                                  \/
