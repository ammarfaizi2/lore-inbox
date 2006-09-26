Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWIZTOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWIZTOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWIZTON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:14:13 -0400
Received: from tomts36.bellnexxia.net ([209.226.175.93]:8606 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932478AbWIZTON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:14:13 -0400
Date: Tue, 26 Sep 2006 15:08:49 -0400
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
Subject: Re: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
Message-ID: <20060926190849.GA2280@Krystal>
References: <20060925233349.GA2352@Krystal> <20060925235617.GA3147@Krystal> <45187146.8040302@goop.org> <20060926002551.GA18276@Krystal> <20060926004535.GA2978@Krystal> <45187C0E.1080601@goop.org> <20060926025924.GA27366@Krystal> <4518B4A0.6070509@goop.org> <20060926180414.GA10497@Krystal> <4519781D.9040503@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <4519781D.9040503@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 15:05:00 up 34 days, 16:13,  4 users,  load average: 0.31, 0.15, 0.13
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >Hi,
> >
> >Ok, so as far as I can see, we can only control the execution flow by 
> >modifying
> >values in the output list of the asm.
> >
> >Do you think the following would work ?
> >
> >
> >#define MARK_JUMP(name, format, args...) \
> >        do { \
> >                char condition; \
> >                asm volatile(   ".section .markers, \"a\";\n\t" \
> >                                        ".long 0f;\n\t" \
> >                                        ".previous;\n\t" \
> >                                        "0:\n\t" \
> >                                        "movb $0,%1;\n\t" \
> >                                : "+m" (__marker_sequencer), \
> >                                "=r" (condition) : ); \
> >                if(unlikely(condition)) { \
> >                        MARK_CALL(name, format, ## args); \
> >                } \
> >        } while(0)
> >  
> 
> Yep, that looks reasonable.  Though you could just directly test a 
> per-marker enable flag, rather than using "condition"...
> 

The goal of the local variable "condition" here is that it will be forced to be
a register (=r in asm output), so there is no memory load involved (immediate
value).

I am not sure I understand your suggestion correctly.. do you mean having
a per-marker flag that would be loaded and tested at every marker site ?


Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
