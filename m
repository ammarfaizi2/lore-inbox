Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269498AbUINRxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269498AbUINRxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269500AbUINRtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:49:53 -0400
Received: from holomorphy.com ([207.189.100.168]:19605 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269461AbUINRnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:43:47 -0400
Date: Tue, 14 Sep 2004 10:43:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914174325.GX9106@holomorphy.com>
References: <1094942212.1174.20.camel@cube> <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914171525.GA14031@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914171525.GA14031@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 09:37:12 -0700, William Lee Irwin III wrote:
>> Not particularly. It largely means poorly-coded apps may report gibberish.

On Tue, Sep 14, 2004 at 07:15:25PM +0200, Roger Luethi wrote:
> If we are still talking about the same thing here, gibberish is a rather
> strong word. In the design I proposed access control affects the subset
> of tasks returned as a result -- the tool would still display meaningful
> information for the tasks it got replies for.

That sounds bizarre. I'd expect some kind of reply, even if merely an
error. I suppose "no reply" could be interpreted as "ESRCH", though
this means distinguishing between "some field caused an error" and
"the thing is dead" means the app has to fall back to requesting fields
one at a time.


On Tue, Sep 14, 2004 at 07:15:25PM +0200, Roger Luethi wrote:
> Anyway, if the access restrictions are hard-coded into the field ID,
> then it's only the credentials that can change, and I can't see a race
> there at the moment.

The race is in the app, not the kernel, so there's nothing to fix in
the kernel apart from distinctions between ESRCH and EPERM in error
reporting (otherwise the app is helpless to resolve the ambiguity).


On Tue, 14 Sep 2004 09:37:12 -0700, William Lee Irwin III wrote:
>> That's fine. Do these error messages specify which field access(es)
>> caused the error?

On Tue, Sep 14, 2004 at 07:15:25PM +0200, Roger Luethi wrote:
> They don't, because the access control I had in my dev tree silently
> skipped tasks containing fields the process had no permission to read.
> IOW, access control works as an implicit task selector. And security
> wise that's clean because the kernel does not reveal any information
> about other processes to the querying task (not even evidence of their
> existence).

If all errors are handled with "no reply", userspace loses some
efficiency, as it's forced to retry field accesses one at a time and
wait for timeouts on each of them for a dead/inaccessible task.


On Tue, 14 Sep 2004 09:37:12 -0700, William Lee Irwin III wrote:
>> Then assuming the error messages indicate which field access(es) caused
>> the error(s), you're already done; userspace must merely retry the
>> request with the offending fields cast out. Otherwise, you're still
>> done: userspace can merely retry the field accesses one at a time
>> (though it's nicer to say which ones caused the errors).

On Tue, Sep 14, 2004 at 07:15:25PM +0200, Roger Luethi wrote:
> Agreed on every point.
> The question I am pondering is: Does nproc need access control right now?
> It's more work in kernel and user space and adds new opportunities to
> introduce bugs. The merits seem rather dubious right now, considering
> that all the fields used by current process info tools (files
> /proc/pid{cmdline, stat, statm, status, wchan}) are world readable.
> So my preference is to wait with access control until we know where
> and how it is necessary.

This I can't answer.


-- wli
