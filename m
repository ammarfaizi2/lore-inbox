Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbTLEWzp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbTLEWzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:55:45 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:30089
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264583AbTLEWzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:55:44 -0500
Date: Fri, 5 Dec 2003 23:56:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Kristian Peters <kristian.peters@korseby.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: oom killer in 2.4.23
Message-ID: <20031205225615.GE2121@dualathlon.random>
References: <Z6Iv-7O2-29@gated-at.bofh.it> <Z8Ag-3BK-3@gated-at.bofh.it> <Zbyn-23P-29@gated-at.bofh.it> <20031205140520.39289a3a.kristian.peters@korseby.net> <20031205223825.GQ29119@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205223825.GQ29119@mis-mike-wstn.matchmail.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 02:38:25PM -0800, Mike Fedyk wrote:
> On Fri, Dec 05, 2003 at 02:05:20PM +0100, Kristian Peters wrote:
> 
> > Dec  5 13:34:41 adlib kernel: VM: killing process khexedit
> > Dec  5 13:37:27 adlib kernel: VM: killing process mozilla-bin
> > Dec  5 13:37:56 adlib kernel: VM: killing process mozilla-bin
> > Dec  5 13:40:32 adlib kernel: VM: killing process XFree86
> 
> This is with 2.4.23?
> 
> Why is the VM killing anything if the oom-killer is removed?

the 2.4.23 kernel will kill the task that triggered the oom condition,
it has to kill something of course, and the task that triggered the oom
during the page fault is the only one we can kill synchronously easily,
in turn guaranteeing that the machine won't deadlock in omm.

the oom killer normally is meant as the heuristc that chooses a special
task to kill, instead of the one that triggered the oom condition. But
choosing a different task and not the one that triggered the oom in the
page fault, isn't math safe w.r.t deadlocks.
