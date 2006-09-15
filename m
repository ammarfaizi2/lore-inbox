Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWIOOrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWIOOrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWIOOrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:47:12 -0400
Received: from dvhart.com ([64.146.134.43]:52706 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751539AbWIOOrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:47:11 -0400
Message-ID: <450ABCBB.4090001@mbligh.org>
Date: Fri, 15 Sep 2006 07:46:19 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
Cc: Karim Yaghmour <karim@opersys.com>, Jes Sorensen <jes@sgi.com>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp>
In-Reply-To: <20060915142836.GA9288@localhost.usen.ad.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which brings back the point of static tracepoints being entirely
> subjective. By this line of reasoning, you define for other people what
> the useful tracepoints are, and couldn't care less which points they're
> actually interested in. How exactly is this serving the need of people
> looking for instrumentation, rather than a pre-canned view of what they
> can trace? If they already have to go with their own tracepoints for the
> things they're interested in, then having a few static points
> pre-existing doesn't really buy anyone much else either, especially if
> by your own admission you're not integrating the points that people
> _are_ interested in.

They're not *entirely* subjective, though I agree some are. I find the
fact that Andrew Morton, myself, and apparently several other people 
have all instrumented the memory reclaim code to tell you *why* it's
failing to reclaim pages at various points in time slightly amusing,
but also rather depressing. It's all rather a waste of effort.

Moreover, subsystem experts know what needs to be traced in order to
give useful information, and the users may not. It's a damned sight
easier for them to say "oh, please turn on tracing for VM events
and send me the output" than custom-construct a set of probes for
that user, and send them off. There's a barrier to entry that just
won't happen there.

Hell, look at all the debug printks in the kernel for example, and
the various small add-hoc tracing facilities. If all we do is unite
those, it'll still be a step forwards.

> I'm not indicating that you didn't do exactly what you should have in
> this situation, only that static tracepoints in general are only going
> to be a small part of the picture, and not a complete solution to most
> people on their own. Dynamic instrumentation fills the same sort of gap
> without worrying about arbitrary maintenance, so what exactly does
> shoving static instrumentation in to the kernel buy us?

Dynamic probes do NOT reduce maintenance, they increase it. They just
push it into somebody else's lap, where it's done more inefficiently.
That's not a solution. The question is what's add-hoc debug for a
particular problem vs. what's generically useful. I refuse to believe
that the subsystem maintainers are too stupid to be able to make that
judgement call.

M.

