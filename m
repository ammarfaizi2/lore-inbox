Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbSJEL5H>; Sat, 5 Oct 2002 07:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSJEL5G>; Sat, 5 Oct 2002 07:57:06 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:31386 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S261945AbSJEL5G>; Sat, 5 Oct 2002 07:57:06 -0400
Date: Sat, 5 Oct 2002 12:21:15 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: 2.4.19 NFS file perms
Message-ID: <20021005122115.A1338@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on an NFS mounted fs, executing as root I see this:

[root@sirizidl nfsr]# ll /nfsr/toplev.fig 
-rw-------    1 kernel   users       48500 Oct  5 11:42 /nfsr/toplev.fig
[root@sirizidl nfsr]# xfig /nfsr/toplev.fig 
[snip]
...
stat64("toplev.fig", {st_mode=S_IFREG|0600, st_size=48500, ...}) = 0
open("toplev.fig", O_RDONLY)            = 4
fstat64(4, {st_mode=S_IFREG|0600, st_size=48500, ...}) = 0
old_mmap(NULL, 48500, PROT_READ, MAP_PRIVATE, 4, 0) = 0xc0011000
read(4, 0xefffe4cb, 1)                  = -1 EIO (Input/output error)
_llseek(4, 48500, [48500], SEEK_SET)    = 0
--- SIGBUS (Bus error) ---

glibc crashes in fgets because it doesn't expect the problem after the 
file has been successfully opened and mapped.. who is at fault here?

Remote nfs server is an old userspace implementation btw.

Richard

