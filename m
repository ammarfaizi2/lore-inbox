Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbUBTQK4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 11:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUBTQK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 11:10:56 -0500
Received: from gprs149-141.eurotel.cz ([160.218.149.141]:62592 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261332AbUBTQKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 11:10:53 -0500
Date: Fri, 20 Feb 2004 17:10:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Booting when CPUs fail to come up.
Message-ID: <20040220161042.GI23278@elf.ucw.cz>
References: <20040213075743.7D1332C12A@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213075743.7D1332C12A@lists.samba.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I recently played with setting a bit in cpu_possible_map that wasn't
> in cpu_online_map: this can happen without hotplug CPU when a CPU
> fails to boot, for example.
> 
> 1) i386 should use cpu_callin_map for num_booting_cpus() (an x86-ism
>    anyway): if a CPU doesn't come up, it will be set in
>    cpu_possible_map (aka cpu_callout_map) but not cpu_callin_map.
> 
> 2) When the cpu fails to come up, some callbacks do kthread_stop(),
>    which doesn't work without keventd (which hasn't started yet).
>    Call it directly, and take care that it restores signal state
>    (note: do_sigaction does a flush on blocked signals, so we don't
>    need to repeat it).

Is it safe to continue when one cpu is apparently malfunctioning?

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
