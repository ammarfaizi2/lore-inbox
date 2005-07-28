Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVG1HlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVG1HlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVG1HlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:41:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19879 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261317AbVG1HlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:41:21 -0400
Date: Thu, 28 Jul 2005 09:41:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Alternative to TIF_FREEZE -> a notifier in the task_struct?
Message-ID: <20050728074116.GF6529@elf.ucw.cz>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net> <Pine.LNX.4.62.0507272018060.11863@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507272018060.11863@graphe.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This could be used to have a process execute any other piece that is 
> required to run in the context of the thread. Maybe such a feature could 
> help with PTRACE or/and get_user_pages that currently do ugly things to a 
> process. It may also allow changing values that so far cannot be
> changed from the outside in the task struct by running a function
> in the context of the process.

Well, we really need slightly more from "running in process context":
we also need "no locks held" for swsusp. (But other uses probably do,
too?)

> Here is a patch against Linus current tree that does this. Note that this 
> patch is incomplete at this point and only a basis for further discussion. 
> Not all software suspend checkpoints are useful for a notifier chain. We 
> would need to inspect several cases where drivers/kernel threads have 
> special functionality for software suspend.

I guess I'd prefer if you left "refrigerator()" and "try_to_freeze()"
functions in; there are about 1000 drivers that know/use them, and
some patches are probably in the queue....

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
