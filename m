Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272358AbTGaAGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272363AbTGaAGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:06:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:57990 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272358AbTGaAGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:06:11 -0400
Date: Wed, 30 Jul 2003 16:54:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linas@austin.ibm.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       olh@suse.de, olof@austin.bim.com
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-Id: <20030730165418.2f2db960.akpm@osdl.org>
In-Reply-To: <20030730235607.GC322@dualathlon.random>
References: <20030730082848.GC23835@dualathlon.random>
	<Pine.LNX.4.44.0307301223450.13299-100000@localhost.localdomain>
	<20030730184317.B23750@forte.austin.ibm.com>
	<20030730235607.GC322@dualathlon.random>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> 2.6 will kernel crash like we did in 2.4 only if it calls
> add_timer_on from timer context (of course with a cpuid != than the
> smp_processor_id()), that would be fixed by the timer->lock everywhere
> that we've in 2.4 right now.  (but there's no add_timer_on in 2.4
> anyways)

add_timer_on() was added specifically for slab bringup.  If we need extra
locking to cope with it then the best solution would probably be to rename
it to add_timer_on_dont_use_this_for_anything_else().

But if we are going to rely on timer handlers only ever running on the
adding CPU for locking purposes then can we please have a big comment
somewhere describing what's going on?  It's very subtle...

