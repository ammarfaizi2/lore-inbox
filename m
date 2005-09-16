Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161153AbVIPKJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbVIPKJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 06:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbVIPKJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 06:09:28 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:50310 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1161153AbVIPKJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 06:09:28 -0400
Date: Fri, 16 Sep 2005 12:09:19 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: early printk timings way off
In-Reply-To: <9a87484905091515072c7dd4a8@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0509161202450.19735@gockel.physik3.uni-rostock.de>
References: <200509152342.24922.jesper.juhl@gmail.com> 
 <Pine.LNX.4.58.0509151458330.1800@shark.he.net> <9a87484905091515072c7dd4a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005, Jesper Juhl wrote:

> On 9/15/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Thu, 15 Sep 2005, Jesper Juhl wrote:
> >
> > > Early during boot the printk timings are way off :
> > >
[...]
> > > [4294667.296000] Initializing CPU#0
> > > [4294667.296000] CPU 0 irqstacks, hard=c03d2000 soft=c03d1000
> > > [4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
> > >
> > > ^^^^^ These I can buy as the result of an uninitialized variable. Why are
> > >       we not initializing this counter to zero?
> > >
> > > [    0.000000] Detected 1400.279 MHz processor.
> > >
> > > ^^^^^ Ok, we finally seem to have initialized the counter...
> > >
> > > [   27.121583] Using tsc for high-res timesource
> > >
> > > ^^^^^ 27 seconds??? Something is off here. It certainly doesn't take 27 sec
> > >       to get from the previous message to this one during the actual boot.
> > >       What's up with that?
> > >
> > > [   27.121620] Console: colour dummy device 80x25
> > > [   27.122909] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> > > ...
> > >
> > > No big deal, but it sure would look better (and be actually useful for the
> > > first few messages) if things started out at zero and then actually
> > > increased sanely from the very beginning.  :-)
> >
> > For purposes of testing rollover and/or finding broken drivers etc.,
> > jiffies is init to something like -5 seconds (or max_jiffies - 5)
> > and then it rolls over soon.

Yep, 4294667.296 = 2^32/1000-300 is exactly the value jiffies gets
initialized to on i386. Supposedly subtraction of INITIAL_JIFFIES is
missing here.

> I'm aware of that fact, but I thought the printk timings were supposed
> to be releative to the kernel starting - surely the known initial
> value of jiffies could be accounted/corrected for when printing the
> timing values.  Also, that still doesn't explain why the first many
> lines seem to be just printing some fixed value (my guess is an
> uninitialized var, but I haven't actually looked). It also doesn't
> explain why two lines, the first with timing value 0.000, and the next
> with 27.121 don't seem to match reality - the *actual* delta between
> printing those two lines is far lower than 27 seconds.

Yes, this seems to be different, possibly unrelated problem.
It's interesting that the value jumps _exactly_to_zero_, though.
Will need to dig into the code...

Tim
