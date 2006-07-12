Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWGMLEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWGMLEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWGMLEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:04:33 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:11421 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751517AbWGMLEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:04:32 -0400
Date: Wed, 12 Jul 2006 23:42:30 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockdep: core, fix rq-lock handling on __ARCH_WANT_UNLOCKED_CTXSW
Message-ID: <20060712224230.GA7831@linux-mips.org>
References: <20060712202639.GA7719@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712202639.GA7719@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 10:26:39PM +0200, Ingo Molnar wrote:

> Subject: lockdep: core, fix rq-lock handling on __ARCH_WANT_UNLOCKED_CTXSW
> From: Ingo Molnar <mingo@elte.hu>
> 
> on platforms that have __ARCH_WANT_UNLOCKED_CTXSW set and want to 
> implement lock validator support there's a bug in rq->lock handling: in 
> this case we dont 'carry over' the runqueue lock into another task - but 
> still we did a spinlock_release() of it. Fix this by making the 
> spinlock_release() in context_switch() dependent on 
> !__ARCH_WANT_UNLOCKED_CTXSW.
> 
> (Reported by Ralf Baechle on MIPS, which has __ARCH_WANT_UNLOCKED_CTXSW. 
> This fixes a lockdep-internal BUG message on such platforms.)
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Tested and works as advertised for me,

  Ralf
