Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319275AbSHNTlH>; Wed, 14 Aug 2002 15:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319276AbSHNTlH>; Wed, 14 Aug 2002 15:41:07 -0400
Received: from host.greatconnect.com ([209.239.40.135]:45582 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S319275AbSHNTlG>; Wed, 14 Aug 2002 15:41:06 -0400
Subject: Unresolved symbols in nfsd in 2.4.20-pre2-ac1
From: Samuel Flory <sflory@rackable.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
References: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Aug 2002 12:44:22 -0700
Message-Id: <1029354263.1749.186.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  It looks like someone broke nfsd.  From make modules_install:

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map 
2.4.20-pre1-ac3; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre1-ac3/kernel/fs/nfsd/nfsd.o
depmod:         exp_readunlock
make: *** [_modinst_post] Error 1


Here's my config:
[root@grendel linux-2.4.20-pre2-ac1]# grep -i -e rpc -e nfs .config
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_NCPFS_NFS_NS=y

