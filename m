Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbUK3Twz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbUK3Twz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUK3Twz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:52:55 -0500
Received: from kenga.kmv.ru ([217.13.212.5]:4238 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id S262301AbUK3TrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:47:14 -0500
Date: Tue, 30 Nov 2004 22:46:56 +0300
From: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: [RESOLVED] Re: [2.4.28-rc1] process stuck in release_task() call
Message-ID: <20041130194656.GA24188@kmv.ru>
References: <20041109162445.GM24130@kmv.ru> <20041110185813.GD12867@logos.cnet> <20041111083312.GE783@alpha.home.local> <20041111080102.GB15278@logos.cnet> <20041112135942.GW24130@kmv.ru> <20041116100639.GA11948@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116100639.GA11948@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
X-Data-Status: msg.XXUQomYG:7634@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo, Willy!
 On Tue, Nov 16, 2004 at 08:06:42AM -0200, Marcelo Tosatti wrote next:

> On Fri, Nov 12, 2004 at 04:59:42PM +0300, Andrey J. Melnikoff (TEMHOTA) wrote:
> Andrey,
> 
> I do not have much of a clue of what is going on here.
show_trace() has made a fool of me and I started to ask silly questions :)
 
> Can you try 2.4.27 please?
Ok, i'm tested 2.4.25 - same result. But this is complete userland problem.

There two problem:

First - show_trace() give incorrect traces. it strat unwind stack from
address in `tsk->thread.esp', but it should use address saved in `regs->ebp'
- this make more accuracy stack trace.

Second - strange libpthreads problem. 
libpthreads always install own sa_restorer helper, and when first signal
arrived - call signal handler and if (when process in signal handler)
arrived new signal - lipthreads start play with rt_sigprocmask() and
rt_sigsuspend() syscalls inside own sa_restorer helper. 
woops - infinity loop inside libpthreads.

-- 
 Best regards, TEMHOTA-RIPN aka MJA13-RIPE
 System Administrator. mailto:temnota@kmv.ru

