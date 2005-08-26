Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbVHZAVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVHZAVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 20:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVHZAVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 20:21:17 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:1931
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S965032AbVHZAVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 20:21:16 -0400
Subject: Re: 2.6.13-rc7-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1125012596.14592.12.camel@dhcp153.mvista.com>
References: <20050825062651.GA26781@elte.hu>
	 <1125012596.14592.12.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 26 Aug 2005 02:22:04 +0200
Message-Id: <1125015724.20120.143.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 16:29 -0700, Daniel Walker wrote:
> Devastating latency on a 3Ghz xeon .. Maybe the raw_spinlock in the
> timer base is creating a unbounded latency?

The lock is only held for really short periods. The only possible long
period would be migration of timers from a dead hotplug cpu to another.
I guess thats not the case.

Do you have HIGH_RES_TIMERS enabled ?

> ( softirq-timer/1-13   |#1): new 66088 us maximum-latency critical section.
>  => started at timestamp 1857957769: <__down_mutex+0x5f/0x295>
>  =>   ended at timestamp 1858023857: <_raw_spin_unlock_irq+0x16/0x39>

which mutex was taken and which raw spinlock released  ?

__down_mutex / _raw_spin_unlock_irq is an asymetric pair. Those sections
should be symetric.

I have the feeling that the call trace is not complete.

> <ffffffff8047732a>{rt_secret_rebuild+0}

hint: rt_secret_rebuild() is a well known long running timer callback
function. 

tglx


