Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWIVQnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWIVQnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWIVQnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:43:12 -0400
Received: from opersys.com ([64.40.108.71]:60171 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932539AbWIVQnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:43:11 -0400
Message-ID: <45141759.8060600@opersys.com>
Date: Fri, 22 Sep 2006 13:03:21 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Ingo Molnar <mingo@elte.hu>, Martin Bligh <mbligh@google.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe
 management)
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal> <20060922070714.GB4167@elte.hu> <20060922150810.GB20839@Krystal> <45140E33.9030509@opersys.com> <20060922161353.GA1569@Krystal>
In-Reply-To: <20060922161353.GA1569@Krystal>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mathieu Desnoyers wrote:
> First of all, I think that specific architecture-specific optimisations can and
> should be integrated in a more generic portable framework.

No disagreement there. If Ingo would care to comment, I think it might
be an acceptable compromise to have x86 fully use kprobes/djprobes
immediately, and the other archs could walk there at their rate.
Practically, some stuff in include/asm-i386/markers.h and
include/asm-x86_64/markers.h would contain the binary modifiable stuff
and include/asm-generic/markers.h could contain a platform-independent
fallback.

> Hrm, your comment makes me think of an interesting idea :
> 
> .align
> jump_address:
>   near jump to end
> setup_stack_address:
>   setup stack
>   call empty function
> end:
> 
> So, instead of putting nops in the target area, we fill it with a useful
> function call. Near jump being 2 bytes, it might be much easier to modify.
> If necessary, making sure the instruction is aligned would help to change it
> atomically. If we mark the jump address, the setup stack address and the end
> tag address with symbols, we can easily calculate (portably) the offset of the
> near jump to activate either the setup_stack_address or end tags.

That's another possibility. It seems more C friendly than the simple
short-jump+3bytes.

Ingo?

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
