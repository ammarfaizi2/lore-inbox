Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTHaSmy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 14:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTHaSmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 14:42:54 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:39687
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261509AbTHaSmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 14:42:53 -0400
Subject: Re: [SHED] Questions.
From: Robert Love <rml@tech9.net>
To: Ian Kumlien <pomac@vapor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1062324435.9959.56.camel@big.pomac.com>
References: <1062324435.9959.56.camel@big.pomac.com>
Content-Type: text/plain
Message-Id: <1062355996.1313.4.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 14:53:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-31 at 06:07, Ian Kumlien wrote:

> Why not use small quantum values for high pri processes and long for low
> pri since the high pri processes will preempt the low pri processes
> anyways. And for a server working under load with only a few processes
> (assuming they are all low pri) would lessen the context switches.

The rationale behind giving high priority processes a large timeslice is
two-fold:

(1) if they are interactive, then they won't actually use it all (this
is the point you are making). But,

(2) Having a large timeslice ensures that they have a high probability
of having available timeslice when they _do_ need it.

So, yes, interactive processes can get by with a small timeslice,
because that is by-definition all they need.  But they do need to run
often (i.e., as I think you have mentioned in your last email,
interactive processes are "run often for short periods"), so the large
timeslice ensures that they are never expired.

A counterargument might be that the large timeslice is a detriment to
other high priority processes.  But the thinking is that, by definition,
interactive processes won't use all of the timeslice.  And thus will not
hog the CPU.  If they do, the interactivity estimator will quickly bring
them down.

That is the rationale in the current scheduler, anyhow.  Nick's current
work is interesting, and a bit different.

> And a system with "interactive load" as well would, as i said, preempt
> the lower pris. But this could also cause a problem... Imho there should
> be a "min quantum value" so that processes can't preempt a process that
> was just scheduled (i dunno if this is implemented already though). 

I don't think this is a good idea.  I see your intention, but we have
priorities for a reason.

	Robert Love


