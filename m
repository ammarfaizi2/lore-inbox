Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbSAGSBs>; Mon, 7 Jan 2002 13:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284472AbSAGSBi>; Mon, 7 Jan 2002 13:01:38 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:19656 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S284300AbSAGSB1>;
	Mon, 7 Jan 2002 13:01:27 -0500
Date: Mon, 7 Jan 2002 19:01:15 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201071801.TAA11871@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: Re: 2.5.2-pre performance degradation on an old 486
Cc: axboe@suse.de, davidel@xmailserver.org, linux-kernel@vger.kernel.org,
        mjh@vr-web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002 08:43:04 -0800 (PST), Linus Torvalds wrote:
>Hey, that would do it. It looks like the idle task ends up being a
>_normal_ process (just nice'd down), so it will get real CPU time instead
>of only getting scheduled when nothing else is runnable.
>
>Davide, I think the bounce-buffer is a red herring, it's simply that we're
>wasting time in idle..

This does seem to be the case. As a quick hack I added

	if (p == &init_task) return -50;

at the start of kernel/sched.c:goodness() [to approximate the old
scheduler's behaviour], and this immediately restored performance
on my 486 to the old scheduler's levels.

/Mikael
