Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVELI63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVELI63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVELI4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:56:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28047 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261366AbVELIyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:54:47 -0400
Date: Thu, 12 May 2005 10:55:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Kirill Korotaev <dev@sw.ru>
Cc: seife@suse.de, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Software suspend and recalc sigpending bug fix
Message-ID: <20050512085502.GC2005@elf.ucw.cz>
References: <428222CF.3070002@sw.ru> <20050511180411.GB1866@elf.ucw.cz> <4282FB27.6090801@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4282FB27.6090801@sw.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 12-05-05 10:43:51, Kirill Korotaev wrote:
> >>This patch fixes recalc_sigpending() to work correctly
> >>with tasks which are being freezed. The problem is that
> >>freeze_processes() sets PF_FREEZE and TIF_SIGPENDING
> >>flags on tasks, but recalc_sigpending() called from
> >>e.g. sys_rt_sigtimedwait or any other kernel place
> >>will clear TIF_SIGPENDING due to no pending signals queued
> >>and the tasks won't be freezed until it recieves a real signal
> >>or freezed_processes() fail due to timeout.
> >>
> >>Signed-Off-By: Kirill Korotaev <dev@sw.ru>
> >>Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> >
> >
> >This should fix our problems with mysqld, right? Yes, patch looks good
> >(modulo missing whitespace around &)). I'll apply it to my tree. (Or
> >andrew, if you prefer, just take it...
> 
> Another cleanup idea in swsusp: it would be nice if all such checks for 
> PF_FREEZE were wrapped in inline function 
> is_task_freezing()/any_thing_else, to make freeze code disappear when 
> CONFIG_PM/CONFIG_SOFTWARE_SUSPEND is off...

S3 case needs this, too. Nicer solution would be to just define
PF_FREEZE to 0 when it is not needed; but as most hooks are hidden in
try_to_freeze(), anyway, I do not think this is worth it.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
