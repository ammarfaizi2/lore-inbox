Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbTGHHlk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 03:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbTGHHlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 03:41:40 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:18306 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266896AbTGHHlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 03:41:37 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 8 Jul 2003 00:48:36 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Daniel Phillips <phillips@arcor.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <200307080307.18018.phillips@arcor.de>
Message-ID: <Pine.LNX.4.55.0307072314490.3597@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <200307080213.53203.phillips@arcor.de>
 <Pine.LNX.4.55.0307071724540.3524@bigblue.dev.mcafeelabs.com>
 <200307080307.18018.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Daniel Phillips wrote:

> 1. 400ms buffers are hated by users, as was noted previously.  They are
> passable for some applications, but way too laggy for others.
>
> 2. Even if you are will to have a 400-500 ms buffer, if you can prove that you
> will always meet that deadline, then it's a realtime system.
>
> 3. If you can show logically that you will nearly always meet the deadline,
> it's a soft realtime system.  That's what we're after here.  From a design
> standpoint, there are elegant soft realtime systems, and there are sucky
> ones.
>
> 4. So how do you propose to "program timings" so that it's really hard to miss
> those deadlines?

Having a backup of 400-500ms gives you an average hang-over of 200-250ms
that are hardly noticeable by a human in this topic. The issue is not if
you always meet the deadline, the issue is what amount of load will make
you miss it. If I have to hire five ppl clicking and dragging on my desktop
to make my player to skip, and it skips, I don't care if it missed the
deadline. This because my desktop will hardly see that load. But if you
have a 50-100ms backup, things turns out to be a little bit different.
If you pretend to run a `make -jUNREAL` and still have the audio not
skipping it is simply wrong. Running a `make -j20` in my machine shows an
average of 24 TASK_RUNNING tasks, that even if they're granted with a mere
40ms timeslice, it'll take a full second before an expired task will see
the light again. BTW, under such load RealPlayer skips badly, but I don't
really care since it never did while I was doing all the normal (and many
extra) stuff I'm doing on my desktop.




- Davide

