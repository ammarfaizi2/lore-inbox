Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVESQDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVESQDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 12:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVESQDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 12:03:46 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:24213 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262542AbVESQDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 12:03:37 -0400
Subject: Re: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01
	when RT program dumps core]
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linus Torvalds <torvalds@osdl.org>, kus Kusche Klaus <kus@keba.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1116517651.21685.50.camel@mindpipe>
References: <AAD6DA242BC63C488511C611BD51F367323212@MAILIT.keba.co.at>
	 <1116503763.15866.9.camel@localhost.localdomain>
	 <1116509820.15866.28.camel@localhost.localdomain>
	 <1116517651.21685.50.camel@mindpipe>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 19 May 2005 12:03:24 -0400
Message-Id: <1116518604.27471.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 11:47 -0400, Lee Revell wrote:
> On Thu, 2005-05-19 at 09:37 -0400, Steven Rostedt wrote:
> > Now if there were no other threads to wait on it would just continue.
> > So, is there some real reason that this yield is there? Or is it just
> > trying to be nice, as in saying, "I'm dieing now and just don't want to
> > waste others time" (which I highly doubt is the case).
> 
> Why do you highly doubt this is the case?  This is actually the behavior
> I would expect.

Because yield just doesn't cut it.  Yeah, OK it stops its time slice at
that moment, but it will still come in and preempt whoever to finish the
job.  If it really wanted to do the "I'm dieing let others run" then it
should change its priority or nice value.

-- Steve


