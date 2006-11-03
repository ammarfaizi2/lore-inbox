Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753361AbWKCSO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbWKCSO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbWKCSO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:14:29 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:58566 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1753361AbWKCSO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:14:28 -0500
Date: Fri, 3 Nov 2006 21:14:21 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       arjan <arjan@infradead.org>
Subject: Re: [PATCH] lockdep: fix delayacct locking bug
Message-ID: <20061103181421.GA602@oleg>
References: <1162572527.26989.22.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162572527.26989.22.camel@twins>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03, Peter Zijlstra wrote:
> 
> ======================================================
> [ INFO: soft-safe -> soft-unsafe lock order detected ]
> 2.6.19-rc4 #1
> ------------------------------------------------------
> mm_tester/1875 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>  (&tsk->delays->lock){--..}, at: [<c0156652>] __delayacct_add_tsk+0x131/0x1d3
> 
> and this task is already holding:
>  (&sighand->siglock){.+..}, at: [<c0156b69>] taskstats_exit_send+0x52/0x3b2
> which would create a new lock dependency:
>  (&sighand->siglock){.+..} -> (&tsk->delays->lock){--..}

Thanks.

I introduced this bug in
	"[PATCH 5/6] taskstats: kill ->taskstats_lock in favor of ->siglock"

Oleg.

