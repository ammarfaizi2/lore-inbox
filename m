Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUHJISx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUHJISx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUHJISl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:18:41 -0400
Received: from holomorphy.com ([207.189.100.168]:53990 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262006AbUHJISC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:18:02 -0400
Date: Tue, 10 Aug 2004 01:17:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810081752.GG11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@engr.sgi.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com> <20040809211042.GY11200@holomorphy.com> <20040809224546.GZ11200@holomorphy.com> <20040810063445.GE11200@holomorphy.com> <20040810080430.GA25866@elte.hu> <20040810080801.GA26014@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810080801.GA26014@elte.hu>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, someone wrote:
>> is keventd_up() true during normal SMP bootup? [...]

On Tue, Aug 10, 2004 at 10:08:01AM +0200, Ingo Molnar wrote:
> it ought to be up at this point - smp_init() is done from the init
> thread and the scheduler is up and running.
> 	Ingo

Well, I'm working backward from an "unacceptable fix", where I changed
a bunch of things defensively at once and (of course) it was adding the
printk()'s that actually fixed things.

One of those changes was to ditch the schedule_work() shenanigans in
do_boot_cpu(), which was actually meant to rule out the initializers
for the struct create_idle getting miscompiled or otherwise not
behaving as I expected.


-- wli
