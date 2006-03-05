Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWCEWWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWCEWWG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWCEWWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:22:05 -0500
Received: from mail.suse.de ([195.135.220.2]:28088 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751901AbWCEWWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:22:04 -0500
Date: Sun, 5 Mar 2006 23:22:02 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060305222202.GA22450@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060305140932.GA17132@suse.de> <20060305185923.GA21519@suse.de> <Pine.LNX.4.64.0603051147590.13139@g5.osdl.org> <20060305204231.GA22002@suse.de> <17419.23860.883220.80199@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17419.23860.883220.80199@cargo.ozlabs.ibm.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Mar 06, Paul Mackeras wrote:

> Olaf Hering writes:
> 
> > I'm now at 03929c76f3e5af919fb762e9882a9c286d361e7d, which fails as
> > well. dmesg shows this:
> 
> The range from git5 to there includes David Woodhouse's syscall
> entry/exit revamp (401d1f029bebb7153ca704997772113dc36d9527) and the
> follow-ons which fix it for 32-bit:
> 
> 9687c587596b54a77f08620595f5686ea35eed97
> 623703f620453c798b6fa3eb79ad8ea27bfd302a
> 
> There are also commits from Ben H that change the way we parse
> addresses from the OF device tree.  If you can bisect a bit further
> that would be good, although you may strike problems between the 401d
> and 6237 commits I mentioned above.

I will check this tomorrow.

quick update:

d4e4b3520c4df46cf1d15a56379a6fa57e267b7d, locks up, tried two times


404849bbd2bfd62e05b36f4753f6e1af6050a824 + 3 buildfixes:

31df1678d7732b94178a6e457ed6666e4431212f
8dacaedf04467e32c50148751a96150e73323cdc
d2dd482bc17c3bc240045f80a7c4b4d5cea5e29c


This one has the syscall changes, but not the two fixes you mentioned.
It gets far, but at the point where it locks up with the d4eb, it
crashes in run_timer_softirq, branched to 0x1f4. Maybe its the result of
the missing fixes. Will continue tomorrow.
