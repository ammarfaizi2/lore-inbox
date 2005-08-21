Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVHUVfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVHUVfh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVHUVfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:35:37 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:41676 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751137AbVHUVfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:35:36 -0400
Date: Sun, 21 Aug 2005 11:01:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
Message-Id: <20050821110127.3b601268.akpm@osdl.org>
In-Reply-To: <4308649D.7060008@yahoo.com.au>
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com>
	<20050821021322.3986dd4a.akpm@osdl.org>
	<20050821021616.6bbf2a14.akpm@osdl.org>
	<430848F5.3040308@yahoo.com.au>
	<20050821023249.0e143030.akpm@osdl.org>
	<4308649D.7060008@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> 
> > 
> > yup.
> > 
> > 
> >>Why not use something like do_gettimeofday? (or I'm sure one
> >>of our time keepers can suggest the right thing to use).
> > 
> > 
> > do_gettimeofday() takes locks, so a) we can't do printk from inside it and
> 
> Dang, yeah maybe this is the showstopper.
> 
> > b) if you do a printk-from-interupt and the interrupted code was running
> > do_gettimeofday(), deadlock.
> > 
> 
> What about just using jiffies, then?
> 
> Really, sched_clock() is very broken for this (I know you're
> not arguing against that).
>
> It can go backwards when called twice from the same CPU, and the
> number returned by one CPU need have no correlation with that
> returned by another.

jiffies wouldn't have sufficient resolution for this application.  Bear in
mind that this is just a debugging thing - it's better to have good
resolution with occasional theoretical weirdness than to have poor
resolution plus super-consistency, IMO.

> However, I understand you probably just want something quick and
> dirty for 2.6.13 and would be happy just if it isn't more broken
> than before ;)

We're OK for 2.6.13, I think.  ia64 people will quickly learn to not turn
the option on.
