Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423715AbWKPKbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423715AbWKPKbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423740AbWKPKbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:31:12 -0500
Received: from main.gmane.org ([80.91.229.2]:40844 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423727AbWKPKbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:31:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: smbfs (Re: BUG: soft lockup detected on CPU#0! (2.6.18.2))
Date: Thu, 16 Nov 2006 10:30:41 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnelofru.7lr.olecom@flower.upol.cz>
References: <867ixyvum6.fsf@gere.msconsult.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding e-mail of Andrew Morton, he may have clue about who to ping ;]
[ MAINTAINERS.smbfs seems to be emply                                 ]

On 2006-11-14, Rasmus Bøg Hansen wrote:
[]
> [1.] One line summary of the problem:
>
> Kernel BUG's and freezes after a soft lockup.
>
> [2.] Full description of the problem/report:
>
> The night before sunday, my server froze. It was entirely dead and had
> to be power cycled. There was no seriel console connected but it
> managed to log a short BUG before, which seems related to smbfs.
>
> As it happened in the night, I am unsure what triggered the bug, but
> it was during the nightly backup routines, which includes running
> rsync over ssh (over ADSL so pretty slow) and writing some large
> .tar.bz2 to a smbfs drive. I assume (but do no know for sure) that it
> was the last one that triggered the bug.

Nobody seems to picked this up. So.
Why don't you try debian's kernel 2.6.18 from unstable?

I see, you've build it yourself, then try to enable some more locking
debuging in the "kernel hacking" section.

(gitweb down, i can't check history of smbfs, and i have amd64 arch, anyway)
> Nov 12 03:54:57 gere kernel: BUG: soft lockup detected on CPU#0!
> Nov 12 03:54:57 gere kernel:  [softlockup_tick+170/195] softlockup_tick+0xaa/0xc3
> Nov 12 03:54:57 gere kernel:  [update_process_times+56/137] update_process_times+0x38/0x89
> Nov 12 03:54:57 gere kernel:  [smp_apic_timer_interrupt+105/117] smp_apic_timer_interrupt+0x69/0x75
> Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
this

> Nov 12 03:54:57 gere kernel:  [apic_timer_interrupt+31/36] apic_timer_interrupt+0x1f/0x24
> Nov 12 03:54:57 gere kernel:  [journal_init_revoke+49/678] journal_init_revoke+0x31/0x2a6
> Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
and this *may be* double (un)lock.

> I will, of course, post useful information, if necessary.
____

