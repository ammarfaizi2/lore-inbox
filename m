Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVKNT4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVKNT4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVKNT4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:56:49 -0500
Received: from mail.timesys.com ([65.117.135.102]:23215 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S932069AbVKNT4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:56:48 -0500
Message-ID: <4378EA29.1000400@timesys.com>
Date: Mon, 14 Nov 2005 14:48:57 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
       john cooper <john.cooper@timesys.com>
Subject: Re: [BUG] Softlockup detected with linux-2.6.14-rt6
References: <4378B48E.6010006@gmail.com>
In-Reply-To: <4378B48E.6010006@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Nov 2005 19:51:16.0078 (UTC) FILETIME=[C62538E0:01C5E954]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Falavigna wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I found this softlockup bug involving arts daemon using a
> linux-2.6.14-rt6 kernel (with "Complete Preemption" and "Detect Soft
> Lockups" compiled in).
> This bug does not happen everytime: I was able to reproduce it only
> three times in a week. Here is the oops message (obtained from my
> printer because system is frozen):
> 
> BUG: artsd:4177, possible softlockup detected on CPU#0!
> [<c0146db4>] softlockup_detected+0x34/0x40 (8)
> [<c0146e69>] softlockup_tick+0xa9/axb0 (20)
> [<c01388a1>] timer_interrupt+0x21/0x40 (12)
> [<c014724e>] handle_IRQ_event+0x63/0xf0 (12)
> [<c01476a3>] __do_IRQ+0xa3/0x150 (48)
> [<c0105594>] do_IRQ+0x34/0x70 (40)
> [<c0103d42>] common_interrupt+0x1a/0x20 (8)
> [<c0103d42>] common_interrupt+0x1a/0x20 (20)
> [<c01bfcc0>] __delay+0x20/0x30 (44)
> [<c91f16a4>] snd_timer_close+0x1b4/0x2b0 [snd_timer] (12)
> [<c0a7f36a>] fasync_helper+0x7a/0x100 (12)
> [<c91f307c>] snd_timer_user_release+0x4c/0x80 [snd_timer] (28)
> [<c016c14d>] __fput+0xad/0x1a0 (24)
> [<c0a6a632>] filp_close+0x52/0x90 (40)
> [<c016a6e0>] sys_close+0x70/0xc0 (24)
> [<c01032fd>] syscall_call+0x7/0xb (28)

We are seeing this too, particularly [IIRC exclusively]
on MIPS and PPC though there isn't any obvious target
architecture correlation.  It appears to be a false
positive as the system seems otherwise responsive to
general scheduling.  It's on my list to address but not
a priority just yet.

Adding a sched pri/policy printk to show_task() and
inserting a call to show_state() in the softlockup
detect routine should shed some light.

-john

-- 
john.cooper@timesys.com
