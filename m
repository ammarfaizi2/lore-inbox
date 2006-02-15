Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWBOXeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWBOXeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 18:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWBOXeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 18:34:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27145 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932184AbWBOXeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 18:34:16 -0500
Date: Wed, 15 Feb 2006 23:34:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: frankeh@watson.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: SMP BUG
Message-ID: <20060215233410.GE1508@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, frankeh@watson.ibm.com,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <43F12207.9010507@watson.ibm.com> <20060215230701.GD1508@flint.arm.linux.org.uk> <20060215151716.201da5de.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215151716.201da5de.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 03:17:16PM -0800, Andrew Morton wrote:
> Is arm's setup_arch() populating cpu_possible_map?

Correct, because setup_arch() itself doesn't have _any_ SMP awareness at
all - only the platform code knows about that.  Hence, we initialise it
in smp_prepare_cpus(), which is a platform specific function.

> If that's not possible, statically initialising it to CPU_MASK_ALL should
> fix it, but that's a lame solution and might lead to wastage of per-cpu
> memory on not-possible CPUs.

I think that's what we'll have to do, and then later on clear it and
re-populate it with the correct bitmask.  Grumble.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
