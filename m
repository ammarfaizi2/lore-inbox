Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbTBIDcC>; Sat, 8 Feb 2003 22:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbTBIDcC>; Sat, 8 Feb 2003 22:32:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33541 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267157AbTBIDcB>; Sat, 8 Feb 2003 22:32:01 -0500
Date: Sat, 8 Feb 2003 19:37:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <200302090333.h193Xnn04935@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302081933380.7675-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Feb 2003, Roland McGrath wrote:
>
> Ah.  Deciding state should be treated as a bitmask is not so hot when
> TASK_RUNNING is 0.

Oops. Indeed. TASK_RUNNING isn't a bit at all, it's a lack of sleep.

Turning the logic the other way around:

	/* Ignore processes that are dead or stopped (except for SIGKILL) */
	mask = TASK_ZOMBIE | TASK_DEAD;
	if (sig != SIGKILL)
		mask != TASK_STOPPED;

and testing for !((p)->state & mask) should fix it. The mask ends up being 
the states that are _not_ good to send signals for ;)

		Linus

