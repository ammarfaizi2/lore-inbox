Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270715AbTG0KTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270711AbTG0KTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:19:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23996 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270715AbTG0KTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:19:06 -0400
Date: Sun, 27 Jul 2003 12:26:56 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Guillaume Chazarain <gfc@altern.org>
Cc: Davide Libenzi <davidel@xmailserver.org>, Mike Galbraith <efault@gmx.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-2.6.0-test1-G3, interactivity changes, audio
 latency
In-Reply-To: <VRC7KGZX0573CW1TPN65C3Y312IC.3f22a7b7@monpc>
Message-ID: <Pine.LNX.4.44.0307271151180.9853-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Jul 2003, Guillaume Chazarain wrote:

> BTW, with your nanosecond resolution, mplayer is also max interactive.

good.

> Don't you find it strange to need a nanosecond resolution to evaluate a
> simple integer in a [-5, 5] range?

no, i dont find it strange, as the -5..5 integer range is only the end
result. What we really want is an accurate sleep average, the integral of
sleep times done over the last N seconds. Given that tasks can schedule at
very high frequencies these days, this needs accurate measurements. I used
to hope that a 1 msec sampling frequency would to be enough for this, but
when we fix the statistics cornercase you mention, another cornercase pops
up. And it's not _that_ hard to use the cycle counter and still have a
reasonably fast algorithm, anyway.

	Ingo

