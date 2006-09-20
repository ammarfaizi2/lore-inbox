Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWITSPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWITSPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWITSPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:15:45 -0400
Received: from opersys.com ([64.40.108.71]:260 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932201AbWITSPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:15:42 -0400
Message-ID: <451187A5.4010501@opersys.com>
Date: Wed, 20 Sep 2006 14:25:41 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: "Frank Ch. Eigler" <fche@redhat.com>
CC: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Martin Bligh <mbligh@google.com>, prasanna@in.ibm.com,
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
References: <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com> <451141B1.40803@hitachi.com> <451178B0.9030205@opersys.com> <20060920180808.GI18646@redhat.com>
In-Reply-To: <20060920180808.GI18646@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Frank,

Frank Ch. Eigler wrote:
> My interpretation of Martin's Monday proposal is that, if implemented,
> we wouldn't need any of this nop/int3 stuff.  If function being
> instrumented were recompiled on-the-fly, then it could sport plain &
> direct C-level calls to the instrumentation handlers.

Absolutely. I guess the length of these threads is just fertile
ground for misunderstandings. Basically what Hiramatsu-san and
myself were discussing was just the mechanism for selecting/
forking in between the uninstrumented function and the instrumented
one.

So, to recap:

If you had 100,000 instrumentation points in the scheduler (obviously
a totally bogus number here ...) you'd have 2 functions:
1- one with no instrumentation at all, but with a 5byte filler such
   as the one presented by Hiramatsu-san.
2- one with the instrumentation.

Early in the proposal, the mechanics of switching in between "1" and "2"
seemed to be problematic, but I think with Hiramatsu-san's proposal
and, on the x86, djprobes, we've got it figured out.

Let me know if I'm not providing enough detail.

Thanks,

Karim

