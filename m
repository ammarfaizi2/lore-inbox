Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUIAB1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUIAB1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUIAB1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:27:25 -0400
Received: from ozlabs.org ([203.10.76.45]:46813 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266534AbUIAB1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:27:20 -0400
Date: Wed, 1 Sep 2004 11:26:13 +1000
From: Anton Blanchard <anton@samba.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       John Levon <levon@movementarian.org>,
       Philippe Elie <phil.el@wanadoo.fr>
Subject: Re: [PATCH][1/3] Completely out of line spinlocks / generic
Message-ID: <20040901012613.GL26072@krispykreme>
References: <Pine.LNX.4.58.0408292359320.24992@montezuma.fsmlabs.com> <Pine.LNX.4.58.0408300057130.24992@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408300057130.24992@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Looking at the PPC oprofile code, how does contention get reported?
> get_pc() looks like it may be returning _raw_spin_*

Yep unfortunately we end up with ticks in the out of line spinlock
functions. We could recognise this in the profile code and walk up the
stack, I think sparc64 has been doing that.

I have a similar problem with hardware performance counters but its much
more difficult there. Since we dont have an NMI you get the profile tick
when interrupts are reenabled. At that point we may be out of the spin
lock so backtracing is impossible.

Anton
