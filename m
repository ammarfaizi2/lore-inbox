Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTFHILP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 04:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTFHILP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 04:11:15 -0400
Received: from ns.suse.de ([213.95.15.193]:38162 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261168AbTFHILO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 04:11:14 -0400
Date: Sun, 8 Jun 2003 10:24:51 +0200
From: Andi Kleen <ak@suse.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: taskfile merge breaking suse hwscan
Message-ID: <20030608082451.GA21200@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just tried to boot a recent 2.5 amd64 kernel. Result is that it is 
hanging at boot during SuSE 8.2 hwscan.

Backtrace points to the new IDE taskfile code:

hwscan        D 0000000000000000 18446744073706259928   861    847                     (NOTLB)

Call Trace:<ffffffff80136137>{wait_for_completion+439} <ffffffff802fca2d>{start_request+253} 
       <ffffffff80135910>{default_wake_function+0} <ffffffff802fce94>{ide_do_request+996} 
       <ffffffff80135910>{default_wake_function+0} <ffffffff802fdf36>{ide_do_drive_cmd+710} 
       <ffffffff801cc440>{proc_alloc_inode+64} <ffffffff80303a4b>{ide_diag_taskfile+203} 
       <ffffffff803023f1>{taskfile_lib_get_identify+97} <ffffffff80302e40>{task_in_intr+0} 
       <ffffffff8031477f>{proc_ide_read_identify+111} <ffffffff801d128a>{proc_file_read+234} 
       <ffffffff8018c1b6>{vfs_read+198} <ffffffff8018c3f9>{sys_read+73} 
       <ffffffff80122f06>{ia32_do_syscall+30} 
hdc: lost interrupt

Followed by more lost interrupt messages.

Any ideas?

-Andi
