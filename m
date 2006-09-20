Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751924AbWITRMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbWITRMB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWITRMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:12:01 -0400
Received: from opersys.com ([64.40.108.71]:18194 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751924AbWITRMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:12:00 -0400
Message-ID: <451178B0.9030205@opersys.com>
Date: Wed, 20 Sep 2006 13:21:52 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
CC: Martin Bligh <mbligh@google.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
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
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com> <451141B1.40803@hitachi.com>
In-Reply-To: <451141B1.40803@hitachi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Masami Hiramatsu wrote:
> This method is very similar to the djprobe.
> And I had gotten the same idea to support preemptive kernel.
...
> This means the below code, doesn't this?
> ---
> 	jmp 1f /* short jump consumes 2 bytes */
> 	nop
> 	nop
> 	nop
> 1:

Actually this is slightly different (and requires more support
on behalf of the underlying mechanism then what I was suggesting.)
Basically, as was discussed elsewhere, there is some complex
mechanisms required for taking care of the case where you got
an interrupt at, say, the second or third nop. With the
mechanism I'm suggesting (replacing a 5 byte jmp with a 5 byte
jmp), the underlying mechanics do not require having to take
care of the above-mentioned case.

>      - Serialize all processor's cache by using IPI and cpuid.

Yes.

> I think the djprobe can provide most of functionalities which
> your idea requires.
> I'll update the djprobe against for 2.6.17 or later as soon as
> possible. Would you try to use it?

Basically I'm trying to come up with a mechanism that will be
relatively trivial to implement on any architecture. My
understanding is that kprobes/djprobes combo do not necessarily
fit this description. Of course, that's not a justification for
not trying to get it to work, but my understanding is that
Martin's proposal, if it were implemented, would have a number
of advantages over just having kprobes/djprobes.

Though, in fact, djprobes can be used on the x86 (since it
already works on that) for doing exactly what I'm looking
for: replacing a 5 byte jmp with a 5 byte jmp. My understanding
is that djprobes doesn't need any special intelligence (even
on preemptable kernels) here since it shouldn't need to worry
about an IP back anywhere inside a series of nops. IOW, we
should be able to do what Martin suggests fairly easily (if
we agree on a 5-byte "null" jump at the entry of functions
of interest). Right?

Karim
