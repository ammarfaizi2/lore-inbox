Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVBXUIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVBXUIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 15:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVBXUIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 15:08:32 -0500
Received: from calma.pair.com ([209.68.1.95]:35341 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S262462AbVBXUID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 15:08:03 -0500
Date: Thu, 24 Feb 2005 15:08:02 -0500
From: "Chad N. Tindel" <chad@tindel.net>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Paulo Marques <pmarques@grupopie.com>, Mike Galbraith <EFAULT@gmx.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050224200802.GA39590@calma.pair.com>
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com> <421E1AC1.1020901@nortel.com> <20050224183851.GA24359@calma.pair.com> <421E2528.8060305@grupopie.com> <20050224192237.GA31894@calma.pair.com> <421E2EF9.9010209@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E2EF9.9010209@nortel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >I'm all for allowing people to shoot themselves in the foot.  That doesn't
> >mean that it is OK for a single userspace thread to mess up a 64-way box.
> 
> If root has explicitly stated that the thread in question is the highest 
> priority thing on the entire machine, why would it not be okay.  The 
> fact that root made a mistake is the issue here, not that the system 
> didn't protect itself.

Yeah, I realized when I left for lunch that this statement wasn't as clear
as I would like it to be.

I think what we have are the need for two levels of applications:

1.  That which wishes to be the highest priority userspace application, and
wishes to preempt all other userspace applications.  Such an application is
OK being preempted by the kernel when the kernel needs to do work.  IMHO, this
should be the default behavior for any SCHED_FIFO application.  If one of these
has a bug and goes CPU-bound, the worst it can do is prevent other apps from
ever using the CPU it is on.

2.  Applications which actually want to be the highest priority thing on
the system, including being higher than the kernel.  These applications are
OK with the fact that they may cause system hangs and deadlocks, and are
careful not to shoot themselves in the foot.

> There are professionals who use linux for audio as well, it's not just 
> home systems.  That said, you unify them with reasonable defaults, and 
> the ability for root to override them.

OK.  Would you say it would be a reasonable default to have SCHED_FIFO userspace
threads running at a lower priority than essential kernel threads (say, the
load balancer and the events thread), and give root the ability to explicitly 
have userspace threads preempt the kernel?

Chad
