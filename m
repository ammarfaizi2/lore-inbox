Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbUKSVsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbUKSVsU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbUKSVsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:48:20 -0500
Received: from gw.goop.org ([64.81.55.164]:29585 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261598AbUKSVqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:46:32 -0500
Subject: Re: 2.6.10-rc2-mm2: spinlock problem in arch/i386/kernel/time.c on
	resume
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041119025357.4b6ca9f7.akpm@osdl.org>
References: <1100855456.22588.9.camel@outer-dhcp-100.goop.org>
	 <20041119025357.4b6ca9f7.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 19 Nov 2004 13:14:31 -0800
Message-Id: <1100898871.5056.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-0.mozer.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 02:53 -0800, Andrew Morton wrote:
> I can't imagine how that could happen.  I wonder if the spinlock debugging
> could be making a mistake.

When I disabled DEBUG_SPINLOCK, it works fine.  Does DEBUG_SPINLOCK have
any side effects?  I would have thought it wouldn't do anything on a UP,
non-PREEMPT system.

There is the comment in arch/i386/kernel/time.c saying that APM needs
get_cmos_time(), which is the site of the second message.  The code is
very simple, so its hard to see how this could be going wrong.  I'm
guessing, though, that this is a relatively untested path, since people
don't tend to use APM+SMP.

> > .config & lspci attached
> 
> I have but a lowly A21P.  With my .config it APM resumes happily.  With
> yours it refuses to even suspend.  And:
> 
> 
> 
> hdc: DMA disabled
> e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
> e100: Copyright(c) 1999-2004 Intel Corporation

I've been using the eepro100 driver lately, which doesn't seem to have
this problem at all.

	J

