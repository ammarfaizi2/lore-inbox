Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWIMUdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWIMUdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWIMUdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:33:24 -0400
Received: from 1-1-5-8a.ehn.lk.bostream.se ([82.183.137.225]:1533 "EHLO
	1-1-5-8a.ehn.lk.bostream.se") by vger.kernel.org with ESMTP
	id S1751173AbWIMUdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:33:23 -0400
Date: Wed, 13 Sep 2006 22:33:20 +0200
From: Henrik Carlqvist <hc8@uthyres.com>
To: linux-kernel@vger.kernel.org
Subject: ocfs2 problem with nfs v2
Message-Id: <20060913223320.008bdcf7.hc8@uthyres.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to setup a redundant NFS server using ocfs2 on a shared disk
between two servers. So far I have only configured ocfs2 on one server,
but I have already seen a problem.

The NFS server works fine for Solaris and Linux NFS v3 clients, but old
linux boxes using NFS v2 have problems with the server.

The NFS clients which are able to reproduce the problem have Slackware 4
installed, this is what things look like on a problematic NFS v2 client:

$ uname -sr
Linux 2.2.6
$ ls ~henhi
/bin/ls: /home/aphus/22/henhi: Operation not supported on transport
endpoint 
$ cat /proc/mounts | grep aphus/22
svinapa:/export/aphus22 /home/aphus/22 nfs rw,intr,addr=svinapa 0 0

At the same time that the NFS client says "Operation not supported..." I
get the following in the logs on the NFS server:
Sep 13 15:50:20 kattapa kernel: (5385,0):ocfs2_encode_fh:155 ERROR: fh
buffer is too small for encoding

The NFS server has Red Hat Enterprise Linux ES release 4 installed with
kernel 2.6.9-42.ELsmp and ocfs2-2.6.9-42.ELsmp-1.2.3-1.i686.rpm was
downloaded from Oracles web.

Red Hat 4 and Slackware 4 might sound as releases that should match each
other, but Slackware 4 was released 1999. As the old 2.2.6 kernel does not
have support for NFS v3 but only NFS v2 my guess is that this might
trigger the bug. I have tried to increase rsize and wsize to 8192, but it
didn't help.

Does anybody know what causes "fh buffer is too small for encoding"?

regards Henrik
