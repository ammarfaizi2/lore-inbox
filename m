Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290223AbSBSHSl>; Tue, 19 Feb 2002 02:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSBSHSb>; Tue, 19 Feb 2002 02:18:31 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:63239 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289850AbSBSHSS>; Tue, 19 Feb 2002 02:18:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: davem@redhat.com, kuznet@ms2.inr.ac.ru, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org
Subject: Moving fasync_struct into struct file?
Date: Tue, 19 Feb 2002 18:18:12 +1100
Message-Id: <E16d4XU-0003VI-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

	Stephen Rothwell pointed out that if you set up SIGIO from an
fd, fork, and exit, and PIDs wrap, the new process may be clobbered by
the SIGIO.  IMVHO the best way to clean this up is to check the
fasync_list in sys_close, and if pid == filp->f_owner.pid and fd ==
fasync_list->fa_fd, unregister the SIGIO.

	This means we need a move the "struct fasync_struct
fasync_list" into struct file (up from all the subsystems which use
it, eg. struct socket).

See any problems with this?
Rusty. 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
