Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUIACae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUIACae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 22:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268757AbUIACad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 22:30:33 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:43145 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267469AbUIACa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 22:30:29 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040830090608.GA25443@elte.hu>
References: <1093715573.8611.38.camel@krustophenia.net>
	 <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu>
Content-Type: text/plain
Message-Id: <1094005829.3404.48.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 22:30:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 05:06, Ingo Molnar wrote:
> i've uploaded -Q5 to:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q5

Hmm, 385 usec latency triggered by 'lsof /smb' (this is a samba export):

preemption latency trace v1.0.2
-------------------------------
 latency: 385 us, entries: 626 (626)
    -----------------
    | task: lsof/17876, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: unix_seq_start+0x10/0x50
 => ended at:   unix_seq_stop+0xf/0x30
=======>
00000001 0.000ms (+0.000ms): unix_seq_start (seq_read)
00000001 0.000ms (+0.000ms): unix_seq_idx (unix_seq_start)
00000001 0.027ms (+0.027ms): unix_seq_show (seq_read)
00000002 0.028ms (+0.000ms): sock_i_ino (unix_seq_show)
00000002 0.029ms (+0.001ms): seq_printf (unix_seq_show)
00000002 0.030ms (+0.000ms): vsnprintf (seq_printf)
00000002 0.032ms (+0.002ms): number (vsnprintf)
00000002 0.036ms (+0.004ms): skip_atoi (vsnprintf)
00000002 0.037ms (+0.000ms): number (vsnprintf)
00000002 0.038ms (+0.001ms): skip_atoi (vsnprintf)
00000002 0.039ms (+0.000ms): number (vsnprintf)
00000002 0.039ms (+0.000ms): skip_atoi (vsnprintf)
00000002 0.040ms (+0.000ms): number (vsnprintf)
00000002 0.041ms (+0.000ms): skip_atoi (vsnprintf)
00000002 0.041ms (+0.000ms): number (vsnprintf)
00000002 0.042ms (+0.000ms): skip_atoi (vsnprintf)
00000002 0.043ms (+0.000ms): number (vsnprintf)
00000002 0.043ms (+0.000ms): skip_atoi (vsnprintf)
00000002 0.044ms (+0.000ms): number (vsnprintf)
00000002 0.046ms (+0.001ms): seq_putc (unix_seq_show)
00000002 0.047ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.047ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.047ms (+0.000ms): seq_putc (unix_seq_show)

...

00000002 0.374ms (+0.000ms): number (vsnprintf)
00000002 0.375ms (+0.000ms): skip_atoi (vsnprintf)
00000002 0.376ms (+0.000ms): number (vsnprintf)
00000002 0.377ms (+0.001ms): seq_putc (unix_seq_show)
00000002 0.377ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.378ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.378ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.378ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.379ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.379ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.380ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.380ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.380ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.381ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.381ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.381ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.382ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.382ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.382ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.383ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.383ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.383ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.384ms (+0.000ms): seq_putc (unix_seq_show)
00000001 0.384ms (+0.000ms): preempt_schedule (unix_seq_show)
00000001 0.384ms (+0.000ms): seq_putc (unix_seq_show)
00000001 0.385ms (+0.000ms): unix_seq_stop (seq_read)
00000001 0.386ms (+0.000ms): sub_preempt_count (unix_seq_stop)
00000001 0.386ms (+0.000ms): _mmx_memcpy (check_preempt_timing)
00000001 0.387ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

Full trace:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q5#/var/www/2.6.9-rc1-Q5/trace9.txt

Lee

