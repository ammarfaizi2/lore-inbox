Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUGYWsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUGYWsz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 18:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUGYWsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 18:48:55 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:19123 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264542AbUGYWsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 18:48:53 -0400
Subject: Re: preempt-timing-2.6.8-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu
In-Reply-To: <1090732537.738.2.camel@mindpipe>
References: <20040713122805.GZ21066@holomorphy.com>
	 <40F3F0A0.9080100@vision.ee>  <20040713143947.GG21066@holomorphy.com>
	 <1090732537.738.2.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1090795742.719.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 25 Jul 2004 18:49:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-25 at 01:15, Lee Revell wrote:
> On Tue, 2004-07-13 at 10:39, William Lee Irwin III wrote:
> > On Tue, Jul 13, 2004 at 05:24:32PM +0300, Lenar L?hmus wrote:
> > > What I've excluded (happens all the time):
> > > 1) 2ms non-preemptible critical section violated 1 ms preempt threshold 
> > > starting at schedule+0x36/0x480 and ending at do_IRQ+0xec/0x130
> > > it's 2ms 98%. This really happens all the time. Bogus?
> > 
> > Wild guess is that you took an IRQ in dec_preempt_count() and that threw
> > your results off. Let me know if the patch below helps at all. My guess
> > is it'll cause more apparent problems than it solves.
> 
> I applied the patch to 2.6.8-rc2 + voluntary-preempt-I4, and am
> constantly getting these:
> 

Here is another one:

Jul 25 18:46:18 mindpipe kernel: 11ms non-preemptible critical section violated 1 ms preempt threshold starting at kmap_atomic+0x10/0x60 and ending at kunmap_atomic+0x8/0x20
Jul 25 18:46:18 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 18:46:18 mindpipe kernel:  [dec_preempt_count+270/288] dec_preempt_count+0x10e/0x120
Jul 25 18:46:18 mindpipe kernel:  [kunmap_atomic+8/32] kunmap_atomic+0x8/0x20
Jul 25 18:46:18 mindpipe kernel:  [do_anonymous_page+139/400] do_anonymous_page+0x8b/0x190
Jul 25 18:46:18 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 25 18:46:18 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 25 18:46:18 mindpipe kernel:  [get_user_pages+288/944] get_user_pages+0x120/0x3b0
Jul 25 18:46:18 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
Jul 25 18:46:18 mindpipe kernel:  [do_mmap_pgoff+998/1568] do_mmap_pgoff+0x3e6/0x620
Jul 25 18:46:18 mindpipe kernel:  [sys_mmap2+118/176] sys_mmap2+0x76/0xb0
Jul 25 18:46:18 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Lee

