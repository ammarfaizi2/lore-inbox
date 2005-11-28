Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVK1CDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVK1CDg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 21:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVK1CDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 21:03:36 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:50146 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751222AbVK1CDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 21:03:35 -0500
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051127123052.GA22807@elte.hu>
References: <1132987928.4896.1.camel@mindpipe>
	 <20051126122332.GA3712@elte.hu> <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu>
Content-Type: text/plain
Date: Sun, 27 Nov 2005 20:27:03 -0500
Message-Id: <1133141224.4909.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-27 at 13:30 +0100, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Sat, 2005-11-26 at 14:05 -0500, Lee Revell wrote:
> > 
> > > -rt19 seems to work except that asm/io_apic.h fails to include 
> > > asm/apicdef.h so MAX_IO_APICS is undefined.
> > 
> > The patch below fixes the Makefile x86_64 clutter and the io_apic 
> > compile problem
> 
> thanks, applied.
> 

-rt20 BUGs and dies on boot with an assertion at line 1931 of
fs/jbd/transaction.c:

1924 void __journal_file_buffer(struct journal_head *jh,
1925                         transaction_t *transaction, int jlist)
1926 {
1927         struct journal_head **list = NULL;
1928         int was_dirty = 0;
1929         struct buffer_head *bh = jh2bh(jh);
1930 
1931         J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
1932         assert_spin_locked(&transaction->t_journal->j_list_lock);
1933 

Lee


