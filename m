Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUHFVN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUHFVN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUHFVMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:12:39 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:55424 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268309AbUHFVMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:12:07 -0400
Date: Fri, 6 Aug 2004 23:11:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -mm swsusp: fix highmem handling
Message-ID: <20040806211152.GF30518@elf.ucw.cz>
References: <20040728222300.GA16671@elf.ucw.cz> <Pine.LNX.4.50.0408012308370.4359-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408012308370.4359-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm not sure why you are saving state before save_processor_state.
> > swsusp_arch_resume will overwrite this, anyway. Is it to make something
> > balanced?
> 
> Yes, so it matches the calls in swsusp_suspend() - Previously there was a
> hack that did kernel_fpu_end() after calling save_processor_state(), to
> pass in_atomic() checks. By restoring the state after we've snapshotted on
> suspend prevents this from being a problem.

> In general, if we assume that save_processor_state() does anything to the
> CPU, besides just benign register saving, we have to make sure that it's
> put into the same state on resume before we restore state..

Perhaps comment is needed there? "state saved by this is ignored, but
save_processor_state changes preempt count"? 

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
