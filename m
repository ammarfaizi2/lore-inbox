Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVAYCij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVAYCij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 21:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAYCij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 21:38:39 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:7927 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261735AbVAYCbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 21:31:25 -0500
Message-ID: <41F5AF72.8000502@mvista.com>
Date: Mon, 24 Jan 2005 18:31:14 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH 4/7] posix-timers: CPU clock support for POSIX timers
References: <200501232325.j0NNPUg7006501@magilla.sf.frob.com>
In-Reply-To: <200501232325.j0NNPUg7006501@magilla.sf.frob.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:
> POSIX requires that when you claim _POSIX_CPUTIME and _POSIX_THREAD_CPUTIME,
> not only the clock_* calls but also timer_* calls must support the thread
> and process CPU time clocks.  This patch provides that support, building on
> my recent additions to support these clocks in the POSIX clock_* interfaces.
> This patch will not work without those changes, as well as the patch fixing
> the timer lock-siglock deadlock problem.
> 
> The apparent pervasive changes to posix-timers.c are simply that some
> fields of struct k_itimer have changed name and moved into a union.
> This was appropriate since the data structures required for the existing
> real-time timer support and for the new thread/process CPU-time timers are
> quite different.

Possibly you could bury these name changes in defines.  I suspect the code would 
be easier to read and that we really don't need to be reminded that it is a 
union on each reference.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

