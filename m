Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWBOXhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWBOXhI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 18:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWBOXhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 18:37:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27913 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750832AbWBOXhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 18:37:06 -0500
Date: Wed, 15 Feb 2006 23:37:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, frankeh@watson.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: SMP BUG
Message-ID: <20060215233700.GF1508@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, frankeh@watson.ibm.com,
	linux-kernel@vger.kernel.org
References: <43F12207.9010507@watson.ibm.com> <20060215230701.GD1508@flint.arm.linux.org.uk> <Pine.LNX.4.64.0602151521320.22082@g5.osdl.org> <20060215153013.474ff5e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215153013.474ff5e0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 03:30:13PM -0800, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> > That said, nobody seemed to comment on this patch by Rik, which seemed to 
> >  be a nice cleanup regardless of any other issues.
> 
> I thought that patch wasn't a good one.  The runqueues should be
> initialised in sched_init().  init_idle() is called from fork_idle() which
> is called from the bowels of arch code.  I'm not sure that it gets called
> at all if !SMP (which seems strange).

Wouldn't it make sense to do this initialisation in a CPU_UP_PREPARE
notifier, if not already done?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
