Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbTFCPvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265064AbTFCPvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:51:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20746 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265063AbTFCPvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:51:36 -0400
Date: Tue, 3 Jun 2003 09:04:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] new sys_tkill2() system call, 2.5.70
In-Reply-To: <Pine.LNX.4.44.0306031100170.5663-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306030856190.2855-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Jun 2003, Ingo Molnar wrote:
> 
> the attached patch, against 2.5.70, adds a new system-call called
> sys_tkill2():

I'd suggest changing the name. It's not "tkill2", it's a totally new 
system call with different inputs.

How about calling it "tgkill()" for "thread" and "group", which are the 
new inputs?

It would also seem a lot cleaner that the "any" value be "-1" (like it is
for the other kill functions), and it works for both tgid _and_ for pid,
so that

	tgkill(-1, pid, sig) == tkill(pid, sig) == kill thread
	tgkill(pid, -1, sig) == kill(pid, sig) == kill group

You made the "any" value be 0, and working only for the group. At least to
me, "0" historically means "this process group", while "-1" means "any"
for the signals.

("0" for "this thread group" might make sense, but if I read the patch 
correctly, you really have "0 == _any_ thread group").

Hmm?

		Linus

