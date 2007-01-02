Return-Path: <linux-kernel-owner+w=401wt.eu-S964868AbXABSED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbXABSED (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbXABSED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:04:03 -0500
Received: from thunk.org ([69.25.196.29]:57527 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932888AbXABSEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:04:01 -0500
Date: Tue, 2 Jan 2007 13:03:54 -0500
From: Theodore Tso <tytso@mit.edu>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Print sysrq-m messages with KERN_INFO priority
Message-ID: <20070102180354.GA892@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Alan <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <E1H0Uq5-0003Fo-1W@candygram.thunk.org> <20061229204247.be66c972.akpm@osdl.org> <20070102043743.GB15718@thunk.org> <20070102103332.46de83bd@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102103332.46de83bd@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 10:33:32AM +0000, Alan wrote:
> On Mon, 1 Jan 2007 23:37:43 -0500
> Theodore Tso <tytso@mit.edu> wrote:
> > > Is this patch a consistency thing?
> > 
> > The goal of the patch was to avoid filling /var/log/messages huge
> > amounts of sysrq text.  Some of the sysrq commands, especially sysrq-m
> > and sysrq-t emit a truly vast amount of information, and it's not
> > really nice to have that filling up /var/log/messages.  
> 
> I find it extremely useful that it ends up in /var/log/messages so that I
> can review the dump later. Often the first glance through a set of dumps
> on things like a process deadlock don't reveal the right information and
> you need to go back and look again.

Maybe it's something that should be configurable?

Usually I end up configuring a separate line in /etc/syslog.conf so
that it gets logged to a file --- but not one which is subject to the
same retention period as /var/log/messages.  The reason why this
becomes an issue for me is that unfortunately, there is some
information displayed by alt-sysrq-m that can't be found any other way
--- it's not available in /proc/slabinfo, /proc/meminfo, etc.  So I
have a script which I use when I'm trying to debug obscure customer
problems which does an "echo m > /proc/sysrq-trigger" every 15
minutes, so I can gather information that might help point towards the
problem. 

Granted, most of the time the additional information shown by sysrq-m
isn't necessary, but I usually get called in after the other Level 3
support folks haven't been able to solve the problem, so like the
Richard Feymenn story, it's a tool that everyone else doesn't have in
their toolbox, so it often solves problems that others haven't been
able to figure out.

So maybe the right solution is either to make the priority level
configurable, or perhaps better, making the sysrq-m information
available via either /proc or /sys?

						- Ted
