Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265554AbTFRVvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265555AbTFRVvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:51:23 -0400
Received: from ns.suse.de ([213.95.15.193]:42766 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265554AbTFRVvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:51:22 -0400
To: David Mosberger <davidm@napali.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: add /proc/sys/kernel/cache_decay_ticks
References: <200306182151.h5ILpMcx022062@napali.hpl.hp.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Jun 2003 00:05:18 +0200
In-Reply-To: <200306182151.h5ILpMcx022062@napali.hpl.hp.com.suse.lists.linux.kernel>
Message-ID: <p73znkf2g9t.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> writes:

> /proc/sys/kernel/cache_decay_ticks allows runtime tuning of the
> scheduler.  The earlier patch collided with the C99-ification of the
> file, so here is a retransmit.

Funny, I did a similar patch for 2.4 a short time ago. But I would
suggest one change before you merge that to mainline. The variable
is currently used like this:

#define CAN_MIGRATE_TASK(p,rq,this_cpu)                                 \
        ((jiffies - (p)->last_run > cache_decay_ticks) &&       \o

Which means 0 means 1 jiffie. For a tunable it would be useful to be 
able to turn it off completely, which means the > needs to be replaced
with a >=. Unfortunately this requires changes in the architectures
too to subtract one. But it would make it more useful. I would do
the change before exposing it.

-Andi
