Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266731AbUF3PhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266731AbUF3PhP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUF3PdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:33:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43751 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266717AbUF3P1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:27:34 -0400
Date: Wed, 30 Jun 2004 11:26:52 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
Message-ID: <20040630152651.GW21264@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200406301341.i5UDfkKX010518@localhost.localdomain> <20040630150430.GA28506@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630150430.GA28506@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 05:04:30PM +0200, Ingo Molnar wrote:
> > Are there known issues with the implementation of NPTL that might give
> > rise to this behaviour? What can we do to help understand and debug
> > it?
> 
> there's nothing special about NPTL, scheduling-wise. But if SCHED_FIFO
> is not properly set for all JACK threads that could explain the
> symptoms. You talked about kludges that are necessary to make all
> threads SCHED_FIFO - are you 100% sure that all JACK threads are indeed
> SCHED_FIFO after these kludges are applied? If yes and you are running a
> later kernel then it's something new and probably NPTL-unrelated.

One thing to note is that NPTL defaults to PTHREAD_INHERIT_SCHED
while LinuxThreads defaults to PTHREAD_EXPLICIT_SCHED.
So, if you care about what scheduling created threads will have
and want it to work with both NPTL and LinuxThreads, you want
pthread_attr_setinheritsched (&attr, PTHREAD_*_SCHED);
explicitely.

	Jakub
