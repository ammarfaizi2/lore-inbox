Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTHVQxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263716AbTHVQxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:53:30 -0400
Received: from ns.suse.de ([195.135.220.2]:53724 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263668AbTHVQxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:53:18 -0400
Date: Fri, 22 Aug 2003 18:25:29 +0200
From: Andi Kleen <ak@suse.de>
To: davej@redhat.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       paul.devriendt@amd.com
Subject: Re: Cpufreq for opteron
Message-ID: <20030822162529.GA12774@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


--oyUTqETQ0mS9luUI
Content-Type: message/rfc822
Content-Description: Undelivered Message
Content-Disposition: inline

Received: from oldwotan.suse.de (Oldwotan.suse.de [10.10.0.184])
	by Hermes.suse.de (Postfix) with ESMTP
	id 5B88441D7; Fri, 22 Aug 2003 17:59:23 +0200 (CEST)
Received: from oldwotan.suse.de (localhost [127.0.0.1])
	by oldwotan.suse.de (Postfix) with ESMTP
	id 4BB3D23540F7; Fri, 22 Aug 2003 17:59:22 +0200 (CEST)
Received: (from ak@localhost)
	by oldwotan.suse.de (8.12.6/8.12.6/Submit) id h7MFxL51023150;
	Fri, 22 Aug 2003 17:59:21 +0200
X-Authentication-Warning: oldwotan.suse.de: ak set sender to ak@suse.de using -f
Sender: ak@suse.de
To: Dave Jones <davej@redhat.com>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org,
	paul.devriendt@amd.com
Subject: Re: Cpufreq for opteron
References: <20030822135946.GA2194@elf.ucw.cz.suse.lists.linux.kernel>
	<20030822144340.GE3111@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Aug 2003 17:59:19 +0200
In-Reply-To: <20030822144340.GE3111@redhat.com.suse.lists.linux.kernel>
Message-ID: <p73ekzd65uw.fsf@oldwotan.suse.de>
Lines: 39
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Dave Jones <davej@redhat.com> writes:

> This is likely to be lots of 'fun'. The multiple stage state machine
> that the opteron powernow uses could be preempted at any stage.
> Might not be that big a deal for UP (except for any timing specific
> routines, that need explicit disable/enable around them). But for SMP,
> where you could wind up on a different CPU when you return to kernel
> space, 'bad shit' will happen. Good luck!

You just have to set the scheduler affinity mask of the current process
to a single CPU while executing this - or run it in a workqueue
which is already bound.

But it doesn't matter right now because the driver doesn't support SMP.

>  > +static int onbattery = 1;	/* Set if running on battery, reset otherwise. */
>  > +			   /* Of no relevance unless batterypstates <     */
>  > +			   /* numpstates, as defined in the PSB/PST.      */
> 
> Where is this set ? My guess is you're going to need ACPI hooks
> to do this, in which case it shouldn't be static.

See the comment. For the current code/machines it does not make any difference.

It may be for future chips, but that will need an updated driver anyways.

>  > +	/* WARNING - the cpufreq calls end up doing nothing in a SMP kernel.       */
>  > +	/* This code will not work too well in such a kernel. This module protects */
>  > +	/* itself from being compiled ifdef CONFIG_SMP.                            */
> 
> Again, why ? Have you actually tried this ?
> If you have any ideas whats wrong here, we'd like to get this fixed up.

SMP cpufreq will need a lot more work.

Also current Opterons don't support advanced power saving in SMP systems
(neither does Intel btw)

-Andi

--oyUTqETQ0mS9luUI--
