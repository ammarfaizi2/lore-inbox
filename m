Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTE2CDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 22:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTE2CDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 22:03:48 -0400
Received: from holomorphy.com ([66.224.33.161]:5765 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261864AbTE2CDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 22:03:47 -0400
Date: Wed, 28 May 2003 19:16:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: jim.houston@attbi.com, linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: signal queue resource - Posix timers
Message-ID: <20030529021654.GG19818@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ulrich Drepper <drepper@redhat.com>, jim.houston@attbi.com,
	linux-kernel@vger.kernel.org, jim.houston@ccur.com
References: <200305281856.h4SIuFZ02449@linux.local> <3ED531AD.1020309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED531AD.1020309@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 03:01:17PM -0700, Ulrich Drepper wrote:
> That's not really how you can interpret this.  At the time timer_create
> is it is not know when the timer expires and whether it's a repeating
> timer.  Therefore it is not correct to assume that if timer_create
> succeeds the resources to always deliver the signal are available.
> The shall-error in the standard just covers the case if there is really
> no way this can be made working.  For instance, some implementation
> might allocate to each process using timer_create N signal slots.  The
> whole system could have only N * M slots.
> Because there is no fixed limit (or better said: no guaranteed minimal
> number of signal slots) in Linux this error doesn't apply at all.

The inability to prevent events from coming in faster than one can
process them does create an escape hatch so one doesn't have to handle
this case because it doesn't specify that minimum. Perhaps the
criterion for merging should be if some application is negatively
affected?

But I'm not convinced this would harm anything if merged beforehand.
It's also nice to exert explicit control over competition for memory.


-- wli
