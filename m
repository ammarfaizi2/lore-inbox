Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933673AbWKQPpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933673AbWKQPpz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933676AbWKQPpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:45:55 -0500
Received: from port254.ds1-he.adsl.cybercity.dk ([217.157.198.197]:15441 "EHLO
	gere.msconsult.dk") by vger.kernel.org with ESMTP id S933673AbWKQPpy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:45:54 -0500
To: Oleg Verych <olecom@flower.upol.cz>
Cc: rasmus@msconsult.dk (=?utf-8?q?Rasmus_B=C3=B8g_Hansen?=),
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: smbfs (Re: BUG: soft lockup detected on CPU#0! (2.6.18.2))
References: <867ixyvum6.fsf@gere.msconsult.dk>
	<slrnelofru.7lr.olecom@flower.upol.cz>
From: rasmus@msconsult.dk (=?utf-8?q?Rasmus_B=C3=B8g_Hansen?=)
Date: Fri, 17 Nov 2006 16:45:30 +0100
In-Reply-To: <slrnelofru.7lr.olecom@flower.upol.cz> (Oleg Verych's message
 of "Thu, 16 Nov 2006 10:37:50 +0000")
Message-ID: <86odr6f55x.fsf@gere.msconsult.dk>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Organization: MS Consult
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-MSC-MailScanner: Found to be clean
X-MSC-MailScanner-From: rasmus@msconsult.dk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Verych <olecom@flower.upol.cz> writes:

> [ Adding e-mail of Andrew Morton, he may have clue about who to ping ;]
> [ MAINTAINERS.smbfs seems to be emply                                 ]
>
> On 2006-11-14, Rasmus BЬg Hansen wrote:
> []
>> [1.] One line summary of the problem:
>>
>> Kernel BUG's and freezes after a soft lockup.
>>
>> [2.] Full description of the problem/report:
>>
>> The night before sunday, my server froze. It was entirely dead and had
>> to be power cycled. There was no seriel console connected but it
>> managed to log a short BUG before, which seems related to smbfs.
>>
>> As it happened in the night, I am unsure what triggered the bug, but
>> it was during the nightly backup routines, which includes running
>> rsync over ssh (over ADSL so pretty slow) and writing some large
>> .tar.bz2 to a smbfs drive. I assume (but do no know for sure) that it
>> was the last one that triggered the bug.
>
> Nobody seems to picked this up. So.
> Why don't you try debian's kernel 2.6.18 from unstable?

I haven't tried that, partially to get rid of the initrd and have
drivers for the controllers/disks in-kernel, partially because I like
having built my own kernel. That might be silly, of course - I can try
the Debian kernel, if you think it would make a difference.

> I see, you've build it yourself, then try to enable some more locking
> debuging in the "kernel hacking" section.

I am now running with all lock debugging turned on. "Unfortunately"
the machine has been running stable since the crash last weekend -
perhaps the extra-large backup rourines at sunday may trigger it
again...

> (gitweb down, i can't check history of smbfs, and i have amd64 arch, anyway)
>> Nov 12 03:54:57 gere kernel: BUG: soft lockup detected on CPU#0!
>> Nov 12 03:54:57 gere kernel:  [softlockup_tick+170/195] softlockup_tick+0xaa/0xc3
>> Nov 12 03:54:57 gere kernel:  [update_process_times+56/137] update_process_times+0x38/0x89
>> Nov 12 03:54:57 gere kernel:  [smp_apic_timer_interrupt+105/117] smp_apic_timer_interrupt+0x69/0x75
>> Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
> this
>
>> Nov 12 03:54:57 gere kernel:  [apic_timer_interrupt+31/36] apic_timer_interrupt+0x1f/0x24
>> Nov 12 03:54:57 gere kernel:  [journal_init_revoke+49/678] journal_init_revoke+0x31/0x2a6
>> Nov 12 03:54:57 gere kernel:  [smbiod+238/348] smbiod+0xee/0x15c
> and this *may be* double (un)lock.

Hopefully lock debugging will tell.

Regards
/Rasmus

-- 
Rasmus Bøg Hansen
MSC Aps
Bøgesvinget 8
2740 Skovlunde
44 53 93 66

