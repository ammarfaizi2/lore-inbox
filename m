Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992802AbWKAUbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992802AbWKAUbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992805AbWKAUbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:31:13 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62387 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S2992802AbWKAUbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:31:12 -0500
Message-ID: <45490402.1090706@watson.ibm.com>
Date: Wed, 01 Nov 2006 15:30:58 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, Thomas Graf <tgraf@suug.ch>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] taskstats: uglify^Woptimize reply assembling
References: <20061101182512.GA444@oleg>
In-Reply-To: <20061101182512.GA444@oleg>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> The last series.
> 
Thanks again for the refactoring/review and optimizations to the code
base. Some of the earlier patches I'm still processing (to be sure the
timings etc. of signal clearing vs. task exit are right) but these later
ones are pretty straightforward and look good. Testing needed of course.

> Balbir, Shailabh, could you suggest me some user-space tests?

For stress testing, what we've used is to run

- one listener continuously getting exit stats (prototype listener
code in Documentation/accounting/getdelays.c)
- a multithreaded app where each thread does some disk I/O and some
cpu processing (incrementing a count etc.), threads get created and
destroyed in a continuous loop
- periodically query the multithreaded app above (print out its tgid first)
using another instance of Documentation/accounting/getdelays.c to see
if the delay data is getting incremented as expected by what the threads do.
- cerebrus and/or kernel compiles running in background just to create
a load

You can drop the cerebrus etc. if the load gets too much.

Running the above past a few hours has caught the kind of bugs seen so far.

> 
> Thomas, we are doing genlmsg_cancel() before nlmsg_free(), this is
> not necessary. Unless you have evil plans to complicate genetlink
> we can remove a little bit of code, what do you think?
> 
> Oleg.
> 

