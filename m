Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVECBbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVECBbx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 21:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVECBbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 21:31:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:54953 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261287AbVECBbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 21:31:22 -0400
Subject: Re: [PATCH] fix __mod_timer vs __run_timers deadlock.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Juergen Kreileder <jk@blackdown.de>, Andrew Morton <akpm@osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
In-Reply-To: <1115083453.27658.6.camel@mindpipe>
References: <42748B75.D6CBF829@tv-sign.ru>
	 <20050501023149.6908c573.akpm@osdl.org>  <87vf61kztb.fsf@blackdown.de>
	 <1115079230.6155.35.camel@gaston>  <1115083453.27658.6.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 03 May 2005 11:28:51 +1000
Message-Id: <1115083731.6156.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-02 at 21:24 -0400, Lee Revell wrote:
> On Tue, 2005-05-03 at 10:13 +1000, Benjamin Herrenschmidt wrote:
> > Well, there may be other issues brought by this new timer code though.
> > I'm running G5s regulary without a lockup or anything for weeks, so it
> > would be interesting if you could try to find out what's involved in
> > that other lockup you had.
> 
> It seems like it would not be to hard to create a timer test suite that
> just hammers the timer subsystem, creating and deleting and modifying
> zillions of timers, changing the system time, etc.  Combined with
> running with HZ=10000 or something it seems like you could shake out
> bugs a lot faster than just running & waiting for a race to show up.

Well, yes and know... the timer subsytem is very senstivie to things
like memory barriers issues, and thus changes in the "barrier" semantics
of a timer call may have an impact on the caller code regardless of the
validity of the timer code itself, that sort of thing ...

> I've seen timer related issues (the set_rtc_mmss issue that George
> Anzinger fixed) while testing the RT patchset that I could only ever
> reproduce once.


