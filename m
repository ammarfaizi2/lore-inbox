Return-Path: <linux-kernel-owner+w=401wt.eu-S965094AbXADXgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbXADXgP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbXADXgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:36:15 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:37704 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965094AbXADXgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:36:14 -0500
X-Greylist: delayed 4170 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 18:36:14 EST
Date: Fri, 5 Jan 2007 00:26:42 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: execve hanging in selinux_bprm_post_apply_creds
Message-ID: <20070104222642.GA9440@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.19.1 SMP on Pentium D.  I ran command restorecon -R /wrk.
After a while or two programs stopped responding and I had to reboot.

I'm not sure is this bug or feature...
I upgraded selinux policy before running restorecon.

2007-01-04 22:41:55.360538500 <4>softlimit     D 61707865     0 18679  18678                     (NOTLB)
2007-01-04 22:41:55.360549500 <4>       ec5efdd0 00000046 f8964fda 61707865 0000006a 00000072 00000043 0000005b 
2007-01-04 22:41:55.360551500 <4>       f7264580 000000a9 000000fb 0000000e 000000cc 00000055 c1805700 f4f2e13c
2007-01-04 22:41:55.360553500 <4>       0001be4d 1f64183b 0000073d f4f2e030 c05785ac 00000246 f4f2e030 ec5efe18 
2007-01-04 22:41:55.360554500 <4>Call Trace:
2007-01-04 22:41:55.360571500 <4> [<c04b490e>] __mutex_lock_slowpath+0x85/0x1df
2007-01-04 22:41:55.360572500 <4> [<c04b487c>] mutex_lock+0x21/0x24
2007-01-04 22:41:55.360573500 <4> [<c0279dde>] selinux_bprm_post_apply_creds+0x65/0x40a
2007-01-04 22:41:55.360575500 <4> [<c01720cb>] compute_creds+0x4f/0x52
2007-01-04 22:41:55.360576500 <4> [<c019a788>] load_elf_binary+0x944/0xd0e
2007-01-04 22:41:55.360589500 <4> [<c01721f3>] search_binary_handler+0x9a/0x24c
2007-01-04 22:41:55.360590500 <4> [<c0172508>] do_execve+0x163/0x1f1
2007-01-04 22:41:55.360592500 <4> [<c01019fd>] sys_execve+0x32/0x84
2007-01-04 22:41:55.360593500 <4> [<c0102e73>] syscall_call+0x7/0xb
2007-01-04 22:41:55.360594500 <4> [<00ecc410>] 0xecc410
2007-01-04 22:41:55.360620500 <4> =======================

...

2007-01-04 22:41:55.359020500 <4>crond         D DDC59E64     0 18627   1837         18668       (NOTLB)
2007-01-04 22:41:55.359022500 <4>       ddc59e78 00000046 c01454c5 ddc59e64 ddc59e58 c04f4d56 ddc59e74 000000d0 
2007-01-04 22:41:55.359033500 <4>       f7a50ac0 f78d8a5e 000006e3 000011f7 00000000 c1967030 c17fd700 d10a6b7c 
2007-01-04 22:41:55.359034500 <4>       000166f0 f78db4eb 000006e3 d10a6a70 c05785ac 00000246 d10a6a70 ddc59ec0 
2007-01-04 22:41:55.359036500 <4>Call Trace:
2007-01-04 22:41:55.359037500 <4> [<c04b490e>] __mutex_lock_slowpath+0x85/0x1df
2007-01-04 22:41:55.359047500 <4> [<c04b487c>] mutex_lock+0x21/0x24
2007-01-04 22:41:55.359049500 <4> [<c01491b7>] audit_log_exit+0x120/0x799
2007-01-04 22:41:55.359050500 <4> [<c0149c1b>] audit_syscall_exit+0x75/0x325
2007-01-04 22:41:55.359051500 <4> [<c010677a>] do_syscall_trace+0x1a5/0x1eb
--
2007-01-04 22:41:55.359305500 <4>       00002d6d 33456ed0 000006e5 e7163a70 7fffffff 7fffffff ed0aa9e0 e4c03d5c 
2007-01-04 22:41:55.359306500 <4>Call Trace:
2007-01-04 22:41:55.359319500 <4> [<c04b464c>] schedule_timeout+0x94/0x96
2007-01-04 22:41:55.359321500 <4> [<c048802c>] unix_stream_data_wait+0xa0/0xe7
2007-01-04 22:41:55.359322500 <4> [<c0488334>] unix_stream_recvmsg+0x2c1/0x414
2007-01-04 22:41:55.359323500 <4> [<c0418be3>] do_sock_read+0xc4/0xcc
2007-01-04 22:41:55.359334500 <4> [<c0418c55>] sock_aio_read+0x6a/0x7b
2007-01-04 22:41:55.359335500 <4> [<c016d3c9>] do_sync_read+0xca/0x119
2007-01-04 22:41:55.359337500 <4> [<c016d4cc>] vfs_read+0xb4/0x18a
2007-01-04 22:41:55.359338500 <4> [<c016d884>] sys_read+0x3d/0x64
2007-01-04 22:41:55.359349500 <4> [<c0102e73>] syscall_call+0x7/0xb
2007-01-04 22:41:55.359350500 <4> [<00ecc410>] 0xecc410


-- 
