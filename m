Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbSJET4V>; Sat, 5 Oct 2002 15:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSJET4V>; Sat, 5 Oct 2002 15:56:21 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:47378
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262525AbSJET4S>; Sat, 5 Oct 2002 15:56:18 -0400
Subject: Re: Some backtraces (2.5.40-bk4 smp+preempt)
From: Robert Love <rml@tech9.net>
To: Helge Hafting <helge.hafting@broadpark.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D9F4A8A.190A6B5F@broadpark.no>
References: <3D9F4A8A.190A6B5F@broadpark.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 16:02:25 -0400
Message-Id: <1033848146.11402.4066.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 16:24, Helge Hafting wrote:

Thanks for the report...

> bad: scheduling while atomic!
> Call Trace:
>  [<c0117351>] schedule+0x3d/0x4f4
>  [<c0117bfd>] wait_for_completion+0x111/0x1c4
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c0119563>] set_cpus_allowed+0x217/0x240
>  [<c01195dc>] migration_thread+0x50/0x53c
>  [<c011958c>] migration_thread+0x0/0x53c
>  [<c0105591>] kernel_thread_helper+0x5/0xc

Known.  Not a problem but needs to be fixed.  set_cpus_allowed() sleeps
with preemption disabled.

> bad: scheduling while atomic!
> Call Trace: [<c0117351>] schedule+0x3d/0x4f4
>  [<c0117bfd>] wait_for_completion+0x111/0x1c4
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c0119563>] set_cpus_allowed+0x217/0x240
>  [<c0120c45>] ksoftirqd+0x51/0xe0
>  [<c0120bf4>] ksoftirqd+0x0/0xe0
>  [<c0105591>] kernel_thread_helper+0x5/0xc

Same thing.

> bad: scheduling while atomic!
> Call Trace:
>  [<c0117351>] schedule+0x3d/0x4f4
>  [<c0117bfd>] wait_for_completion+0x111/0x1c4
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c0119563>] set_cpus_allowed+0x217/0x240
>  [<c012a7b6>] worker_thread+0x9e/0x4ac
>  [<c012a718>] worker_thread+0x0/0x4ac
>  [<c0107521>] ret_from_fork+0x5/0x14
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c0105591>] kernel_thread_helper+0x5/0xc

Same.

> mtrr: v2.0 (20020519)
> mtrr: your CPUs had inconsistent fixed MTRR settings
> mtrr: probably your BIOS does not setup all CPUs

This is really an annoying "message".  Nearly every machine I see prints
this.  Can we just get rid of this?

> bad: scheduling while atomic!
> Call Trace:
>  [<c0117351>] schedule+0x3d/0x4f4
>  [<c0117bfd>] wait_for_completion+0x111/0x1c4
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c0119563>] set_cpus_allowed+0x217/0x240
>  [<c012a7b6>] worker_thread+0x9e/0x4ac
>  [<c012a718>] worker_thread+0x0/0x4ac
>  [<c0107521>] ret_from_fork+0x5/0x14
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c011784c>] default_wake_function+0x0/0x34
>  [<c0105591>] kernel_thread_helper+0x5/0xc

Same.

> Debug: sleeping function called from illegal context at
> /usr/src/linux/include/a
> sm/semaphore.h:119
> Call Trace:
>  [<c0119b84>] __might_sleep+0x54/0x58
>  [<c02ac327>] snd_trident_alloc_pages+0x4b/0xdc
>  [<c02a7969>] snd_trident_playback_hw_params+0xc5/0x190
>  [<c0280d12>] snd_pcm_hw_params+0xca/0x294
>  [<c0280f47>] snd_pcm_hw_params_user+0x6b/0xb4
>  [<c0284dc8>] snd_pcm_common_ioctl1+0x15c/0x2bc
>  [<c0285346>] snd_pcm_playback_ioctl1+0x41e/0x42c
>  [<c02856ef>] snd_pcm_kernel_playback_ioctl+0x27/0x30
>  [<c028574b>] snd_pcm_kernel_ioctl+0x23/0x40
>  [<c0277cf9>] snd_pcm_oss_change_params+0x429/0x66c
>  [<c02476d6>] sym_queue_scsiio+0x1fa/0x204
>  [<c0243ddf>] sym_start_next_ccbs+0xd7/0x10c
>  [<c0277f6e>] snd_pcm_oss_get_active_substream+0x32/0x50
>  [<c02789cc>] snd_pcm_oss_get_block_size+0x10/0x28
>  [<c0279d56>] snd_pcm_oss_ioctl+0x38a/0x768
>  [<c015b2bb>] sys_ioctl+0x27f/0x2fb
>  [<c01075c3>] syscall_call+0x7/0xb

I believe this is known, too.

Thank you,

	Robert Love

