Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272579AbTHJJBP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272589AbTHJJBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:01:14 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:29930
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272579AbTHJJBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:01:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Simon Kirby <sim@netnation.com>
Subject: Re: [PATCH]O14int
Date: Sun, 10 Aug 2003 19:06:34 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20030808220821.61cb7174.lista1@telia.com> <200308091036.18208.kernel@kolivas.org> <20030810084827.GA30869@netnation.com>
In-Reply-To: <20030810084827.GA30869@netnation.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308101906.34807.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003 18:48, Simon Kirby wrote:
> On Sat, Aug 09, 2003 at 10:36:17AM +1000, Con Kolivas wrote:
> > On Sat, 9 Aug 2003 06:08, Voluspa wrote:
> > > On 2003-08-08 15:49:25 Con Kolivas wrote:
> > > > More duck tape interactivity tweaks
> > >
> > > Do you have a premonition... Game-test goes down in flames. Volatile to
> > > the extent where I can't catch head or tail. It can behave like in
> > > A3-O12.2 or as an unpatched 2.6.0-test2. Trigger badness by switching
> > > to a text console.
> >
> > Ah. There's the answer. You've totally changed the behaviour of the
> > application in question by moving to the text console. No longer is it
> > the sizable cpu hog that it is when it's in the foreground on X, so
> > you've totally changed it's behaviour and how it is treated.
>
> I haven't been following this as closely as I would have liked to
> (recent vacation and all), but I am definitely seeing issues with the
> recent 2.5.x, 2.6.x-testx secheduler code and have been looking over
> these threads.
>
> I don't really understand why these changes were made at all to the
> scheduler.  As I understand it, the 2.2.x and older 2.4.x scheduler was
> simple in that it allowed any process to wake up if it had available
> ticks, and would switch to that process if any new event occurred and
> woke it up.  The rest was just limiting the ticks based on nice value
> and remembering to switch when the ticks run out.
>
> It seems that newer schedulers are now temporarily postponing the
> waking up of other processes when the running process is running with
> "preemptive" ticks, and that there's all sorts of hacks involved in
> trying to hide the bad effects of this decision.
>
> If this is indeed what is going on, what is the reasoning behind it?
> I didn't really see any problems before with the simple scheduler, so
> it seems to me like this may just be a hack to make poorly-written
> applications seem to be a bit "faster" by starving other processes of
> CPU when the poorly-written applications decide they want to do
> something (such as rendering a page with a large table in Mozilla
> -- grr).  Is this really making a large enough difference to be worth
> all of this trouble?
>
> To me it would seem the best algorithm would be what we had before all
> of this started.  Isn't it best to switch to a task as soon as an event
> (such as disk I/O finishing or a mouse move waking up X to read mouse
> input) occurs for both latency and cache reasons (queued in LIFO
> order)?  DMA may make some this more complicated, I don't know.
>
> I am seeing similar starvation problems that others are seeing in these
> threads.  At first it was whenever I clicked a link in Mozilla -- xmms
> would stop, sometimes for a second or so, on a Celeron 466 MHz machine.
> More recently I found that loading a web page consisting of several
> large animated gif images (a security camera web page) caused
> absolutely horrible jerking of mouse and keyboard input in all other
> windows, even when the browser window was minimized or hidden.  What's
> worse is the jerking tends to subside if I do a lot of typing or more
> the mouse a lot, probably because I'm changing the scheduler's idea of
> what "kind" of processes are running (which makes this stuff even
> harder to debug).

Is this with or without my changes? The old scheduler was not very scalable; 
that's why we moved. The new one has other intrinsic issues that I (and 
others) have been trying to address, but is much much more scalable. It was 
not possible to make the old one more scalable, but it is possible to make 
this one more interactive.

Con

