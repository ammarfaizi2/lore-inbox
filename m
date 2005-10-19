Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVJSPID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVJSPID (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVJSPID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:08:03 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23209
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751071AbVJSPIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:08:00 -0400
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 19 Oct 2005 17:10:26 +0200
Message-Id: <1129734626.19559.275.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 10:59 -0400, Steven Rostedt wrote:
> Hi Thomas,
> 
> I switched my custom kernel timer to use the ktimers with the prio of -1
> as you mentioned to me offline.  I set up the timer to be monotonic and
> have a requirement that the returned time is always greater or equal to
> the last time returned from do_get_ktime_mono.
> 
> Now here's the results that I got between two calls of do_get_ktime_mono
> 
> 358.069795728 secs then later 355.981483177.  Should this ever happen?

Definitely not. monotonic time must go forwards. 

> I haven't look to see if this happens in vanilla -rt10 but I haven't
> touched your ktimer code except for my logging and the patch with the
> unlock_ktimer_base (since I was based off of -rt9)

The ktimer code itself calls the timeofday code, which provides the
monotonic clock. I have no idea what might go wrong. 

Is this reproducible ?

tglx


