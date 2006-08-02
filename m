Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWHBVTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWHBVTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWHBVTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:19:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932166AbWHBVTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:19:30 -0400
Date: Wed, 2 Aug 2006 14:18:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Dave Jones <davej@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: Linux v2.6.18-rc3
In-Reply-To: <20060802205824.GA17599@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0608021416200.4168@g5.osdl.org>
References: <20060731081112.05427677.akpm@osdl.org> <20060801215919.8596da9d.akpm@osdl.org>
 <4807377b0608021257p27882866i69a5a0a4a1f05dda@mail.gmail.com>
 <200608022216.54797.rjw@sisk.pl> <20060802202309.GD7173@flint.arm.linux.org.uk>
 <20060802203236.GC23389@redhat.com> <20060802205824.GA17599@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Aug 2006, Russell King wrote:
> 
> Rafael has reported that it fixes his problem, which is great - and is
> the first bit of feedback I've received on it (thanks Rafael.)
> 
> I've no idea why it doesn't work for you though.

Well, more importantly, why would we do something like this in the first 
place?

Wouldn't it be a _lot_ better to just use the bog-standard 
"suspend/resume" callbacks, and let serial drivers just suspend/resume on 
their own, instead of having upper layers generate these fake 
"set_termios()" calls?

The serial layer should use set_termios() when users set the termios state 
(surprise surprise), not to emulate suspend/restore. 

Real hardware tends to want to do a lot more _anyway_ for suspend/restore, 
so the argument that "set_termios()" already exists as an interface is 
pretty bogus.

			Linus
