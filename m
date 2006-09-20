Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWITSkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWITSkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWITSkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:40:09 -0400
Received: from opersys.com ([64.40.108.71]:24836 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932236AbWITSkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:40:07 -0400
Message-ID: <45118D63.8070604@opersys.com>
Date: Wed, 20 Sep 2006 14:50:11 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com> <451141B1.40803@hitachi.com> <451178B0.9030205@opersys.com> <20060920180808.GI18646@redhat.com> <451186F2.3060702@google.com>
In-Reply-To: <451186F2.3060702@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Bligh wrote:
> It's looking to me like it might still need djprobes to implement, in
> order to get the atomic and safe switchover from the original function
> into the traced one. All rather sad, but seems to be true from all the
> CPU errata, etc. If anyone can see a way round that, I'd love to hear
> it.

But we don't need to fight the errata, there are fortunately solutions
that take care of it where it does exist (x86: djprobes/kprobes.)
What's more interesting, though, is that the method as it is proposed
at this stage *seems* to be easily portable to other archs. And where
such binary trickery is difficult to pull off, nothing precludes
having a universally "portable" mechanism including something akin to
switching between instrumented vs. normal function at function entry.
Even such conditional ifs can be optimized by the CPU nowadays.

The picture is, nevertheless, very bright at the moment (I think).
Just have a 5byte filler at function entry such as Hiramatsu-san
suggested, and use djprobes to fork to instrumented function. The
unconditional jump in the filler will most likely be utterly
unmeasurable, and benchmarks should confirm this.

So:
On x86: use 5byte filler and djprobes.
On "sane" archs: use filler and override as explained earlier.
Elsewhere: use standard "if" or function pointer at function entry.

> What it would give you above and beyond djprobes is an easier and more
> flexible way to actually do the instrumentation itself.

Absolutely agree.

Karim

