Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUGFQcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUGFQcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 12:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUGFQcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 12:32:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25501 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264147AbUGFQcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 12:32:15 -0400
Date: Tue, 6 Jul 2004 12:31:41 -0400
From: Alan Cox <alan@redhat.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: question about /proc/<PID>/mem in 2.4
Message-ID: <20040706163141.GI11736@devserv.devel.redhat.com>
References: <20040706110436.GA11441@logos.cnet> <Pine.LNX.4.44.0407061406200.20027-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407061406200.20027-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 02:08:04PM +0100, Tigran Aivazian wrote:
> > This code was added to stop the ptrace/kmod vulnerabilities. I do not 
> > fully understand the issues around tsk->is_dumpable and the fix itself,
> > but I agree on that the checks here could be relaxed for the super user.

is_dumpable tells you various things in 2.4, including whether the
curent memory image is valid, and as a race preventor for ptrace during
exec of setuid apps. You should probably talk to Solar Designer about
the whole design of the dump/suid race fixing work rather than me.

We also had to deal with another nasty case which could be fixed by grabbing
the mm at open time (which then opens a resource attack bug).

Consider what happens if your setuid app reads stdin

	setuidapp < /proc/self/mem

(No idea how 2.6 deals with these but if its got better backportable ways
 that *actually work* it might make sense).


