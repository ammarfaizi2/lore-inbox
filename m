Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUHBVgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUHBVgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUHBVgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:36:41 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:10166 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S264054AbUHBVgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:36:10 -0400
Date: Mon, 2 Aug 2004 23:35:22 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Message-ID: <20040802213522.GB6295@dualathlon.random>
References: <20040802101905.GJ6295@dualathlon.random> <Pine.LNX.4.44.0408021506200.25305-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408021506200.25305-100000@dhcp83-102.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 03:06:48PM -0400, Rik van Riel wrote:
> Think EVMS in a certain SuSE kernel.  Hard to imagine
> no security bugs got fixed in that code ;)

we make sure they're obviously safe in security terms before applying so
that was really a bad example.

But let's assume there's a real seccomp relevant bug in a RH kernel,
it's still zerocost to bump the security sequence all over the place (in
SUSE and mainline too), just like 2.4 would need to bump the sequence
number too if we find a 2.6-only bug. So there's absolutely no problem
at all even in such a case.

The only issue I can see after the complains I heard so far, is that
it could be too complicated for the community to synchronize and agree
on the ID for every security related patch (rejects pain or inefficient
communication could make it not feasible).

But seccomp bugs are so rare and so extremely severe for the whole
userbase (not only for people using seccomp mode, think f00f or fnclex
or mmx sniffing) that this will actually work fine, just like I hope we
can successfuly agree and synchronize on the syscall numbers that also
are added rarely.

What I mean is that the seccomp_security_sequence is going to work fine
as far as the syscalls works fine, and that's the only thing I need as
far as cpushare is concerned.

But I certainly agree with Andi that we might prefer to take the CAN
way, that way it won't help only seccomp userbase, and it'll be possibly
easier to maintain since we don't need to synchronize ourself, but we'll
relay on somebody else to issue unique ID for us which makes the ID
selection a no brainer. plus it provides a bit more of information just
in case somebody forgot to fix a security bug. Though I'd expect heavy
rejects on that file if you forget to apply a security fix (which to me
was a feature but apparently somebody thinks is just lower flexibility
to get rejects if your kernel is going to be insecure).
