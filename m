Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbTFCQWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbTFCQWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:22:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57613 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265085AbTFCQWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:22:30 -0400
Date: Tue, 3 Jun 2003 09:35:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] new sys_tkill2() system call, 2.5.70
In-Reply-To: <Pine.LNX.4.44.0306031807001.22509-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306030933240.3714-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Jun 2003, Ingo Molnar wrote:
> 
> are you suggesting to extend sys_tgkill() functionality to also detect -1
> for the PID, and do a process-signal send?

I don't care much, but that zero special case is definitely not a good 
idea.

You might make the thing acceptable to me by just removing the "zero means 
everythign", and replacing that logic with

	if (!tgid)
		tgid = current->tgid;

which is similar to how we handle zeroes in some other places. In other 
words, a zero is not a "wildcard", it means "_this_ thread group".

		Linus

