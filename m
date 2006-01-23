Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWAWT5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWAWT5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWAWT5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:57:41 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31651 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932464AbWAWT5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:57:40 -0500
Subject: Re: Rationale for RLIMIT_MEMLOCK?
From: Lee Revell <rlrevell@joe-job.com>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060123185549.GA15985@merlin.emma.line.org>
References: <20060123105634.GA17439@merlin.emma.line.org>
	 <1138014312.2977.37.camel@laptopd505.fenrus.org>
	 <20060123165415.GA32178@merlin.emma.line.org>
	 <1138035602.2977.54.camel@laptopd505.fenrus.org>
	 <20060123180106.GA4879@merlin.emma.line.org>
	 <1138039993.2977.62.camel@laptopd505.fenrus.org>
	 <20060123185549.GA15985@merlin.emma.line.org>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 14:57:34 -0500
Message-Id: <1138046255.21481.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 19:55 +0100, Matthias Andree wrote:
> I'm asking the Bcc'd gentleman to reconsider mlockall() and perhaps
> use explicit mlock() instead. 

Probably good advice, I have found mlockall() to be especially
problematic with multithreaded programs and NPTL, as glibc eats
RLIMIT_STACK of unswappable memory for each thread stack which defaults
to 8MB here - you go OOM really quick like this.  Most people don't seem
to realize the need to set a sane value with pthread_attr_setstack().

(Even when not mlock'ed, insanely huge thread stack defaults seem to
account for a lot of the visible bloat on the desktop - decreasing
RLIMIT_STACK to 512KB reduces the footprint of Gnome 2.12 by 100+ MB.)

Lee

