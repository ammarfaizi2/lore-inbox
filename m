Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270652AbTHJUZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270659AbTHJUZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:25:58 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:8154 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S270652AbTHJUZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:25:56 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Mike Galbraith <efault@gmx.de>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy    ...
Date: Sun, 10 Aug 2003 21:28:49 +0100
User-Agent: KMail/1.5.3
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5.2.1.1.2.20030810080748.019cb090@pop.gmx.net> <5.2.1.1.2.20030810182157.019c66c0@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030810182157.019c66c0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308102128.49817.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 August 2003 18:49, Mike Galbraith wrote:
> It doesn't appear to accomplish anything other than bypassing 'you must be
> this tall (godly stature) to use this API'.

But it is a big deal.  It means Linux can have superior audio performance 
out-of-the-box, without having to run sound apps suid.  From what I've seen,  
you do not want to let a typical sound app have free reign over your machine.  
Not that they're malicious, but they do seem to be breeding grounds for 
buffer overflows, races, dangling pointers, etc.

> No matter what limit you put on the cpu usage, that amount can (xlat:
> probably will) be abused.

How?  Anybody user can run an empty loop right now and it will have 
approximately the same effect, i.e., it will use some cpu, big deal.  The 
other danger is that the latency of certain kernel threads could be 
increased, e.g., kswapd, ksoftirqd, keventd.  Here, a malicious softrr 
application could only cause increased latency during the realtime slice, so 
there's a cap on that.  And anyway, why aren't those kernel threads running 
with realtime priority in the first place?

While we're in here: what should be the maximum realtime priority granted to a 
normal user?  It should probably be another adminstrator knob.

> On my little box, I'd have to relinquish control of over 50% of my cpu at
> _minimum_ to some random application developer.  (not)

It's your decision[tm].  At least you know that slowing down your kernel 
compile is about the worst fallout you can expect from being wanton and 
promiscuous with your chmod +x's.  More precisely, if you do get rooted, it 
will have nothing to do with softrr ;-)

The idea is, if the administrator decides not to let them have realtime 
priority, sound apps will just have to do the best they can, with large 
buffers etc, as they have been forced to until now.

> ...I'm sure it'll work.  What I tested briefly worked fine.  However, I'm
> not sure that it's a good (or bad) idea.

Well, perhaps it's time to get a word from a couple guys out there in the 
trenches.  Takashi, Conrad, any thoughts on the relative importance of this?  
(Technical details are earlier in this thread.)

