Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWIZW2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWIZW2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWIZW2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:28:04 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:38126 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S964869AbWIZW2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:28:02 -0400
Date: Tue, 26 Sep 2006 18:27:58 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
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
Subject: Re: [PATCH] Linux Kernel Markers 0.14 for 2.6.17
Message-ID: <20060926222758.GA9668@Krystal>
References: <20060926220604.GA30396@Krystal> <4519A58A.7070302@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <4519A58A.7070302@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 18:24:09 up 34 days, 19:32,  3 users,  load average: 0.29, 0.25, 0.27
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >Hi,
> >
> >Constructing on Jeremy Fitzhardinge's comments about gcc optimizations, I
> >rewrote (once more) the markers mechanism so that the optimized mode does 
> >not
> >jump between two different inline asm. Instead, the optimized version uses 
> >a
> >load immediate (in assembly) that will be used by a test to decide of a 
> >branch
> >(in C).
> >  
> 
> I should have spelled out my point a bit more.  If you've got a flag 
> you're just testing, couldn't you just do:
> 
> 	if (__mark_enabled_##name)
> 		(*__mark_func)(...);
> 
> and do without the asms or the section?
> 

Because a supplementary memory read is added on the critical path with a normal
flag test. The assembly can provide an immediate value without any need of
memory read from the data section.

To change the behavior of the program, I just have to change the immediate value
in the movb instruction.

However, the non-optimized generic version does exactly this : it simply tests a
flag loaded from memory. It can be very useful on embedded systems where the
code is in read-only memory.

Regards,

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
