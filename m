Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTD3JDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 05:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTD3JDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 05:03:48 -0400
Received: from boden.synopsys.com ([204.176.20.19]:23215 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP id S261631AbTD3JDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 05:03:47 -0400
Date: Wed, 30 Apr 2003 11:15:52 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Lamont Granquist <lamont@scriptkiddie.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIGRTMIN, F_SETOWN(-getpgrp()) and threads
Message-ID: <20030430091552.GA10426@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <20030429120814.GF890@riesen-pc.gr05.synopsys.com> <20030429131246.G90816-100000@uswest-dsl-142-38.cortland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030429131246.G90816-100000@uswest-dsl-142-38.cortland.com>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lamont Granquist, Tue, Apr 29, 2003 22:14:22 +0200:
> > > I'm attempting to send SIGRTMIN to an entire pgrp composed of threads.
> > > I'm running into issues with the management thread getting this signal and
> > > dying because it is uncaught in that thread.  Is there any way to make the
> > > management thread ignore this signal?  (and i'm running linux 2.4.20-ish
> > > and glibc-2.2.4-19.3)
> > ignore it before pthreads are initialized?
> >
> > int main(int argc, char* argv[])
> > {
> >     signal(SIGRTMIN, SIG_IGN);
> >     ...
> That doesn't work.  After the first pthread_create() if you raise() the
> signal again (even if you ignore it in the thread that you create) you'll
> still have the manager thread exit.

probably because it is used by pthreads for internal communication.
It's mentioned in 2.2.5 (at least) sources.

