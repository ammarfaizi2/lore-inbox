Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269375AbUJLAOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269375AbUJLAOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269377AbUJLAOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:14:40 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:7720 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269375AbUJLAO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:14:26 -0400
Message-ID: <32923.192.168.1.5.1097539861.squirrel@192.168.1.5>
In-Reply-To: <20041011215909.GA20686@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
    <20041011215909.GA20686@elte.hu>
Date: Tue, 12 Oct 2004 01:11:01 +0100 (WEST)
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T5
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: mark_h_johnson@raytheon.com, "Andrew Morton" <akpm@osdl.org>,
       "Daniel Walker" <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, "Florian Schmidt" <mista.tapas@gmx.net>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Lee Revell" <rlrevell@joe-job.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 12 Oct 2004 00:14:23.0167 (UTC) FILETIME=[6D2994F0:01C4AFF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> i've uploaded -T5 which should fix most of the build issues:
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T5
>

Sharp roughness is the name of the game ;)

Built fine here, for P4 SMP/HT, and CONFIG_PREEMPT_REALTIME=y.

But, not surprisingly, booting/initing gives me lots of fireworks. This is
just some (tiny) sample taken from syslog:

Oct 12 00:15:26 gamma-suse1 kernel: Debug: sleeping function called from
invalid context pdflush(120) at kernel/mutex.c:23
Oct 12 00:15:26 gamma-suse1 kernel: in_atomic():1 [00000001],
irqs_disabled():1
Oct 12 00:15:26 gamma-suse1 kernel:  [__might_sleep+193/212]
__might_sleep+0xc1/0xd4
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0118fca>] __might_sleep+0xc1/0xd4
Oct 12 00:15:26 gamma-suse1 kernel:  [_mutex_lock+39/96]
_mutex_lock+0x27/0x60
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0130d0c>] _mutex_lock+0x27/0x60
Oct 12 00:15:26 gamma-suse1 kernel:  [_mutex_lock_irqsave+22/26]
_mutex_lock_irqsave+0x16/0x1a
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0130d7d>]
_mutex_lock_irqsave+0x16/0x1a
Oct 12 00:15:26 gamma-suse1 kernel:  [page_address+78/158]
page_address+0x4e/0x9e
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0149c97>] page_address+0x4e/0x9e
Oct 12 00:15:26 gamma-suse1 kernel:  [bio_hw_segments+12/48]
bio_hw_segments+0xc/0x30
Oct 12 00:15:26 gamma-suse1 kernel:  [<c01617ca>] bio_hw_segments+0xc/0x30
Oct 12 00:15:26 gamma-suse1 kernel:  [__make_request+1010/1251]
__make_request+0x3f2/0x4e3
Oct 12 00:15:26 gamma-suse1 kernel:  [<c023db69>] __make_request+0x3f2/0x4e3
Oct 12 00:15:26 gamma-suse1 kernel:  [generic_make_request+298/662]
generic_make_request+0x12a/0x296
Oct 12 00:15:26 gamma-suse1 kernel:  [<c023dee4>]
generic_make_request+0x12a/0x296
...

Oct 12 00:15:26 gamma-suse1 kernel: Debug: sleeping function called from
invalid context modprobe(1666) at kernel/mutex.c:23
Oct 12 00:15:26 gamma-suse1 kernel: in_atomic():1 [00000001],
irqs_disabled():1
Oct 12 00:15:26 gamma-suse1 kernel:  [__might_sleep+193/212]
__might_sleep+0xc1/0xd4
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0118fca>] __might_sleep+0xc1/0xd4
Oct 12 00:15:26 gamma-suse1 kernel:  [_mutex_lock+39/96]
_mutex_lock+0x27/0x60
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0130d0c>] _mutex_lock+0x27/0x60
Oct 12 00:15:26 gamma-suse1 kernel:  [_mutex_lock_irqsave+22/26]
_mutex_lock_irqsave+0x16/0x1a
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0130d7d>]
_mutex_lock_irqsave+0x16/0x1a
Oct 12 00:15:26 gamma-suse1 kernel:  [page_address+78/158]
page_address+0x4e/0x9e
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0149c97>] page_address+0x4e/0x9e
Oct 12 00:15:26 gamma-suse1 kernel:  [bio_hw_segments+12/48]
bio_hw_segments+0xc/0x30
Oct 12 00:15:26 gamma-suse1 kernel:  [<c01617ca>] bio_hw_segments+0xc/0x30
Oct 12 00:15:26 gamma-suse1 kernel:  [__make_request+1010/1251]
__make_request+0x3f2/0x4e3
Oct 12 00:15:26 gamma-suse1 kernel:  [<c023db69>] __make_request+0x3f2/0x4e3
Oct 12 00:15:26 gamma-suse1 kernel:  [generic_make_request+298/662]
generic_make_request+0x12a/0x296
Oct 12 00:15:26 gamma-suse1 kernel:  [<c023dee4>]
generic_make_request+0x12a/0x296
...

Oct 12 00:15:26 gamma-suse1 kernel: Debug: sleeping function called from
invalid context blogd(1851) at kernel/mutex.c:23
Oct 12 00:15:26 gamma-suse1 kernel: in_atomic():1 [00000001],
irqs_disabled():1
Oct 12 00:15:26 gamma-suse1 kernel:  [__might_sleep+193/212]
__might_sleep+0xc1/0xd4
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0118fca>] __might_sleep+0xc1/0xd4
Oct 12 00:15:26 gamma-suse1 kernel:  [_mutex_lock+39/96]
_mutex_lock+0x27/0x60
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0130d0c>] _mutex_lock+0x27/0x60
Oct 12 00:15:26 gamma-suse1 kernel:  [_mutex_lock_irqsave+22/26]
_mutex_lock_irqsave+0x16/0x1a
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0130d7d>]
_mutex_lock_irqsave+0x16/0x1a
Oct 12 00:15:26 gamma-suse1 kernel:  [page_address+78/158]
page_address+0x4e/0x9e
Oct 12 00:15:26 gamma-suse1 kernel:  [<c0149c97>] page_address+0x4e/0x9e
Oct 12 00:15:26 gamma-suse1 kernel:  [bio_hw_segments+12/48]
bio_hw_segments+0xc/0x30
Oct 12 00:15:26 gamma-suse1 kernel:  [<c01617ca>] bio_hw_segments+0xc/0x30
Oct 12 00:15:26 gamma-suse1 kernel:  [__make_request+1010/1251]
__make_request+0x3f2/0x4e3
Oct 12 00:15:26 gamma-suse1 kernel:  [<c023db69>] __make_request+0x3f2/0x4e3
Oct 12 00:15:26 gamma-suse1 kernel:  [generic_make_request+298/662]
generic_make_request+0x12a/0x296
Oct 12 00:15:26 gamma-suse1 kernel:  [<c023dee4>]
generic_make_request+0x12a/0x296
...

An so on, and so on...
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

