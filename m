Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbTGHKxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 06:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265925AbTGHKxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 06:53:45 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:13789 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S267151AbTGHKxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 06:53:43 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: 2.5.74-mm1
Date: Tue, 8 Jul 2003 13:09:30 +0200
User-Agent: KMail/1.5.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030703023714.55d13934.akpm@osdl.org> <200307080307.18018.phillips@arcor.de> <Pine.LNX.4.55.0307072314490.3597@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307072314490.3597@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307081309.30651.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 July 2003 09:48, Davide Libenzi wrote:
> On Tue, 8 Jul 2003, Daniel Phillips wrote:
> > 4. So how do you propose to "program timings" so that it's really hard to
> > miss those deadlines?
>
> Having a backup of 400-500ms gives you an average hang-over of 200-250ms
> that are hardly noticeable by a human in this topic. The issue is not if
> you always meet the deadline, the issue is what amount of load will make
> you miss it.

With realtime scheduling, you will make the deadline regardless of load (and 
there is the normal fudge when you add the word "soft").  You're arguing that 
having your sound skip, so long as it only skips under load, is good enough.  
I'm arguing that, no, that sucks too much, it should never skip.  I'll also 
argue that even on 2.4, sound skips under normal loads if your machine isn't 
very fast.

So let's fix this properly, instead of wrapping on more duct tape.

Now, I will not argue that -nice+mingo+con is a proper realtime approach, but 
I will argue that it's considerably better than just fiddling with buffer 
size and hoping for the best.

> If I have to hire five ppl clicking and dragging on my desktop
> to make my player to skip, and it skips, I don't care if it missed the
> deadline. This because my desktop will hardly see that load. But if you
> have a 50-100ms backup, things turns out to be a little bit different.
> If you pretend to run a `make -jUNREAL` and still have the audio not
> skipping it is simply wrong. Running a `make -j20` in my machine shows an
> average of 24 TASK_RUNNING tasks, that even if they're granted with a mere
> 40ms timeslice, it'll take a full second before an expired task will see
> the light again. BTW, under such load RealPlayer skips badly, but I don't
> really care since it never did while I was doing all the normal (and many
> extra) stuff I'm doing on my desktop.

I'm running make -j30 now, with the arrangement I described and sound is not 
skipping.  Convinced?

Regards,

Daniel

