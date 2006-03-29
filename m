Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWC2DBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWC2DBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 22:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWC2DBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 22:01:20 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:5336 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750811AbWC2DBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 22:01:20 -0500
Subject: Re: interactive task starvation
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Willy Tarreau <willy@w.ods.org>, Con Kolivas <kernel@kolivas.org>,
       Mike Galbraith <efault@gmx.de>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, bugsplatter@gmail.com
In-Reply-To: <20060321145202.GA3268@elte.hu>
References: <1142592375.7895.43.camel@homer>
	 <200603220119.50331.kernel@kolivas.org> <1142951339.7807.99.camel@homer>
	 <200603220130.34424.kernel@kolivas.org> <20060321143240.GA310@elte.hu>
	 <20060321144410.GE26171@w.ods.org>  <20060321145202.GA3268@elte.hu>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 22:01:17 -0500
Message-Id: <1143601277.3330.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 15:52 +0100, Ingo Molnar wrote:
> * Willy Tarreau <willy@w.ods.org> wrote:
> 
> > Ah no, I never use those montruous environments ! xterm is already 
> > heavy. [...]
> 
> [ offtopic note: gnome-terminal developers claim some massive speedups
>   in Gnome 2.14, and my experiments on Fedora rawhide seem to 
>   corraborate that - gnome-term is now faster (for me) than xterm. ]
> 
> > [...] don't you remember, we found that doing "ls" in an xterm was 
> > waking the xterm process for every single line, which in turn woke the 
> > X server for a one-line scroll, while adding the "|cat" acted like a 
> > buffer with batched scrolls. Newer xterms have been improved to 
> > trigger jump scroll earlier and don't exhibit this behaviour even on 
> > non-patched kernels. However, sshd still shows the same problem IMHO.
> 
> yeah. The "|cat" changes the workload, which gets rated by the scheduler 
> differently. Such artifacts are inevitable once interactivity heuristics 
> are strong enough to significantly distort the equal sharing of CPU 
> time.

Can you explain why terminal output ping-pongs back and forth between
taking a certain amount of time, and approximately 10x longer?  For
example here's the result of "time dmesg" 6 times in an xterm with a
constant background workload:

real    0m0.086s
user    0m0.005s
sys     0m0.012s

real    0m0.078s
user    0m0.008s
sys     0m0.009s

real    0m0.082s
user    0m0.004s
sys     0m0.013s

real    0m0.084s
user    0m0.005s
sys     0m0.011s

real    0m0.751s
user    0m0.006s
sys     0m0.017s

real    0m0.749s
user    0m0.005s
sys     0m0.017s

Why does it ping-pong between taking ~0.08s and ~0.75s like that?  The
behavior is completely reproducible.

Lee

