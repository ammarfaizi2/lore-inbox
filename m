Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263783AbTJ1AOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 19:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTJ1AOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 19:14:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:5508 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263783AbTJ1AOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 19:14:53 -0500
Date: Mon, 27 Oct 2003 16:15:02 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday resolution seriously degraded in test9
Message-Id: <20031027161502.3f98c556.shemminger@osdl.org>
In-Reply-To: <20031027234447.GA7417@rudolph.ccur.com>
References: <20031027234447.GA7417@rudolph.ccur.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003 18:44:47 -0500
Joe Korty <joe.korty@ccur.com> wrote:

> [ 2nd posting, the first seems to have been lost ]
> 
> Linus,
>  This bit of -test9 code reduces the resolution of gettimeofday(2) from
> 1 microsecond to 1 millisecond whenever a negative time adjustment is
> in progress.  This seriously damages efforts to measure time intervals
> accurately with gettimeofday.  Please consider backing it out.
> 
> Joe

The problem is that it is worse to have time go backwards which is what we
have done up until test9. It might be possible to compress time when NTP is doing
negative adjustments, but if you really care about microsecond resolution then
you will still lose. 

If you care about microseconds, then NTP is going to whack your data.  It has to
cause clock to speed up/slow down.  Your data points will skip and stall due to it.
Use a different clock source or don't run NTP if you are doing real time stuff.

