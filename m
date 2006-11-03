Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753218AbWKCPIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbWKCPIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbWKCPIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:08:48 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:48912 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1753218AbWKCPIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:08:48 -0500
Message-ID: <454B5B56.4090307@shadowen.org>
Date: Fri, 03 Nov 2006 15:08:06 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: 2.6.19-rc4-mm2 -- reiserfs umount panic
References: <20061101235407.a92f94a5.akpm@osdl.org>
In-Reply-To: <20061101235407.a92f94a5.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just happened to be watching a console of a test box when it was
performing a post job reboot and caught the following panic.  This
specific machine is a ppc64.  Sadly these are not part of the job.

/me considers how we could fix that.  Perhaps we could just shove a
plain reboot at the end of one of the jobs ... hmmm.

-apw

REISERFS: panic (device sda3): journal_begin called without kernel lock held
kernel BUG in reiserfs_panic at fs/reiserfs/prints.c:361!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=32 NUMA
Modules linked in:
NIP: C000000000125A60 LR: C000000000125A5C CTR: 00000000000D0274
REGS: c00000076e693640 TRAP: 0700   Not tainted  (2.6.19-rc4-mm2-autokern1)
MSR: 8000000000029032 <EE,ME,IR,DR>  CR: 22008424  XER: 00000000
TASK = c00000003fb68250[16416] 'umount' THREAD: c00000076e690000 CPU: 2
GPR00: C000000000125A5C C00000076E6938C0 C0000000006662E8 0000000000000050
GPR04: 0000000000000000 FFFFFFFFFFFFFFFF 656C206C6F636B20 68656C640D0A726E
GPR08: 0000000000000000 C00000000054EAB8 C00000000068F810 C00000000068F808
GPR12: 00000000000D0274 C000000000545500 0000000000000000 0000000000000000
GPR16: 00000000100A7D10 00000000100A94E0 0000000010070000 0000000000000000
GPR20: 0000000010010000 00000000FFFFFFFF 0000000010019218 0000000000000000
GPR24: 0000000000000000 000000000000000A C00000076E693BC0 000000000000000A
GPR28: C000000000518800 C00000076E693BC0 C000000000579080 C000000000518800
NIP [C000000000125A60] .reiserfs_panic+0x6c/0x90
LR [C000000000125A5C] .reiserfs_panic+0x68/0x90
Call Trace:
[C00000076E6938C0] [C000000000125A5C] .reiserfs_panic+0x68/0x90 (unreliable)
[C00000076E693940] [C000000000134A38] .reiserfs_check_lock_depth+0x30/0x48
[C00000076E6939C0] [C00000000013A654] .do_journal_begin_r+0x58/0x434
[C00000076E693AB0] [C00000000013AC54] .journal_begin+0x108/0x170
[C00000076E693B50] [C000000000123130] .reiserfs_remount+0x194/0x460
[C00000076E693C50] [C0000000000B47D0] .do_remount_sb+0x1a8/0x224
[C00000076E693CF0] [C0000000000D0E98] .sys_umount+0x19c/0x2a0
[C00000076E693E30] [C00000000000872C] syscall_exit+0x0/0x40
Instruction dump:
f90100d8 f92100e0 f94100e8 4bfff11d 4192000c 389f0218 48000008 e89e8178
e87e8180 e8be8080 4bf289b5 60000000 <0fe00000> 4192000c 389f0218 48000008
 <3>Badness in do_exit at kernel/exit.c:853
Call Trace:
[C00000076E692E70] [C00000000000F198] .show_stack+0x74/0x1b4 (unreliable)
[C00000076E692F20] [C000000000021688] .program_check_exception+0x194/0x634
[C00000076E692FD0] [C000000000004774] program_check_common+0xf4/0x100
--- Exception: 700 at .do_exit+0x50/0xa1c
    LR = .do_exit+0x44/0xa1c
[C00000076E693380] [C000000000021038] .die+0x150/0x154
[C00000076E693410] [C000000000021264] ._exception+0x48/0x138
[C00000076E693520] [C000000000021B0C] .program_check_exception+0x618/0x634
[C00000076E6935D0] [C000000000004774] program_check_common+0xf4/0x100
--- Exception: 700 at .reiserfs_panic+0x6c/0x90
    LR = .reiserfs_panic+0x68/0x90
[C00000076E693940] [C000000000134A38] .reiserfs_check_lock_depth+0x30/0x48
[C00000076E6939C0] [C00000000013A654] .do_journal_begin_r+0x58/0x434
[C00000076E693AB0] [C00000000013AC54] .journal_begin+0x108/0x170
[C00000076E693B50] [C000000000123130] .reiserfs_remount+0x194/0x460
[C00000076E693C50] [C0000000000B47D0] .do_remount_sb+0x1a8/0x224
[C00000076E693CF0] [C0000000000D0E98] .sys_umount+0x19c/0x2a0
[C00000076E693E30] [C00000000000872C] syscall_exit+0x0/0x40
/etc/init.d/boot.d/K15boot.localfs: line 217: 16416 Trace/breakpoint
trap   umount -avt noproc,nonfs,nosmbfs
        failed
Oops: umount failed :-(  --  trying to remount readonly...


