Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTE1WRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbTE1WRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:17:37 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:40564 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261168AbTE1WRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:17:36 -0400
Date: Wed, 28 May 2003 15:28:27 -0700
From: Andrew Morton <akpm@digeo.com>
To: mikpe@csd.uu.se
Cc: pavel@suse.cz, miltonm@bga.com, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] fix oops on resume from apm bios initiated suspend
Message-Id: <20030528152827.5387e033.akpm@digeo.com>
In-Reply-To: <16084.46712.707240.943086@gargle.gargle.HOWL>
References: <200305280643.h4S6hRQF028038@sullivan.realtime.net>
	<20030528111401.GB342@elf.ucw.cz>
	<16084.46712.707240.943086@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 22:30:52.0776 (UTC) FILETIME=[CC1C9E80:01C32568]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikpe@csd.uu.se wrote:
>
>  > > -	load_LDT(&current->mm->context);	/* This does lldt */
>  > > +	load_LDT(&current->active_mm->context);	/* This does lldt */
> 
> No one has still explained WHY kapmd's current->mm is NULL for some people,
> while it obviously is non-NULL for many others.

All kernel threads have current->mm = NULL, via daemonize()->exit_mm().  So
the question becomes "why does this code get called by kernel threads for
some people, and not for others"?  Pavel?

Also, is there any point in doing load_LDT(&current->active_mm->context)
for a kernel thread?

> That worries me a lot more.

I'm more worried by the 113-column line in fix_processor_context() :)

