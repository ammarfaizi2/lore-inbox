Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbSBMPZ0>; Wed, 13 Feb 2002 10:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286590AbSBMPZR>; Wed, 13 Feb 2002 10:25:17 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:55688 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285161AbSBMPZE>;
	Wed, 13 Feb 2002 10:25:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Bill Davidsen <davidsen@tmr.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] sys_sync livelock fix
Date: Wed, 13 Feb 2002 16:29:21 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020213000859.8487A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020213000859.8487A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16b1LV-0001ol-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 06:21 am, Bill Davidsen wrote:
> On Tue, 12 Feb 2002, Andrew Morton wrote:
> 
> > IMO, the SuS definition sucks.  We really do want to do our best to
> > ensure that pending writes are committed to disk before sys_sync()
> > returns.  As long as that doesn't involve waiting until mid-August.
> 
>   The current behaviour allows the system to hang forever waiting for
> sync(2). In practice it does actually wait minutes on a busy system (df
> has --no-sync for that reason) when there is no reason for that to happen.
> I think that not only sucks worse, it's non-standard as well.

Nothing sucks worse than losing your data.  Let's concentrate on fixing
shutdown, not breaking (linux) sync.

> > For example, ext3 users get to enjoy rebooting with `sync ; reboot -f'
> > to get around all those silly shutdown scripts.  This very much relies
> > upon the sync waiting upon the I/O.
> 
>   Because people count on something broken we should keep the bug? You do
> realize that the sync may NEVER finish?

You do realize that if you lose your data you may NEVER get it back? ;-)

> That's not in theory, I have news
> servers which may wait overnight without finishing a "df" iwthout the
> option.

OK, what you're really saying is, we need a way to kill the sync process
if it runs overtime, no?
 
> > I mean, according to SUS, our sys_sync() implementation could be
> > 
> > asmlinkage void sys_sync(void)
> > {
> > 	return;
> > }
> > 
> > Because all I/O is already scheduled, thanks to kupdate.
> 
>   I think the wording is queued, and I would read that as "on the
> elevator."

Well now you're adding your own semantics to SuS, welcome to the party.
I vote we keep the existing and-don't-come-back-until-you're-done Linux
semantics.

> Your example is a good example of bad practive, since even with
> ext3 a program creating files quickly would lose data, even though the
> directory structure is returned to a known state, without stopping the
> writing processes the results are unknown.

Huh?  You know about journal commit, right?

-- 
Daniel
