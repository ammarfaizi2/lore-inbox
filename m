Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280682AbRKJP3Q>; Sat, 10 Nov 2001 10:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280684AbRKJP3F>; Sat, 10 Nov 2001 10:29:05 -0500
Received: from mmohlmann.demon.nl ([212.238.27.16]:15876 "HELO
	brand.mmohlmann.demon.nl") by vger.kernel.org with SMTP
	id <S280682AbRKJP24>; Sat, 10 Nov 2001 10:28:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: Andrea Arcangeli <andrea@suse.de>, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] fix loop with disabled tasklets
Date: Sat, 10 Nov 2001 16:29:00 +0100
X-Mailer: KMail [version 1.3.1]
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <20011110122141.B2C68231A4@brand.mmohlmann.demon.nl> <20011110.053720.55510115.davem@redhat.com> <20011110160301.B1381@athlon.random>
In-Reply-To: <20011110160301.B1381@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011110152845.8328F231A4@brand.mmohlmann.demon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 November 2001 16:03, Andrea Arcangeli wrote:
> just playing with the "softirq_raise" would be much simpler but I can
> see only one problem: we don't know what cpu the tasklet is scheduled
> into, so we don't know where to signal the local softirq.
>
> So it seems to fix the looping problem of disabled tasklets we should
> really dschedule the tasklet in tasklet_disable (and of course to forbid
> it to be scheduled when disabled in tasklet_schedule) and later to
> reschedule it in tasklet_enable.

Or add a cpu field to struct tasklet_struct.

> Infact at the moment it's even impossible to remove a tasklet from the
> queue if it remains disabled forever. tasklet_kill will deadlock on a
> tasklet that is disabled.
I think this is the responsability of the device driver writer (or who ever 
uses it). AFAIK there is no defined behavior for this case. I vote for 
removing the tasklet without it ever being run.

	me
