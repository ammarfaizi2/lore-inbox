Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbTHWSCN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 14:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264077AbTHWR63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:58:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32384
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264833AbTHWRxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 13:53:30 -0400
Date: Fri, 22 Aug 2003 15:57:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hannes Reinecke <Hannes.Reinecke@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: BKL on reboot ?
Message-ID: <20030822135711.GN29612@dualathlon.random>
References: <3F434BD1.9050704@suse.de> <20030820112918.0f7ce4fe.akpm@osdl.org> <20030820113520.281fe8bb.davem@redhat.com> <1061411024.9371.33.camel@nighthawk> <3F447D40.5020000@suse.de> <20030821154113.GE29612@dualathlon.random> <3F44EB85.5000108@suse.de> <20030821163938.GG29612@dualathlon.random> <3F45BA87.1060902@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F45BA87.1060902@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >This can't be the lock_kernel, you see, there's no lock_kernel
> >invocation at all in the machine_restart_smp path.
> 
> Oh? sys_reboot() does call lock_kernel(). kernel/sys.c:303.

yes, I know, I meant that it's not spinning on the lock, sys_reboot gets
through lock_kernel w/o problems. It gets the lock successfully.

> Agreed, this smp_processor_id() == 0 thing is interesting. I'll try you 
> suggestion and see how far I'll progress.

thanks, that's the right fix as far as I can tell and the lock_kernel
would better stay to serialize concurrent sys_reboot.

Andrea
