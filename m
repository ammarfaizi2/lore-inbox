Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130523AbRC0HAc>; Tue, 27 Mar 2001 02:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130636AbRC0HAW>; Tue, 27 Mar 2001 02:00:22 -0500
Received: from ns1.bmlv.gv.at ([193.171.152.34]:29968 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S130523AbRC0HAG>;
	Tue, 27 Mar 2001 02:00:06 -0500
Message-Id: <3.0.6.32.20010327090010.009163c0@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Tue, 27 Mar 2001 09:00:10 +0200
To: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
From: "Ph. Marek" <marek@mail.bmlv.gv.at>
Subject: BUG: devfs/root doesn't follow pivot_root
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

in fs/devfs/util.c is
	void __init devfs_make_root (const char *name)
which is wrong as pivot_root allows changing the root-device in the runtime.

I think it should be 
	void __init devfs_make_root (const char *name)
and get called by
fs/super.c:
	asmlinkage long sys_pivot_root(const char *new_root, const char *put_old)
after
	chroot_fs_refs(root,root_mnt,new_nd.dentry,new_nd.mnt);
	error = 0;

Is that correct?


Thanks for your attention,


regards

Phil
