Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbSJMVv4>; Sun, 13 Oct 2002 17:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSJMVv4>; Sun, 13 Oct 2002 17:51:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7543 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261683AbSJMVvz>; Sun, 13 Oct 2002 17:51:55 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend device
References: <200210132044.NAA02608@baldur.yggdrasil.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 15:56:27 -0600
In-Reply-To: <200210132044.NAA02608@baldur.yggdrasil.com>
Message-ID: <m1adlim29g.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> Eric Blade wrote:
> >On Sun, 2002-10-13 at 15:24, Adam J. Richter wrote:
> >>        [...] I think the new behavior in IDE
> >> of spinning down the hard drives on suspend is correct.  The problem
> >> is that the warm reboot system call is trying to suspend all of the
> >> devices before a warm reboot for no reason.  [...]
> 
> >Adam,
> >  I'm not sure the proper thing to do is necessarily remove the
> >device_shutdown() call.
> 
> 	If, by this, you are saying that you have in mind some reason
> why this should not be done, then please explain.

We need it.  It doesn't make sense for every device driver
to register a reboot notifier.  When especially as they
have to run the same code when they are modular and are
removed.

Why would you not want to do that?

> >  Please try this patch [...]
> 
> 	Your patch does not apply and I don't see how renaming
> a constant in essentially every place that it is referenced would
> change the behavior of the code in a way releveant to the problem
> that I described.
> 
> 	I don't see a problem with device_shutdown spinning down the
> IDE hard disks.  What I have a problem with, and what my patch fixes,
> is the relatively new behavior of the warm reboot system call calling
> device_shutdown.  Why was this added?

Because most device drivers don't implement a reboot notifier?
And they almost certainly need it.

>   The reboot notifier chain is
> already called for devices that need some preparation before it is
> safe to reboot or halt.

Error please try again.  It is just they don't cause major problems
on reboot so no one notices the problems.

Eric
