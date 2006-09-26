Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWIZWLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWIZWLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWIZWLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:11:23 -0400
Received: from gw.goop.org ([64.81.55.164]:20925 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932440AbWIZWLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:11:22 -0400
Message-ID: <4519A58A.7070302@goop.org>
Date: Tue, 26 Sep 2006 15:11:22 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.14 for 2.6.17
References: <20060926220604.GA30396@Krystal>
In-Reply-To: <20060926220604.GA30396@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> Hi,
>
> Constructing on Jeremy Fitzhardinge's comments about gcc optimizations, I
> rewrote (once more) the markers mechanism so that the optimized mode does not
> jump between two different inline asm. Instead, the optimized version uses a
> load immediate (in assembly) that will be used by a test to decide of a branch
> (in C).
>   

I should have spelled out my point a bit more.  If you've got a flag 
you're just testing, couldn't you just do:

	if (__mark_enabled_##name)
		(*__mark_func)(...);

and do without the asms or the section?

The section will still be useful for simply labelling the mark sites, 
but if you want to call something there, you don't need it.

    J
