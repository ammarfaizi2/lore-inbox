Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261962AbTDAAkC>; Mon, 31 Mar 2003 19:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261966AbTDAAkC>; Mon, 31 Mar 2003 19:40:02 -0500
Received: from zok.SGI.COM ([204.94.215.101]:42113 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S261962AbTDAAkB>;
	Mon, 31 Mar 2003 19:40:01 -0500
To: linux-kernel@vger.kernel.org
Subject: NFS core dump blocks
From: Chad Talbott <chadt@sgi.com>
Date: 31 Mar 2003 16:51:23 -0800
Message-ID: <6eoznnbnipg.fsf@sgi.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is not an issue in 2.5, but in 2.4:

When running a large app over NFS, it crashes and dumps core.  This
takes some time, during which ps, top, and other customers of /proc
hang while they wait for the mmap_sem.  Is there an argument against
changing the

        down_write(&current->mm->mmap_sem);

in fs/binfmt_elf.c:elf_core_dump to

        down_read(&current->mm->mmap_sem);

Thanks,
Chad
