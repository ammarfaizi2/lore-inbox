Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269194AbUHaVEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269194AbUHaVEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUHaVC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:02:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:31449 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269176AbUHaUeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:34:14 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040831202051.GA1111@elte.hu>
References: <20040830090608.GA25443@elte.hu>
	 <1093934448.5403.4.camel@krustophenia.net> <20040831070658.GA31117@elte.hu>
	 <1093980065.1603.5.camel@krustophenia.net> <20040831193734.GA29852@elte.hu>
	 <1093981634.1633.2.camel@krustophenia.net> <20040831195107.GA31327@elte.hu>
	 <20040831200912.GA32378@elte.hu>
	 <1093983034.1633.11.camel@krustophenia.net> <20040831201420.GA899@elte.hu>
	 <20040831202051.GA1111@elte.hu>
Content-Type: text/plain
Message-Id: <1093984452.1596.0.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 16:34:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 16:20, Ingo Molnar wrote:
> so ... could you try the patch below - does it work and how does the
> latency look like now? (ontop of an unmodified generic.c)
> 

Now it looks like this:

preemption latency trace v1.0.2
-------------------------------
 latency: 574 us, entries: 19 (19)
    -----------------
    | task: X/1391, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: cond_resched+0xd/0x40
 => ended at:   sys_ioctl+0xdf/0x290
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (cond_resched)
00000001 0.000ms (+0.000ms): do_blank_screen (vt_ioctl)
00000001 0.000ms (+0.000ms): is_console_locked (do_blank_screen)
00000001 0.001ms (+0.000ms): hide_cursor (do_blank_screen)
00000001 0.002ms (+0.000ms): vgacon_cursor (hide_cursor)
00000001 0.004ms (+0.001ms): hide_softcursor (do_blank_screen)
00000001 0.004ms (+0.000ms): is_console_locked (do_blank_screen)
00000001 0.004ms (+0.000ms): vgacon_save_screen (do_blank_screen)
00000001 0.005ms (+0.000ms): _mmx_memcpy (vgacon_save_screen)
00000001 0.006ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)
00000001 0.481ms (+0.475ms): vgacon_blank (do_blank_screen)
00000001 0.481ms (+0.000ms): vgacon_set_origin (vgacon_blank)
00000001 0.573ms (+0.091ms): set_origin (vt_ioctl)
00000001 0.573ms (+0.000ms): is_console_locked (set_origin)
00000001 0.573ms (+0.000ms): vgacon_set_origin (set_origin)
00000001 0.574ms (+0.000ms): release_console_sem (vt_ioctl)
00000001 0.575ms (+0.000ms): sub_preempt_count (sys_ioctl)
00000001 0.575ms (+0.000ms): _mmx_memcpy (check_preempt_timing)
00000001 0.575ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

Lee

