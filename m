Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271294AbTGQA1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 20:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271295AbTGQA1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 20:27:37 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:3731 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S271294AbTGQA1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 20:27:34 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 16 Jul 2003 17:35:07 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Con Kolivas <kernel@kolivas.org>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O6int for interactivity
In-Reply-To: <1058402012.3f15eedcc06f2@kolivas.org>
Message-ID: <Pine.LNX.4.55.0307161732270.4787@bigblue.dev.mcafeelabs.com>
References: <200307170030.25934.kernel@kolivas.org>
 <Pine.LNX.4.55.0307161241280.4787@bigblue.dev.mcafeelabs.com>
 <1058402012.3f15eedcc06f2@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003, Con Kolivas wrote:

> > > +			p->sleep_avg = (p->sleep_avg * MAX_BONUS / runtime + 1)
> * runtime /
> > MAX_BONUS;
> >
> > I don't have the full code so I cannot see what "runtime" is, but if
> > "runtime" is the time the task ran, this is :
> >
> > p->sleep_avg ~= p->sleep_avg + runtime / MAX_BONUS;
> >
> > (in any case a non-decreasing function of "runtime" )
> > Are you sure you want to reward tasks that actually ran more ?
>
>
> That was the bug. Runtime was supposed to be limited to MAX_SLEEP_AVG. Fix will
> be posted very soon.

Con, it is not the limit. You're making sleep_avg a non-decreasing
function of "runtime". Basically you are rewarding tasks that did burn
more CPU (if runtime is what the name suggests). Are you sure this is what
you want ?


> > Con, you cannot follow the XMMS thingy otherwise you'll end up bolting in
> > the XMMS sleep->burn pattern and you'll probably break the make-j+RealPlay
> > for example. MultiMedia players are really tricky since they require strict
> > timings and forces you to create a special super-interactive treatment
> > inside the code. Interactivity in my box running moderate high loads is
> > very good for my desktop use. Maybe audio will skip here (didn't try) but
> > I believe that following the fix-XMMS thingy is really bad. I believe we
> > should try to make the desktop to feel interactive with human tollerances
> > and not with strict timings like MM apps. If the audio skips when dragging
> > like crazy a X window using the filled mode on a slow CPU, we shouldn't be
> > much worried about it for example. If audio skip when hitting the refresh
> > button of Mozilla, then yes it should be fixed. And the more you add super
> > interactive patterns, the more the scheduler will be exploitable. I
> > recommend you after doing changes to get this :
> >
> > http://www.xmailserver.org/linux-patches/irman2.c
> >
> > and run it with different -n (number of tasks) and -b (CPU burn ms time).
> > At the same time try to build a kernel for example. Then you will realize
> > that interactivity is not the bigger problem that the scheduler has right
> > now.
>
> Please don't assume I'm writing an xmms scheduler. I've done a lot more testing
> than xmms.

Ok, I'm feeling better already ;)



- Davide

