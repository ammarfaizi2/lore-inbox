Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWIZS5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWIZS5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 14:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWIZS5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 14:57:50 -0400
Received: from gw.goop.org ([64.81.55.164]:46772 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932406AbWIZS5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 14:57:49 -0400
Message-ID: <4519781D.9040503@goop.org>
Date: Tue, 26 Sep 2006 11:57:33 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
References: <20060925233349.GA2352@Krystal> <20060925235617.GA3147@Krystal> <45187146.8040302@goop.org> <20060926002551.GA18276@Krystal> <20060926004535.GA2978@Krystal> <45187C0E.1080601@goop.org> <20060926025924.GA27366@Krystal> <4518B4A0.6070509@goop.org> <20060926180414.GA10497@Krystal>
In-Reply-To: <20060926180414.GA10497@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> Hi,
>
> Ok, so as far as I can see, we can only control the execution flow by modifying
> values in the output list of the asm.
>
> Do you think the following would work ?
>
>
> #define MARK_JUMP(name, format, args...) \
>         do { \
>                 char condition; \
>                 asm volatile(   ".section .markers, \"a\";\n\t" \
>                                         ".long 0f;\n\t" \
>                                         ".previous;\n\t" \
>                                         "0:\n\t" \
>                                         "movb $0,%1;\n\t" \
>                                 : "+m" (__marker_sequencer), \
>                                 "=r" (condition) : ); \
>                 if(unlikely(condition)) { \
>                         MARK_CALL(name, format, ## args); \
>                 } \
>         } while(0)
>   

Yep, that looks reasonable.  Though you could just directly test a 
per-marker enable flag, rather than using "condition"...

    J
