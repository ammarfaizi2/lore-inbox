Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUAUEBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUAUEBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:01:54 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52688 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261563AbUAUEBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:01:53 -0500
Date: Wed, 21 Jan 2004 09:36:33 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, Rusty Russell <rusty@au1.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040121093633.A3169@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <400CCE2F.2060502@cyberone.com.au> <20040120065207.GA10993@hockin.org> <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au> <20040120082943.GA15733@hockin.org> <400CE8DC.70307@cyberone.com.au> <20040120084352.GD15733@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040120084352.GD15733@hockin.org>; from thockin@hockin.org on Tue, Jan 20, 2004 at 12:43:52AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 12:43:52AM -0800, Tim Hockin wrote:
> IFF the app is designed to handle it.  The existence of a SIGPWR handler
> does not necessarily imply that, though.  a SIGCPU or something might
> correlate 1:1 with this, but SIGPWR doesn't.

I agree we should have a separe signal for CPU Hotplug. By default the signal 
will be ignored, unless a task registers a signal handler for that special 
signal.

That way, tasks which "knowingly" change their CPU affinity will be able to 
tackle a CPU going down by handling the signal (probably change their CPU 
affinity again), while tasks which have their CPU affinity changed "unknowingly"
(by other tasks) will just ignore the signal. The hotplug script interface
allows the admin to go and change the CPU affinity again for the second class 
of tasks, if needed.

The only problem with a new signal is conformance to standards (if any).

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
