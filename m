Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUG2XC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUG2XC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUG2W7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:59:11 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:44804 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267490AbUG2W5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:57:34 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: ncunningham@linuxmail.org
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091061983.8867.95.camel@laptop.cunninghams>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040728142026.79860177.akpm@osdl.org>
	 <1091053822.1844.4.camel@teapot.felipe-alfaro.com>
	 <1091054194.8867.26.camel@laptop.cunninghams>
	 <1091056916.1844.14.camel@teapot.felipe-alfaro.com>
	 <1091061983.8867.95.camel@laptop.cunninghams>
Content-Type: text/plain
Date: Fri, 30 Jul 2004 00:57:12 +0200
Message-Id: <1091141832.2114.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 10:46 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2004-07-29 at 09:21, Felipe Alfaro Solana wrote:
> > kirdad? No... That sounds like Infrared which my laptop does not have.
> 
> Did to me too. I was clutching at straws. :>
> 
> > Here is a digest of ps -axf:
> > 
> >   PID TTY      STAT   TIME COMMAND
> >     1 ?        S      0:00 init [5]
> >     2 ?        S<     0:03 [irqd/0]
> >     3 ?        S<     0:00 [events/0]
> >     4 ?        S<     0:00  \_ [khelper]
> >     5 ?        S<     0:00  \_ [kacpid]
> >    22 ?        S<     0:00  \_ [kblockd/0]
> >    32 ?        S      0:00  \_ [pdflush]
> >    33 ?        S      0:00  \_ [pdflush]
> >    35 ?        S<     0:00  \_ [aio/0]
> >    36 ?        S<     0:00  \_ [xfslogd/0]
> >    37 ?        S<     0:00  \_ [xfsdatad/0]
> >    34 ?        S      0:00 [kswapd0]
> >    38 ?        S      0:00 [xfsbufd]
> >   120 ?        S      0:00 [kseriod]
> >   125 ?        S      0:00 [xfssyncd]
> >   273 ?        Ss     0:00 minilogd
> >   286 ?        S      0:00 [xfssyncd]
> >   287 ?        S      0:00 [xfssyncd]
> >   567 ?        S      0:00 [khubd]
> >   871 ?        S      0:00 [pccardd]
> >   877 ?        S      0:00 [pccardd]
> 
> It doesn't look like I've touched any of those threads. I have doubts
> about irqd/0 (is that kirqd reworked?), so you might try making setting
> PF_NOFREEZE and seeing if it makes a difference. I haven't done the
> switch to rc2-mm1 yet, so haven't gotten to those issues.

Well, I've tried the kthread freezer patch against 2.6.8-rc2-mm1 and it
works fine. However, with kthread freezer applied, suspending and
resuming is much slower (around 5 seconds slower). Thus, I guess all my
problems must be related to some specific patch I'm applying against the
current -bk tree.

I'll keep investigating this issue, but I think voluntary-preempt might
have some strange interactions with these kthread changes.

