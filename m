Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTD2UCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 16:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTD2UCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 16:02:05 -0400
Received: from uswest-dsl-142-38.cortland.com ([209.162.142.38]:34573 "HELO
	warez.scriptkiddie.org") by vger.kernel.org with SMTP
	id S261741AbTD2UCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 16:02:04 -0400
Date: Tue, 29 Apr 2003 13:14:22 -0700 (PDT)
From: Lamont Granquist <lamont@scriptkiddie.org>
X-X-Sender: lamont@uswest-dsl-142-38.cortland.com
To: Alex Riesen <alexander.riesen@synopsys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIGRTMIN, F_SETOWN(-getpgrp()) and threads
In-Reply-To: <20030429120814.GF890@riesen-pc.gr05.synopsys.com>
Message-ID: <20030429131246.G90816-100000@uswest-dsl-142-38.cortland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Apr 2003, Alex Riesen wrote:
> Lamont Granquist, Tue, Apr 29, 2003 01:34:21 +0200:
> >
> > I'm attempting to send SIGRTMIN to an entire pgrp composed of threads.
> > I'm running into issues with the management thread getting this signal and
> > dying because it is uncaught in that thread.  Is there any way to make the
> > management thread ignore this signal?  (and i'm running linux 2.4.20-ish
> > and glibc-2.2.4-19.3)
> >
>
> ignore it before pthreads are initialized?
>
> int main(int argc, char* argv[])
> {
>     signal(SIGRTMIN, SIG_IGN);
>     ...

That doesn't work.  After the first pthread_create() if you raise() the
signal again (even if you ignore it in the thread that you create) you'll
still have the manager thread exit.

