Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVAGQE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVAGQE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVAGQE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:04:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4553 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261477AbVAGQEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:04:43 -0500
Date: Fri, 7 Jan 2005 17:03:51 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107160350.GB29327@devserv.devel.redhat.com>
References: <20050107153328.GD28466@devserv.devel.redhat.com> <200501071541.j07FfeQC018553@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071541.j07FfeQC018553@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 10:41:40AM -0500, Paul Davis wrote:
> 
> fine, so the mlock situation may have improved enough post-2.6.9 that
> it can be considered fixed. that leaves the scheduler issue. but
> apparently, a uid/gid solution is OK for mlock, and not for the
> scheduler. am i missing something?

I think you skipped a step. You don't have a scheduler requirement, you have
a latency requirement. You currently *solve* that latency requirement via a
scheduler "hack", yet is quite clear that the "hard" realtime solution is
most likely not the right approach. Note that I'm not saying that you
shouldn't get the latency that that currently provides, but the downsides
(can hang the machine) are bad; a solution that solves that would be far
preferable
something like a soft realtime flag that acts as if it's the hard realtime
one unless the app shows "misbehavior" (eg eats its timeslice for X times in
a row) might for example be such a solution. And with the anti abuse
protection it can run with far lighter privilegs.
