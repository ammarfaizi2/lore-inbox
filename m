Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132287AbRCWA6J>; Thu, 22 Mar 2001 19:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132286AbRCWA6A>; Thu, 22 Mar 2001 19:58:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39942 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132276AbRCWA5o>; Thu, 22 Mar 2001 19:57:44 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Re : [CHECKER] 28 potential interrupt errors
Date: 22 Mar 2001 16:56:59 -0800
Organization: Transmeta Corporation
Message-ID: <99e70r$uvg$1@penguin.transmeta.com>
In-Reply-To: <20010322153641.B13162@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010322153641.B13162@bougret.hpl.hp.com>,
Jean Tourrilhes  <jt@bougret.hpl.hp.com> wrote:
>
>	I agree that the IrDA stack is full of irq/locking bugs (there
>is a patch of mine waiting in Dag's mailbox), but this one is not a
>bug, it's a false positive.
>	The restore_flags(flags); will restore the state of the
>interrupt register before the cli happened, so will automatically
>reenable interrupts.

Look closer. The error report is a big bogus, because it points out as
an error the "return" that is _correct_, not the "return" that is buggy.

Their checkers verify that all exists out of a function have the same
characteristics, and they found a case where one exit exists with
interrupts still disabled, while another one exists after having done a
"restore_flags()". 

So it looks like a real bug, it's just that the error is the _earlier_
return value, not the one pointed at.

		Linus
