Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269382AbUINS5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269382AbUINS5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269439AbUINSzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:55:40 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:9913 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S269366AbUINSxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:53:49 -0400
Date: Tue, 14 Sep 2004 20:45:18 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914184517.GA2655@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
	Chris Wright <chrisw@osdl.org>
References: <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914171525.GA14031@k3.hellgate.ch> <20040914174325.GX9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914174325.GX9106@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 10:43:25 -0700, William Lee Irwin III wrote:
> On Tue, 14 Sep 2004 09:37:12 -0700, William Lee Irwin III wrote:
> >> Not particularly. It largely means poorly-coded apps may report gibberish.
> 
> On Tue, Sep 14, 2004 at 07:15:25PM +0200, Roger Luethi wrote:
> > If we are still talking about the same thing here, gibberish is a rather
> > strong word. In the design I proposed access control affects the subset
> > of tasks returned as a result -- the tool would still display meaningful
> > information for the tasks it got replies for.
> 
> That sounds bizarre. I'd expect some kind of reply, even if merely an
> error. I suppose "no reply" could be interpreted as "ESRCH", though
> this means distinguishing between "some field caused an error" and
> "the thing is dead" means the app has to fall back to requesting fields
> one at a time.

I suppose you are thinking of a request that lists a number of PIDs along
with a number of field IDs. In that case yes, I agree that it makes sense
to provide some explicit feedback to the tool once we add access control
(before that, there is no ambiguity: a missing answer means ESRCH).

The most common request, though, won't provide a list of pids, it will
only provide a list of field IDs and select all processes in the system
(NPROC_SELECT_ALL). There is no ambiguity here, either: The tool didn't
ask for any specific process to begin with, ESRCH doesn't make sense
here. And for a system that looks anything like /proc does today,
fields that are capable of triggering EPERM are few and far between,
certainly not something you are hitting unexpectedly in the fast path
of a process monitoring tool.

Thanks, by the way, for all the feedback that helped me realize that
I have so far failed to explain the design well enough. I will try to
work on that.

Roger
