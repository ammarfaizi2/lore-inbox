Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWINSCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWINSCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWINSCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:02:09 -0400
Received: from opersys.com ([64.40.108.71]:36879 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1750785AbWINSCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:02:06 -0400
Message-ID: <45099B7E.3040505@opersys.com>
Date: Thu, 14 Sep 2006 14:12:14 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu>
In-Reply-To: <20060914171320.GB1105@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> also, the other disadvantages i listed very much count too. Static 
> tracepoints are fundamentally limited because:
> 
>   - they can only be added at the source code level

Non-issue. See below. This is actually a feature, as can be seen
by browsing the source code of various subsystems/filesystems/etc.
who's authors saw fit to include their own static tracepoints.
Darn, they must've been all misguided, so too were those who
reviewed the code and let it in.

>   - modifying them requires a reboot which is not practical in a
>     production environment

Non-issue. See below.

>   - there can only be a limited set of them, while many problems need
>     finegrained tracepoints tailored to the problem at hand

Non-issue. See below.

>   - conditional tracepoints are typically either nonexistent or very
>     limited.

I don't get this one. What's a "conditional tracepoint" for you?

> for me these are all _independent_ grounds for rejection, as a generic 
> kernel infrastructure.

I've addressed other issues in another posting, but I want to
reiterate something here that Roman said that keeps getting
forgotten:

There is no competition between static and dynamic trace points.
They are both useful and complementary. If some set of existing
static trace points are insufficient at runtime for you to
resolve an issue, nothing precludes you from using the dynamic
mechanisms for adding more localized instrumentation.

Side point: you may be a kernel god, but there are mere mortals
out there who use Linux. The point I've been making for years
now is that there are legitimate reasons why normal non-kernel-
developer users who would benefit greatly from being able to
have access to tools that generate digested information
regarding key kernel events. You can argue all you want about
maintainability, and I continue to think you're wrong, but
you should know that the development and usefulness of any such
tools is gated by the continued inability to have a standard
set of known-to-be-good source of key kernel events. And I
repeat, the use of dynamic tracing does *not* solve this
issue.

At OLS2005 I had suggested a development of a markers infrastructure
who's users could use just to mark-up their code, the decision
for tying such markers to a given type of instrumentation not
actually being tied to the markers themselves. At OLS this
year a very good talk was given on this topic by Frank from the
systemtap team and it was very well received by the jam-packed
audience. IOW, while there used to be a time when people pitted
static instrumentation against dynamic instrumentation, there's
been an ever growing consensus that no such choice need be made.

Thanks,

Karim
