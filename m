Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbTJJS1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTJJS1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:27:12 -0400
Received: from holomorphy.com ([66.224.33.161]:13698 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263117AbTJJS1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:27:10 -0400
Date: Fri, 10 Oct 2003 11:29:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Tim Hockin <thockin@hockin.org>
Cc: G?bor L?n?rt <lgb@lgb.hu>,
       Stuart Longland <stuartl@longlandclan.hopto.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031010182909.GG727@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tim Hockin <thockin@hockin.org>, G?bor L?n?rt <lgb@lgb.hu>,
	Stuart Longland <stuartl@longlandclan.hopto.org>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com> <3F86BD0E.4060607@longlandclan.hopto.org> <20031010143529.GT5112@vega.digitel2002.hu> <20031010144723.GC727@holomorphy.com> <20031010180320.GA1995@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010180320.GA1995@hockin.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 07:47:23AM -0700, William Lee Irwin III wrote:
>> You need at least enough warning to get out of critical sections (e.g.
>> holding a spinlock) and dump registers out to memory. i.e. as long as it
>> takes to schedule out whatever's currently running on the thing.

On Fri, Oct 10, 2003 at 11:03:20AM -0700, Tim Hockin wrote:
> I've got a patch against RedHat's 2.4.x kernel with some version of O(1)
> scheduler that migrates all processes off a CPU and makes it ineleigible to
> run new tasks.  When the syscall returns, it is safe to remove the CPU.
> Processes that are running or sleeping and can be migrated elsewhere are
> migrated.  Running processes that have set_cpus_allowed to ONLY the
> processor in question are marked TASK_UNRUNNABLE and moved off the runqueue.
> Sleeping processes that have set_cpus_allowed to ONLY the processor in
> question are left unmolested until they wake up, at which point they will be
> marked UNRUNNABLE.
> It was done to allow software to bring CPUs on/offline, but it should work
> for this.  IRQs not done yet, either.

I think there is some generalized cpu hotplug stuff that's gone in that
direction already, though I don't know any details. The bits about non-
cooperative offlining were very interesting to hear, though.

-- wli
