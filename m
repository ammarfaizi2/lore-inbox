Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUHaUiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUHaUiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269172AbUHaUiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:38:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62172 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267633AbUHaUhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:37:39 -0400
Date: Tue, 31 Aug 2004 22:39:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831203900.GB2356@elte.hu>
References: <20040831070658.GA31117@elte.hu> <1093980065.1603.5.camel@krustophenia.net> <20040831193734.GA29852@elte.hu> <1093981634.1633.2.camel@krustophenia.net> <20040831195107.GA31327@elte.hu> <20040831200912.GA32378@elte.hu> <1093983034.1633.11.camel@krustophenia.net> <20040831201420.GA899@elte.hu> <20040831202051.GA1111@elte.hu> <1093984452.1596.0.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093984452.1596.0.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2004-08-31 at 16:20, Ingo Molnar wrote:
> > so ... could you try the patch below - does it work and how does the
> > latency look like now? (ontop of an unmodified generic.c)
> > 
> 
> Now it looks like this:
> 
> preemption latency trace v1.0.2
> -------------------------------
>  latency: 574 us, entries: 19 (19)
>     -----------------
>     | task: X/1391, uid:0 nice:0 policy:0 rt_prio:0
>     -----------------
>  => started at: cond_resched+0xd/0x40
>  => ended at:   sys_ioctl+0xdf/0x290
> =======>
> 00000001 0.000ms (+0.000ms): touch_preempt_timing (cond_resched)
> 00000001 0.000ms (+0.000ms): do_blank_screen (vt_ioctl)
> 00000001 0.000ms (+0.000ms): is_console_locked (do_blank_screen)
> 00000001 0.001ms (+0.000ms): hide_cursor (do_blank_screen)
> 00000001 0.002ms (+0.000ms): vgacon_cursor (hide_cursor)
> 00000001 0.004ms (+0.001ms): hide_softcursor (do_blank_screen)
> 00000001 0.004ms (+0.000ms): is_console_locked (do_blank_screen)
> 00000001 0.004ms (+0.000ms): vgacon_save_screen (do_blank_screen)
> 00000001 0.005ms (+0.000ms): _mmx_memcpy (vgacon_save_screen)
> 00000001 0.006ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)
> 00000001 0.481ms (+0.475ms): vgacon_blank (do_blank_screen)
> 00000001 0.481ms (+0.000ms): vgacon_set_origin (vgacon_blank)
> 00000001 0.573ms (+0.091ms): set_origin (vt_ioctl)
> 00000001 0.573ms (+0.000ms): is_console_locked (set_origin)
> 00000001 0.573ms (+0.000ms): vgacon_set_origin (set_origin)
> 00000001 0.574ms (+0.000ms): release_console_sem (vt_ioctl)
> 00000001 0.575ms (+0.000ms): sub_preempt_count (sys_ioctl)
> 00000001 0.575ms (+0.000ms): _mmx_memcpy (check_preempt_timing)
> 00000001 0.575ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

hm, this doesnt seem to be an mtrr latency - this is a text-console 
blanking operation apparently running with the BKL enabled.

	Ingo
