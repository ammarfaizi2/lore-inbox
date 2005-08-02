Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVHBDzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVHBDzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 23:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVHBDzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 23:55:55 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:13494 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261266AbVHBDzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 23:55:53 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1122931238.4623.17.camel@dhcp153.mvista.com>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <1122931238.4623.17.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 01 Aug 2005 23:55:35 -0400
Message-Id: <1122954935.6759.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 14:20 -0700, Daniel Walker wrote:
> It means that IRQ 14 is running for a long time as an RT task 

Oh yeah, I forgot to comment on this.  Yes IRQ 14 is rather slow. It's
the IDE drive interrupt and it gets pretty busy.  Actually the check
doesn't really see if it is running for a long time, since it gets
scheduled out.  But I'm running this on a slow 368MHz machine and it
takes some time. There's cases where every second the interrupt just
happened to be running, since that is what it checks.  It doesn't check
to see if the thread actual sleeps.

I may add something to your patch to see if a thread actually goes to
sleep. If it doesn't then to flag it as possible stuck.

-- Steve


