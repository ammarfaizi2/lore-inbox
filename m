Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTGLShQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268276AbTGLShQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:37:16 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:1684 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S268259AbTGLShP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:37:15 -0400
Date: Sat, 12 Jul 2003 19:51:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miguel Freitas <miguel@cetuc.puc-rio.br>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
Message-ID: <20030712185157.GC10450@mail.jlokier.co.uk>
References: <1058017391.1197.24.camel@mf> <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com> <20030712154942.GB9547@mail.jlokier.co.uk> <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com> <20030712162029.GE9547@mail.jlokier.co.uk> <1058028064.1196.111.camel@mf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058028064.1196.111.camel@mf>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Freitas wrote:
> > I'm wondering what happens if the tasks are both good, early to bed
> > without a fuss.  Neither runs their entire timeslice.
> > 
> > Or to illustrate: say xine uses 10% of my CPU.  What happens when I
> > open 11 xine windows?
> 
> well of course 110% is more than what you have of resources and xine
> would have to drop frames to keep it up... :)

That's fine.  The problem is, does this completely starve the other
tasks such as kswapd, ksoftirqd, bash etc.?

The real problem is can a user accidentally or malicious lock up a box
using SCHED_SOFTRR (when xmms, xine, GNU software radio and modem are
all using it :), and also what about multi-user boxes, can two users
accidentally break it.

Perhaps there should be a _global_ maximum amount of CPU used in
SCHED_SOFTRR beyond which SCHED_SOFTRR tasks get downgraded.

-- Jamie
