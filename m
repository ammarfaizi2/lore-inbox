Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbUBZWHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUBZWEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:04:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:60312 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261185AbUBZWDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:03:36 -0500
Date: Thu, 26 Feb 2004 14:03:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PATCH] Add getdents32t syscall
Message-Id: <20040226140327.0d46cd1e.rddunlap@osdl.org>
In-Reply-To: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz>
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004 20:38:19 +0100 Jakub Jelinek wrote:

| glibc struct dirent has d_type field (similarly to struct dirent64).
| Because no 32-bit getdents syscall provides this field to userland,
| glibc needs to use getdents64 syscall even for 32-bit getdents
| (and readdir etc.) and convert dirent entries from struct dirent64
| to struct dirent.  The code is quite complicated and as the former
| is bigger and the size of 64-bit dirents cannot be predicted accurately,
| it can happen that glibc reads too many entries and has to seek back
| on the dir etc.
| 
| The following patch introduces a new syscall (on 32-bit architectures),
| which fills in 32-bit struct dirent with d_type member.
| With this syscall glibc can simply call this syscall in 32-bit getdents
| and be done with it, no seeking, issues with NFS zero extended d_ino values,
| buffer translation etc.  sys_getdents32t (the t in there is for type,
| to differentiate it from compatibility sys_getdents32 which don't provide
| d_type) function should be usable both on 32-bit arches and in 32-bit
| compatibility layers on 64-bit arches (on most arches directly, if
| the arguments are zero extended in assembly).
| 

| +asmlinkage long sys_getdents32t(unsigned int fd, struct linux_dirent32t __user * dirent, unsigned int count)
| +{

Please add function prototype for that to include/linux/syscalls.h.

Thanks,
--
~Randy
