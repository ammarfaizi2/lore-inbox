Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWEOOFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWEOOFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWEOOFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:05:55 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:41354 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964914AbWEOOFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:05:54 -0400
Date: Mon, 15 May 2006 10:03:42 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Daniel Walker <dwalker@mvista.com>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH -rt] scheduling while atomic in fs/file.c
In-Reply-To: <1147700263.15392.47.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Message-ID: <Pine.LNX.4.58.0605150955380.16618@gandalf.stny.rr.com>
References: <200605141545.k4EFj6Cv001901@dwalker1.mvista.com> 
 <Pine.LNX.4.58.0605141241320.25158@gandalf.stny.rr.com> 
 <1147627976.15392.39.camel@c-67-180-134-207.hsd1.ca.comcast.net> 
 <Pine.LNX.4.58.0605150239570.6512@gandalf.stny.rr.com> 
 <Pine.LNX.4.58.0605150254440.6512@gandalf.stny.rr.com>
 <1147700263.15392.47.camel@c-67-180-134-207.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 May 2006, Daniel Walker wrote:

>
> Why would it be a problem if the timer moved ? Or the work queue? both
> are protected under a spinlock which is consistently held .
>

fine, but the patch is still wrong.  If it really doesn't matter
which one it's on, instead of moving the put, just get the cpu var with
per_cpu(fdtable_defer_list, raw_smp_processor_id()) and get rid of the put
altogether.

Ingo,

Didn't John have a patch that did something with get_percpu_var() that
made this simple?

-- Steve

