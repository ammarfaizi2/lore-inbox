Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265852AbUAUAAp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUAUAAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:00:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:17378 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265845AbUAUAAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:00:44 -0500
Date: Tue, 20 Jan 2004 16:01:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: swsusp does not stop DMA properly during resume
Message-Id: <20040120160159.5cb078ec.akpm@osdl.org>
In-Reply-To: <20040120235347.GE1234@elf.ucw.cz>
References: <20040120224653.GA19159@elf.ucw.cz>
	<20040120150629.6949eda7.akpm@osdl.org>
	<1074642037.739.49.camel@gaston>
	<20040120235347.GE1234@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Hi!
> 
> > > I _think_ what this patch is doing is suspending all devices from within
> > > the boot kernel before starting into the resumed kernel.  Is this correct?
> > > 
> > > > +	update_screen(fg_console);	/* Hmm, is this the problem? */
> > > 
> > > Cryptic comment.  To what "problem" does this refer?
> > 
> > Note that you should make sure all calls to update_screen (among others)
> > are guarded by the console semaphore, with my VT patch, not doing so
> > will result in WARN_ON's
> 
> Hmmm... yes, I'll need to fix that one. [Is there console semaphore in
> 2.6.1, or do I need to wait for 2.6.2 before I can do something with
> this?]

It's acquire_console_sem()/release_console_sem().

I'll change the patch.  Could you please test it all in next -mm, let me
know?

