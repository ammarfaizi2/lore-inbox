Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTFHJoM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 05:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTFHJoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 05:44:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1441 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261294AbTFHJoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 05:44:11 -0400
Date: Sun, 8 Jun 2003 11:57:04 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andi Kleen <ak@suse.de>
cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: taskfile merge breaking suse hwscan
In-Reply-To: <20030608082451.GA21200@wotan.suse.de>
Message-ID: <Pine.SOL.4.30.0306081149140.4589-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Jun 2003, Andi Kleen wrote:

> I just tried to boot a recent 2.5 amd64 kernel. Result is that it is
> hanging at boot during SuSE 8.2 hwscan.
>
> Backtrace points to the new IDE taskfile code:
>
> hwscan        D 0000000000000000 18446744073706259928   861    847                     (NOTLB)
>
> Call Trace:<ffffffff80136137>{wait_for_completion+439} <ffffffff802fca2d>{start_request+253}
>        <ffffffff80135910>{default_wake_function+0} <ffffffff802fce94>{ide_do_request+996}
>        <ffffffff80135910>{default_wake_function+0} <ffffffff802fdf36>{ide_do_drive_cmd+710}
>        <ffffffff801cc440>{proc_alloc_inode+64} <ffffffff80303a4b>{ide_diag_taskfile+203}
>        <ffffffff803023f1>{taskfile_lib_get_identify+97} <ffffffff80302e40>{task_in_intr+0}
>        <ffffffff8031477f>{proc_ide_read_identify+111} <ffffffff801d128a>{proc_file_read+234}
>        <ffffffff8018c1b6>{vfs_read+198} <ffffffff8018c3f9>{sys_read+73}
>        <ffffffff80122f06>{ia32_do_syscall+30}
> hdc: lost interrupt

hwscan is trying to read /proc/ide/hdX/identify.
Are you sure its taskfile merge, not something else?

> Followed by more lost interrupt messages.
>
> Any ideas?
>
> -Andi

