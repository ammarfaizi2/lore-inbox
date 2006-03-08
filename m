Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWCHISm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWCHISm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 03:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWCHISm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 03:18:42 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:42151
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932489AbWCHISl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 03:18:41 -0500
Message-ID: <440E935A.70103@tglx.de>
Date: Wed, 08 Mar 2006 09:18:34 +0100
From: Jan Altenberg <tb10alj@tglx.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rt20 compilation errors
References: <6bffcb0e0603070919k64e325f6h@mail.gmail.com>
In-Reply-To: <6bffcb0e0603070919k64e325f6h@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I have noticed that -rt19 and -rt20 doesn't compile on my system.

I just had a quick glance at kernel/rt-debug.h
For example debug_rt_lockmode_spin_trylock is defined as followed:

# define debug_rt_lockmode_spin_trylock(_lock)      \
    _raw_spin_trylock((_lock)->debug_slock)

But _raw_spin_trylock expects a pointer to a raw_spinlock_t. So
shouldn't it be

# define debug_rt_lockmode_spin_trylock(_lock)      \
    _raw_spin_trylock(&(_lock)->debug_slock)

??

Same for debug_rt_lockmode_spin_unlock and debug_rt_lockmode_spin_trylock.


Regards
JAN
