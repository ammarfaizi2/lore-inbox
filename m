Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271264AbTGWTwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271265AbTGWTwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:52:21 -0400
Received: from rth.ninka.net ([216.101.162.244]:38529 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S271264AbTGWTwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:52:18 -0400
Date: Wed, 23 Jul 2003 13:07:12 -0700
From: "David S. Miller" <davem@redhat.com>
To: root@chaos.analogic.com
Cc: bernie@develer.com, uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6 size increase
Message-Id: <20030723130712.6ac59b56.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.53.0307231507300.16939@chaos>
References: <200307232046.46990.bernie@develer.com>
	<Pine.LNX.4.53.0307231507300.16939@chaos>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 15:14:22 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> On Wed, 23 Jul 2003, Bernardo Innocenti wrote:
> It looks like a lot of data may have been initialized in the
> newer kernel, i.e. int barf = 0; or struct vomit = {0,}.
> If they just declared the static data, it would end up in
> .bss which is allocated at run-time (and zeroed) and is
> not in the kernel image.

GCC 3.3 and later do this automatically.

It's weird, since we killed TONS of explicit zero initializers during
2.5.x, you'd be pressed to find many examples like the one you
mention.

Another thing is that the define_per_cpu() stuff eliminated many huge
[NR_CPUS] arrays.  But this probably doesn't apply to his kernel
unless he built is with SMP enabled.
