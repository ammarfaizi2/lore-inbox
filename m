Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVB0Min@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVB0Min (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 07:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVB0Min
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 07:38:43 -0500
Received: from science.horizon.com ([192.35.100.1]:12619 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261381AbVB0Mik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 07:38:40 -0500
Date: 27 Feb 2005 12:38:39 -0000
Message-ID: <20050227123839.13574.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Cc: linux@horizon.com, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I followed the start of this thread when it was about security mailing
lists and bug-disclosure rules, and then lost interest.

I just looked in again, and I seem to be seeing discussion of merging
grsecurity pathes into mainline.  I haven't yet found an message
where this is proposed explicitly, so if I am inferring incorrectly,
I apologize.  (And you can ignore the rest of this missive.)

However, I did look carefully at an earlier patch that claimed to be a
Linux port of some OpenBSD networking randomization code, ostensibly to
make packet-guessing attacks more difficult.

http://marc.theaimsgroup.com/?l=linux-kernel&m=110693283511865

It was further claimed that this code came via grsecurity.  I did verify
that the code looked a lot like pieces of OpenBSD, but didn't look at
grsecurity at all.

However, I did look in some detail at the code itself.
http://marc.theaimsgroup.com/?l=linux-netdev&m=110736479712671

What I concluded was that it was broken beyond belief, and the effect
on the networking code varied from (due to putting the IP ID generation
code in the wrong place) wasting a lot of time randomizing a number that
could be a constant zero if not for working around a bug in Microsoft's
PPP stack, to (RPC XID generation) severe protocol violation.

Not to mention race conditions out the wazoo due to porting 
single-threaded code.

After careful review, I couldn't find a single redeeming feature, or
even a good idea that was merely implemented badly.  See the posting
for details and more colorful criticism.

Now, as I said, I have *not* gone to the trouble of seeing if this patch
really did come from grsecurity, or if it was horribly damaged in the
process of splitting it out.  So I may be unfairly blaming grsecurity,
but I didn't feel like seeking out more horrible code to torture my
sanity with.

My personal, judgemental opinion was that if that was typical of
grsecurity, it's a festering pile of pus that I'm not going to let
anywhere near my kernel, thank you very much.

But to the extent that this excerpt constitutes reasonable grounds for
suspicion, I would like to recommend a particularly careful review of any
grsecurity patches.  In addition to Linus' dislike of monolithic patches.

Just my $0.02.
