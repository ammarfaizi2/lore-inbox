Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTJRXP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 19:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTJRXP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 19:15:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:45237 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261929AbTJRXPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 19:15:22 -0400
Date: Sat, 18 Oct 2003 16:14:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@digitalvampire.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6.0-test8 __might_sleep warnings on boot
Message-Id: <20031018161439.484915f8.akpm@osdl.org>
In-Reply-To: <87he26p6pq.fsf@love-shack.home.digitalvampire.org>
References: <87he26p6pq.fsf@love-shack.home.digitalvampire.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@digitalvampire.org> wrote:
>
>  +	/* __might_sleep checks now make sense */
>  +	init_idle_done = 1;

We already have the `system_running' flag which is suitable for this.

I've been dithering over whether we should use it, mainly because doing
things like downing a semaphore before we've even called sched_init()
(cpufreq) is a happens-to-be-harmless but fairly dumb thing to do.

Yes, we should probably do something like this, but later.

