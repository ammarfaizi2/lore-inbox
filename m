Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262814AbSJWDon>; Tue, 22 Oct 2002 23:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbSJWDon>; Tue, 22 Oct 2002 23:44:43 -0400
Received: from [213.95.15.193] ([213.95.15.193]:17931 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262814AbSJWDol>;
	Tue, 22 Oct 2002 23:44:41 -0400
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: How to decode call trace
References: <87elai82xb.fsf@goat.bogus.local.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Oct 2002 05:50:41 +0200
In-Reply-To: Olaf Dietsche's message of "23 Oct 2002 01:34:17 +0200"
Message-ID: <p73isztstim.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:
> and this is the code:
> static int __fscap_lookup(struct vfsmount *mnt, struct nameidata *nd)
> {
> 	static char name[] = ".capabilities";
> 	nd->mnt = mntget(mnt);
> 	nd->dentry = dget(mnt->mnt_sb->s_root);
> 	nd->flags = 0;
> 	return path_walk(name, nd);
> }
> 
> What does .text.lock.namei and name.810 mean?

.text.lock.namei means that it hung in the slow path of a spinlock that
is referenced from namei.c

name.810 is a static data variable, probably the static char name[]
shown above. Remember the kernel backtrace is not exact and can print
random stack junk that looks like return addresses too. You always have 
to sanity check each entry.

> Is there a way to get the line number out of these hex values?

addr2line -e vmlinux ... does this when you compile the kernel with -g 

-Andi
