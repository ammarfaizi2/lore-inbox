Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUBCW6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 17:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266171AbUBCW6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 17:58:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:60109 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266163AbUBCW6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 17:58:10 -0500
Date: Tue, 3 Feb 2004 14:59:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, josh@stack.nl
Subject: Re: [PATCH] 2.6.1 Hyperthread smart "nice" 2
Message-Id: <20040203145929.01a96d9b.akpm@osdl.org>
In-Reply-To: <20040203105758.GA7783@elte.hu>
References: <200401291917.42087.kernel@kolivas.org>
	<200402022027.10151.kernel@kolivas.org>
	<20040202103122.GA29402@elte.hu>
	<200402032152.46481.kernel@kolivas.org>
	<20040203105758.GA7783@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> > At least it appears Intel are well aware of the priority problem, but
> > full priority support across logical cores is not likely. However I
> > guess these new instructions are probably enough to work with if
> > someone can do the coding.
> 
> these instructions can be used in the idle=poll code instead of rep-nop. 
> This way idle-wakeup can be done via the memory bus in essence, and the
> idle threads wont waste CPU time. (right now idle=poll wastes lots of
> cycles on HT boxes and is thus unusable.)

The code to do this was merged quite a while ago.  See
arch/i386/kernel/process.c:mwait_idle().

I was hoping to see a spinlock patch using mwait(), but nothing yet..
