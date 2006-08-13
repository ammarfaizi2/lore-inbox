Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWHMUj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWHMUj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 16:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWHMUj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 16:39:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7595 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751412AbWHMUj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 16:39:56 -0400
Date: Sun, 13 Aug 2006 13:39:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060813133935.b0c728ec.akpm@osdl.org>
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
References: <20060813012454.f1d52189.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 01:24:54 -0700
Andrew Morton <akpm@osdl.org> wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/

This kernel breaks autofs /net handling.  Bisection shows that the bug is
introduced by git-nfs.patch.


sony:/home/akpm> showmount -e bix
Export list for bix:
/           *
/usr/src    *
/mnt/export *
sony:/home/akpm> ls -l /net/bix
total 1025280
drwxr-xr-x  3 root root       4096 Apr 10 03:19 bin
drwxr-xr-x  2 root root       4096 Mar 10  2004 boot
drwxr-xr-x 23 root root     118784 Jun 26 00:48 dev
drwxr-xr-x 98 root root       8192 Aug 13 04:03 etc
drwxr-xr-x  7 root root       4096 Apr  1  2004 home
drwxr-xr-x  2 root root       4096 Oct  7  2003 initrd
drwxr-xr-x 10 root root       4096 Apr 10 03:19 lib
drwx------  2 root root      16384 Mar 10  2004 lost+found
drwxr-xr-x  2 root root       4096 Sep  8  2003 misc
?---------  ? ?    ?             ?            ? /net/bix/mnt
?---------  ? ?    ?             ?            ? /net/bix/usr
drwxrwxrwx  8 root root       4096 Jul 10 02:50 opt
drwxr-xr-x  2 root root       4096 Mar 10  2004 proc
drwxr-xr-x 20 root root       4096 Aug  7 16:39 root
drwxr-xr-x  2 root root      57344 Apr 24  2004 rpms
drwxr-xr-x  2 root root       8192 Apr 10 03:19 sbin
-rw-r--r--  1 root root 1048576000 Mar 12  2004 swap
drwxr-xr-x  2 root root       4096 Mar 12  2004 sys
drwxr-xr-x  3 root root       4096 Mar 10  2004 tftpboot
drwxrwxrwt 14 root root      16384 Aug 13 13:29 tmp
drwxr-xr-x 27 root root       4096 Mar 10  2004 var
sony:/home/akpm> ls -l /net/bix/usr
ls: /net/bix/usr: No such file or directory
sony:/home/akpm> mount     
/dev/sda6 on / type ext3 (rw,noatime)
/dev/proc on /proc type proc (rw)
/dev/sys on /sys type sysfs (rw)
/dev/devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/shm on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
automount(pid1757) on /net type autofs (rw,fd=5,pgrp=1757,minproto=2,maxproto=4)
bix:/ on /net/bix type nfs (rw,nosuid,nodev,hard,intr,tcp,addr=192.168.2.33)


distro is fairly-up-to-date FC5.
