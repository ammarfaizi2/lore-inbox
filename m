Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVFAWfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVFAWfY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVFAWdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:33:41 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:2376
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261346AbVFAWdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:33:01 -0400
Date: Thu, 2 Jun 2005 00:32:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bill Huey <bhuey@lnxw.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601223250.GH5413@g5.random>
References: <20050601192224.GV5413@g5.random> <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk> <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com> <20050601203212.GZ5413@g5.random> <20050601204612.GA27934@nietzsche.lynx.com> <20050601210716.GB5413@g5.random> <20050601214257.GA28196@nietzsche.lynx.com> <20050601215913.GB28196@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601215913.GB28196@nietzsche.lynx.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 02:59:13PM -0700, Bill Huey wrote:
> I forgot. You basically turn it into one single big system wide mutex and
> and deal pathological cases as it turns up. Doing this is optional and
> if you can get away with letting the cli/sti function stay in place, then
> it's less work for us to handle.

Do you worry about "less work" after all this new stuff added? I'd
understand "less work" for a simple and safe solution like rtlinux/RTAI,
but going down your path, isn't looking for "less work" or "simpler".

The advantage you get with preempt-RT is a chance to run syscalls with
higher prio by sharing the same syscall code of the non-RT case, but
it'd be little advantage if you then have to lose in reliability.

The argument that only a subset of drivers is used isn't very valid,
people will just assume it to be hard-RT and they could build hardware
with random drivers thinking that they will get the gurantee. I
understand it's ok with you since you're able to evaluate the RT-safety
of every driver you use, but I sure prefer "ruby hard" solutions that
don't require looking into drivers to see if they're RT-safe.
