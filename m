Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTESSmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTESSmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:42:00 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:8653 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262627AbTESSl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:41:58 -0400
Date: Mon, 19 May 2003 11:57:09 -0700
From: Andrew Morton <akpm@digeo.com>
To: davidm@hpl.hp.com
Cc: arjanv@redhat.com, davem@redhat.com, ak@muc.de, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: time interpolation hooks
Message-Id: <20030519115709.0701a1c3.akpm@digeo.com>
In-Reply-To: <16073.9205.641605.741130@napali.hpl.hp.com>
References: <20030516142311.3844ee97.akpm@digeo.com>
	<16069.24454.349874.198470@napali.hpl.hp.com>
	<1053139080.7308.6.camel@rth.ninka.net>
	<16073.5555.158600.61609@napali.hpl.hp.com>
	<20030519174203.A7061@devserv.devel.redhat.com>
	<16073.9205.641605.741130@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 May 2003 18:54:51.0705 (UTC) FILETIME=[20FE6290:01C31E38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> Andrew, I assume it's OK with you if I update the ia64 code to the
>  proposed interface and then send you an updated patch?

Sure.  It's be good to see an ia32 implementation which can be beaten on. 
Maybe John can look into that?

>From an implementation point of view, I wonder if all platforms will need
the indirection?

If not then it would be better to just do

	update_wall_time_hook(sys_tz.tz_minuteswest * 60 * NSEC_PER_SEC);

in kernel/time.c and let the architecture decide whether it wants to add
the extra overwriteable hooks.

So include/asm/time-interpolation.h has:

	#include <asm-generic/time-interpolation.h>

and asm-generic/time-interpolation.h has:

	struct time_interpolator {
		...
	}

	static inline void update_wall_time_hook(unsigne long nsec)
	{
		time_interpolator.update_wall_time(nsec);
	}

if you get my drift.


