Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWIOQif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWIOQif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWIOQif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:38:35 -0400
Received: from www.osadl.org ([213.239.205.134]:9954 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751687AbWIOQie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:38:34 -0400
Subject: Re: [PATCH] Migration of standard timers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Andi Kleen <ak@suse.de>
In-Reply-To: <20060914132917.GA9898@sgi.com>
References: <20060914132917.GA9898@sgi.com>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 18:39:19 +0200
Message-Id: <1158338360.5724.442.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 08:29 -0500, Dimitri Sivanich wrote:
> This patch allows the user to migrate currently queued
> standard timers from one cpu to another, thereby reducing
> timer induced latency on the chosen cpu.  Timers that
> were placed with add_timer_on() are considered to have 
> 'cpu affinity' and are not moved.
> 
> The changes in drivers/base/cpu.c provide a clean and
> convenient interface for triggering the migration through
> sysfs, via writing the destination cpu number to a file
> associated with the source cpu.
> 
> Note that migrating timers will not, by itself, keep new
> timers off of the chosen cpu.  But with careful control of
> thread affinity, one can control the affinity of new timers
> and keep timer induced latencies off of the chosen cpu.
> 
> This particular patch does not affect the hrtimers.  That
> could be addressed later.

Are you trying to work around the latencies caused by long running timer
callbacks ? I'm not convinced that this is not curing the symptoms
instead of the root cause.

	tglx


