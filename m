Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWIYVWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWIYVWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWIYVWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:22:20 -0400
Received: from gw.goop.org ([64.81.55.164]:29064 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751262AbWIYVWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:22:19 -0400
Message-ID: <45184885.8020807@goop.org>
Date: Mon, 25 Sep 2006 14:22:13 -0700
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
Subject: Re: [PATCH] Linux Kernel Markers 0.11 for 2.6.17
References: <20060925151028.GA14695@Krystal> <45181CE9.1080204@goop.org> <20060925201036.GB13049@Krystal> <45183B20.2080907@goop.org> <20060925203502.GA3770@Krystal> <20060925204701.GB3770@Krystal>
In-Reply-To: <20060925204701.GB3770@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> Better idea : we could put a read/write dependency on a memory location.
>   

Yes, that works well.  And it needn't even exist:

	extern int __marker_sequencer;		/* doesn't exist, never referenced */

	asm volatile("first asm" : "+m" (__marker_sequencer));

	asm volatile("second asm" : "+m" (__marker_sequencer));

This keeps the asms ordered with respect to each other (and prevents to 
independent markers from being intermingled), but it doesn't prevent 
them from being re-ordered with respect to other code.

    J
