Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVEIVmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVEIVmn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVEIVmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 17:42:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:17102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261532AbVEIVmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 17:42:40 -0400
Date: Mon, 9 May 2005 14:42:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, kenneth.w.chen@intel.com
Subject: Re: [RFC][PATCH] timers fixes/improvements
Message-Id: <20050509144255.17d3b9aa.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505091312490.27740@graphe.net>
References: <424D373F.1BCBF2AC@tv-sign.ru>
	<424E6441.12A6BC03@tv-sign.ru>
	<Pine.LNX.4.58.0505091312490.27740@graphe.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> We have some strange race conditions as a result of the timer
> scalability fixes.
> 
> ptype_all is set to 0x10:0x10 on faster systems (Xeon 3.6Ghz).
> Slower systems do fine(Xeon 3.0Ghz) and do not corrupt ptype_all.
> 
> Its not clear to me how ptype_all could relate to timer operations

I'd do `nm -n vmlinux', see which data structures the linker placed nearby
to ptype_all and then go looking for overruns against them.

ptype_base is an array, but I cannot see any race around ptype_base.  So
look to see if ptype_base is corrupted as well, keep walking back through
memory, see where the scribble starts.

> but
> if I apply these timer patches I get ptype_all corruption.
> 
> timers-fixes-improvements.patch
> timers-fixes-improvements-smp_processor_id-fix.patch
> timers-fixes-improvements-fix.patch
> timer-deadlock-fix
> (It does not matter if the last three are applied)

2.6.12-rc3-mm3 has different patches:

timers-fixes-improvements.patch
timers-fixes-improvements-smp_processor_id-fix.patch
timers-fixes-improvements-fix.patch
timers-fix-__mod_timer-vs-__run_timers-deadlock.patch
timers-fix-__mod_timer-vs-__run_timers-deadlock-tidy.patch
timers-comments-update.patch
kernel-timerc-remove-a-goto-construct.patch

