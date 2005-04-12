Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVDLFZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVDLFZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVDLFYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:24:49 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:38283 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S262024AbVDLEma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 00:42:30 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>
	<87wtr8rdvu.fsf@blackdown.de> <1113276365.5387.39.camel@gaston>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew
	Morton <akpm@osdl.org>, Linux Kernel list
	<linux-kernel@vger.kernel.org>
Date: Tue, 12 Apr 2005 06:42:22 +0200
In-Reply-To: <1113276365.5387.39.camel@gaston> (Benjamin Herrenschmidt's
	message of "Tue, 12 Apr 2005 13:26:05 +1000")
Message-ID: <87u0mc8v2p.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2005-04-12 at 03:18 +0200, Juergen Kreileder wrote:
>> Andrew Morton <akpm@osdl.org> writes:
>>
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
>>
>> I'm getting frequent lockups on my PowerMac G5 with rc2-mm3.
>>
>> 2.6.11-mm4 works fine but all 2.6.12 versions I've tried (all since
>> -rc1-mm3) lock up randomly.  The easiest way to reproduce the
>> problem seems to be running Azareus.  So it might be network
>> related, but I'm not 100% sure about that, there was a least one
>> deadlock with virtually no network usage.
>
> Hrm... I just noticed you have CONFIG_PREEMPT enabled... Can you
> test without it and let me know if it makes a difference ?

IIRC I had disabled that for rc2-mm2 and it didn't make a difference.
I'll disable it again when I try older versions.

I just got another crash with rc2-mm3.  The crash was a bit different
this time, I still could move the mouse pointer and the logs contained
some info:

Badness in slb_flush_and_rebolt at arch/ppc64/mm/slb.c:52
[c00000017690b860] [0000000000069a73] 0x69a73 (unreliable)
[c00000017690b900] [c00000000003b300] .__schedule_tail+0x9c/0x1b4
[c00000017690b9a0] [c0000000003162b0] .schedule+0x324/0x610
[c00000017690ba80] [c0000000003177e8] .schedule_timeout+0xfc/0x104
[c00000017690bb60] [c0000000000b6118] .do_select+0x278/0x4c4
[c00000017690bcb0] [c0000000000d6f4c] .compat_sys_select+0x390/0x690
[c00000017690bdc0] [c000000000019eb8] .ppc32_select+0x14/0x28
[c00000017690be30] [c00000000000da00] syscall_exit+0x0/0x18
Badness in slb_flush_and_rebolt at arch/ppc64/mm/slb.c:52
Call Trace:
[c00000016fe23860] [0000000000000413] 0x413 (unreliable)
[c00000016fe23900] [c00000000003b300] .__schedule_tail+0x9c/0x1b4
[c00000016fe239a0] [c0000000003162b0] .schedule+0x324/0x610
[c00000016fe23a80] [c000000000317774] .schedule_timeout+0x88/0x104
[c00000016fe23b60] [c0000000000b6118] .do_select+0x278/0x4c4
[c00000016fe23cb0] [c0000000000d6f4c] .compat_sys_select+0x390/0x690
[c00000016fe23dc0] [c000000000019eb8] .ppc32_select+0x14/0x28
[c00000016fe23e30] [c00000000000da00] syscall_exit+0x0/0x18
Badness in slb_flush_and_rebolt at arch/ppc64/mm/slb.c:52
Call Trace:
[c000000175d2b860] [0000000000000163] 0x163 (unreliable)
[c000000175d2b900] [c00000000003b300] .__schedule_tail+0x9c/0x1b4
[c000000175d2b9a0] [c0000000003162b0] .schedule+0x324/0x610
[c000000175d2ba80] [c000000000317774] .schedule_timeout+0x88/0x104
[c000000175d2bb60] [c0000000000b6118] .do_select+0x278/0x4c4
[c000000175d2bcb0] [c0000000000d6f4c] .compat_sys_select+0x390/0x690
[c000000175d2bdc0] [c000000000019eb8] .ppc32_select+0x14/0x28
[c000000175d2be30] [c00000000000da00] syscall_exit+0x0/0x18
Badness in slb_flush_and_rebolt at arch/ppc64/mm/slb.c:52
Call Trace:
[c000000178a17860] [0000000000000eb1] 0xeb1 (unreliable)
[c000000178a17900] [c00000000003b300] .__schedule_tail+0x9c/0x1b4
[c000000178a179a0] [c0000000003162b0] .schedule+0x324/0x610
[c000000178a17a80] [c000000000317774] .schedule_timeout+0x88/0x104
[c000000178a17b60] [c0000000000b6118] .do_select+0x278/0x4c4
[c000000178a17cb0] [c0000000000d6f4c] .compat_sys_select+0x390/0x690
[c000000178a17dc0] [c000000000019eb8] .ppc32_select+0x14/0x28
[c000000178a17e30] [c00000000000da00] syscall_exit+0x0/0x18
Badness in slb_flush_and_rebolt at arch/ppc64/mm/slb.c:52
Call Trace:
[c0000001767fba10] [0000000000001bca] 0x1bca (unreliable)

and so on until the machine switched into jet-fighter mode after:

[c00000016f887a10] [000000000001fc8c] 0x1fc8c (unreliable)
[c00000016f887ab0] [c00000000003b300] .__schedule_tail+0x9c/0x1b4
[c00000016f887b50] [c0000000003162b0] .schedule+0x324/0x610
[c00000016f887c30] [c000000000317774] .schedule_timeout+0x88/0x104
[c00000016f887d10] [c0000000000b6bb4] .sys_poll+0x3b8/0x4dc
[c00000016f887e30] [c00000000000da00] syscall_exit+0x0/0x18
Oops: Machine check, sig: 0 [#1]


Machine info:
* PowerMac7,2 with 2x 2GHz
* 4GB RAM
* 2 disks with ext3 partitions on top of LVM2
* Radeon 9800Pro with radeonfb and X (from Debian sid) at 1600x1200
* USB Mouse via evdev
* Bluetooth enabled but unused
* Firewire disabled
* No PCI cards
* Kernel compiled with gcc-3.4.2


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
