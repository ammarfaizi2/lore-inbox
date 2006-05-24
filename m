Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWEXWo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWEXWo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWEXWo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:44:57 -0400
Received: from www.osadl.org ([213.239.205.134]:56289 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964783AbWEXWo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:44:56 -0400
Subject: Re: [Patch 3/6] statistics infrastructure - prerequisite: timestamp
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Peschke <mp3@de.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060524150830.3864ae90.akpm@osdl.org>
References: <1148473908.2934.14.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	 <20060524150830.3864ae90.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 25 May 2006 00:45:15 +0200
Message-Id: <1148510715.5239.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 15:08 -0700, Andrew Morton wrote:
> do_div() is actually defined in terms of u64, not unsigned long long. 
> Although afaict this will all work OK and all the usual type promotions
> will dtrt.
> 
> Which begs the question: how _does_ the kernel represent nanoseconds?  The
> time-management code is a bit undecided (search for long long in
> posix-cpu-timers.c, and for u64 in hrtimers.c).  All a bit confused.

posix-cpu-timers.c needs some caring hand !

During the ktimers/hrtimers discussion we agreed on u64 resp. ktime_t to
hold the kernel internal values.

ktime_t is the preferred way as it is optimized for 32/64 bit archs and
all the conversion functions are available out of the box.

	tglx


