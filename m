Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267809AbUHJXIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267809AbUHJXIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUHJXIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:08:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:61582 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267809AbUHJXH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:07:57 -0400
X-Authenticated: #4399952
Date: Wed, 11 Aug 2004 01:18:03 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-Id: <20040811011803.3f10d290@mango.fruits.de>
In-Reply-To: <1092174959.5061.6.camel@mindpipe>
References: <1090795742.719.4.camel@mindpipe>
	<20040726082330.GA22764@elte.hu>
	<1090830574.6936.96.camel@mindpipe>
	<20040726083537.GA24948@elte.hu>
	<1090832436.6936.105.camel@mindpipe>
	<20040726124059.GA14005@elte.hu>
	<20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
	<20040810132654.GA28915@elte.hu>
	<1092174959.5061.6.camel@mindpipe>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 17:56:00 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> The mlockall() issue seems to be fixed.  Now I get this one when
> starting jackd:
> 
> (jackd/12427): 10882us non-preemptible critical section violated 400
> us preempt threshold starting at kernel_fpu_begin+0x10/0x60 and ending
> at fast_clear_page+0x75/0xa0
>  [<c0106777>] dump_stack+0x17/0x20
>  [<c01140eb>] sub_preempt_count+0x4b/0x60
>  [<c01d1585>] fast_clear_page+0x75/0xa0
>  [<c013ea86>] do_anonymous_page+0x86/0x180
>  [<c013ebd0>] do_no_page+0x50/0x300
>  [<c013f041>] handle_mm_fault+0xc1/0x170
>  [<c013da33>] get_user_pages+0x133/0x3d0
>  [<c013f198>] make_pages_present+0x68/0x90
>  [<c0140948>] do_mmap_pgoff+0x3f8/0x640
>  [<c010b7f6>] sys_mmap2+0x76/0xb0
>  [<c0106117>] syscall_call+0x7/0xb

I see these, too [at jackd startup and at client startup]:

Aug 11 01:15:21 mango kernel: (jackd/843): 3215us non-preemptible
critical secti
on violated 1000 us preempt threshold starting at
kernel_fpu_begin+0x1a/0x60 and
 ending at fast_clear_page+0x54/0x80
Aug 11 01:15:21 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 11 01:15:21 mango kernel:  [<c0114735>] sub_preempt_count+0x45/0x60
Aug 11 01:15:21 mango kernel:  [<c01daa94>] fast_clear_page+0x54/0x80
Aug 11 01:15:21 mango kernel:  [<c0140150>] do_anonymous_page+0x90/0x190
Aug 11 01:15:21 mango kernel:  [<c01402b1>] do_no_page+0x61/0x320
Aug 11 01:15:21 mango kernel:  [<c0140763>] handle_mm_fault+0xe3/0x1a0
Aug 11 01:15:21 mango kernel:  [<c013f0e7>] get_user_pages+0x147/0x3d0
Aug 11 01:15:21 mango kernel:  [<c01408fd>] make_pages_present+0x8d/0xb0
Aug 11 01:15:21 mango kernel:  [<c0142255>] do_mmap_pgoff+0x445/0x6b0
Aug 11 01:15:21 mango kernel:  [<c010b800>] old_mmap+0xe0/0x120
Aug 11 01:15:21 mango kernel:  [<c0105f2b>] syscall_call+0x7/0xb
Aug 11 01:15:21 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN:
pcmC0D0p
Aug 11 01:15:21 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 11 01:15:21 mango kernel:  [<f08c2431>]
snd_pcm_period_elapsed+0x311/0x480 [
snd_pcm]
Aug 11 01:15:21 mango kernel:  [<f089ebce>]
snd_cs46xx_interrupt+0x1be/0x1f0 [sn
d_cs46xx]
Aug 11 01:15:21 mango kernel:  [<c011b55b>]
generic_handle_IRQ_event+0x3b/0x70
Aug 11 01:15:21 mango kernel:  [<c01078c6>] do_IRQ+0xb6/0x170
Aug 11 01:15:21 mango kernel:  [<c0106098>] common_interrupt+0x18/0x20
Aug 11 01:15:40 mango gconfd (tapas-803): GConf server is not in use,
shutting d
own.
Aug 11 01:15:40 mango gconfd (tapas-803): Exiting
Aug 11 01:16:01 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN:
pcmC0D0p
Aug 11 01:16:01 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 11 01:16:01 mango kernel:  [<f08c2431>]
snd_pcm_period_elapsed+0x311/0x480 [
snd_pcm]
Aug 11 01:16:01 mango kernel:  [<f089ebce>]
snd_cs46xx_interrupt+0x1be/0x1f0 [sn
d_cs46xx]
Aug 11 01:16:01 mango kernel:  [<c011b55b>]
generic_handle_IRQ_event+0x3b/0x70
Aug 11 01:16:01 mango kernel:  [<c01078c6>] do_IRQ+0xb6/0x170
Aug 11 01:16:01 mango kernel:  [<c0106098>] common_interrupt+0x18/0x20
Aug 11 01:16:01 mango kernel:  [<c0140150>] do_anonymous_page+0x90/0x190
Aug 11 01:16:01 mango kernel:  [<c01402b1>] do_no_page+0x61/0x320
Aug 11 01:16:01 mango kernel:  [<c0140763>] handle_mm_fault+0xe3/0x1a0
Aug 11 01:16:01 mango kernel:  [<c013f0e7>] get_user_pages+0x147/0x3d0
Aug 11 01:16:01 mango kernel:  [<c01408fd>] make_pages_present+0x8d/0xb0
Aug 11 01:16:01 mango kernel:  [<c0142255>] do_mmap_pgoff+0x445/0x6b0
Aug 11 01:16:01 mango kernel:  [<c010b800>] old_mmap+0xe0/0x120
Aug 11 01:16:01 mango kernel:  [<c0105f2b>] syscall_call+0x7/0xb
Aug 11 01:16:01 mango kernel: (scsynth/870): 3230us non-preemptible
critical sec
tion violated 1000 us preempt threshold starting at
kernel_fpu_begin+0x1a/0x60 a
nd ending at fast_clear_page+0x54/0x80
Aug 11 01:16:01 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 11 01:16:01 mango kernel:  [<c0114735>] sub_preempt_count+0x45/0x60
Aug 11 01:16:01 mango kernel:  [<c01daa94>] fast_clear_page+0x54/0x80
Aug 11 01:16:01 mango kernel:  [<c0140150>] do_anonymous_page+0x90/0x190
Aug 11 01:16:01 mango kernel:  [<c01402b1>] do_no_page+0x61/0x320
Aug 11 01:16:01 mango kernel:  [<c0140763>] handle_mm_fault+0xe3/0x1a0
Aug 11 01:16:01 mango kernel:  [<c013f0e7>] get_user_pages+0x147/0x3d0
Aug 11 01:16:01 mango kernel:  [<c01408fd>] make_pages_present+0x8d/0xb0
Aug 11 01:16:01 mango kernel:  [<c0142255>] do_mmap_pgoff+0x445/0x6b0
Aug 11 01:16:01 mango kernel:  [<c010b800>] old_mmap+0xe0/0x120
Aug 11 01:16:01 mango kernel:  [<c0105f2b>] syscall_call+0x7/0xb

Flo


-- 
Palimm Palimm!
http://affenbande.org/~tapas/

