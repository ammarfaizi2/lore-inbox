Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVFMQiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVFMQiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVFMQiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:38:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42954 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261814AbVFMQg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:36:56 -0400
Date: Mon, 13 Jun 2005 12:36:50 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Add pselect, ppoll system calls.
Message-ID: <20050613163650.GW22349@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <42AD2640.5040601@redhat.com> <20050613091600.GA32364@outpost.ds9a.nl> <1118655702.2840.24.camel@localhost.localdomain> <20050613110556.GA26039@infradead.org> <20050613111422.GT22349@devserv.devel.redhat.com> <1118661848.2840.34.camel@localhost.localdomain> <42ADA880.60303@redhat.com> <1118678548.25956.200.camel@hades.cambridge.redhat.com> <42ADAFE5.5050206@redhat.com> <1118680177.25956.213.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118680177.25956.213.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 05:29:37PM +0100, David Woodhouse wrote:
> On Mon, 2005-06-13 at 09:10 -0700, Ulrich Drepper wrote:
> > poll()'s timeout value is measrued in milliseconds.  Using a 32bit
> > value, as implied by using 'int' for the type, limits the mximum
> > timeout to be 2^31-1 milliseconds, which means about 24 days.
> 
> Ah, OK. I thought you were talking about the timespec in pselect(),
> because that's what you quoted. 
> 
> Yes, we should make the time for ppoll() a 64-bit value, so you can
> request a time period longer than 24 days. Shall we also switch to
> microseconds?

I think passing const struct timeval * or const struct timespec *
(depending if you want micro or nanoseconds) is better and what
other functions use for timeouts, then passing int64_t.

	Jakub
