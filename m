Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUATJMl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 04:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbUATJMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 04:12:41 -0500
Received: from [66.35.79.110] ([66.35.79.110]:51626 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S265271AbUATJMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 04:12:40 -0500
Date: Tue, 20 Jan 2004 01:12:20 -0800
From: Tim Hockin <thockin@hockin.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, Rusty Russell <rusty@au1.ibm.com>,
       vatsa@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040120091220.GA17690@hockin.org>
References: <20040120063316.GA9736@hockin.org> <400CCE2F.2060502@cyberone.com.au> <20040120065207.GA10993@hockin.org> <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au> <400CE9A6.90208@stesmi.com> <400CEBA9.20706@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400CEBA9.20706@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 07:49:45PM +1100, Nick Piggin wrote:
> Well I'll admit it would usually be more flexible if you freeze
> the process and run hotplug scripts to handle cpu affinity.
> 
> Unfortunately it introduces unfixable robustness and realtime
> problems by design.

And I submit that there is no clean way to handle the RT problem.  The
proposed flag gives the task a choice, which is good, but I am not sure that
the choice is worth the effort.

The robustness issues are real, but the same issue applies to all hotplug
activity.  The issues are severe corner cases which indicate OTHER faults in
the system.

My main concern is that affinity is not treated as a suggestion or
preference.  Affinity is an explicit request.  Once granted, we can not
arbitrarily decide to revoke affinity unless we have a sane way to alert
*someone*.

Freezing tasks and sending a hotplug event is a sane way.

Sending SIGPWR is a sane way IFF you can guarantee that a task which
receives SIGPWR will handle a CPU being yanked without violating affinity.
This does not handle the case of tasks which do not handle SIGPWR.

A flag to indicate 'my affinity is a preference' vs. 'my affinity is a
requirement' is a possibly sane way.  It still requires all the code to
freeze a task, and forces affinity-aware apps to adapt to this new edge
case.
