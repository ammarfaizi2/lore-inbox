Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268511AbRHaRSc>; Fri, 31 Aug 2001 13:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268570AbRHaRSW>; Fri, 31 Aug 2001 13:18:22 -0400
Received: from mailhost.opengroup.fr ([62.160.165.1]:30887 "EHLO
	mailhost.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S268511AbRHaRSH>; Fri, 31 Aug 2001 13:18:07 -0400
Date: Fri, 31 Aug 2001 19:18:20 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
To: <linux-kernel@vger.kernel.org>
cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
Subject: [Q] [VFS] NULL f_dentry for opened files ; possible race condition
Message-ID: <Pine.LNX.4.31.0108311620540.3977-100000@sisley.ri.silicomp.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


In 2.4.9, I have encountered a strange condition while playing with file
structs chained on a superblock list (sb->s_files) : some of them can have
a NULL f_dentry pointer. The only case I found which can cause this is
when fput is called and f_count drops to zero. Is that the only case ?

While exploring the corresponding code for an explanation, I found what
looks like a possible race condition : do_remount_sb calls
fs_may_remount_ro, and only then uses lock_super to do the actual remount.

Isn't it possible for a program to open a file for writing just after
fs_may_remount_ro ? The whole thing seems to be protected by the BKL and
mount_sem, but I guess it won't stop an open.


Regards,

-- 
Jean-Marc Saffroy - Research Engineer - Silicomp Research Institute
mailto:saffroy@ri.silicomp.fr

