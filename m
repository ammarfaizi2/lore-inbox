Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264066AbUKZVCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbUKZVCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbUKZUqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:46:42 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:13993 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264158AbUKZUgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:36:43 -0500
Subject: Re: Suspend 2 merge: 14/51: Disable page alloc failure message
	when suspending
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125215641.GH2488@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101294838.5805.245.camel@desktop.cunninghams>
	 <20041125181529.GE1417@openzaurus.ucw.cz>
	 <1101419381.27250.38.camel@desktop.cunninghams>
	 <20041125215641.GH2488@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101422779.27250.102.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 09:46:19 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 08:56, Pavel Machek wrote:
> Hi!
> 
> > > > While eating memory, we will potentially trigger this a lot. We
> > > > therefore disable the message when suspending.
> > > 
> > > You should only trigger this while eating memory, so *one* GFP_NOWARN should be
> > > enough. And shrink_all_memory should fix it anyway.
> > 
> > Agreed. I wasn't seriously suggesting changing everywhere to be
> > GFP_NOWARN. Perhaps I should be more explicit in what I'm saying here.
> > The problem isn't just suspend trying to allocate memory. It's
> > _ANYTHING_ that might be running trying to allocate memory while we're
> > eating memory. (Remember that we don't just call shrink_all_memory, but
> > also allocate that memory so other processes don't grab it and stop us
> > making forward progress). As a result, they're going to scream when they
> > can't allocate a page.
> 
> Hmm, that does not look too healthy. That means that userland programs
> will see all kinds of weird error conditions that normally
> "almost-can't-happen" during normal usage.

Failure to allocate memory should be something any caller to get_*_page 
deals with, so if they don't, are we to be blamed?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

