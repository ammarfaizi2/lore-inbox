Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWIYVhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWIYVhW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWIYVhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:37:22 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:19649 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751459AbWIYVhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:37:20 -0400
Date: Mon, 25 Sep 2006 17:32:07 -0400
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
Subject: Re: [PATCH] Linux Kernel Markers 0.11 for 2.6.17
Message-ID: <20060925213207.GD3770@Krystal>
References: <20060925151028.GA14695@Krystal> <45181CE9.1080204@goop.org> <20060925201036.GB13049@Krystal> <45183B20.2080907@goop.org> <20060925203502.GA3770@Krystal> <20060925204701.GB3770@Krystal> <45184885.8020807@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45184885.8020807@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 17:30:42 up 33 days, 18:39,  6 users,  load average: 0.43, 0.32, 0.27
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >Better idea : we could put a read/write dependency on a memory location.
> >  
> 
> Yes, that works well.  And it needn't even exist:
> 
> 	extern int __marker_sequencer;		/* doesn't exist, never 
> 	referenced */
> 
> 	asm volatile("first asm" : "+m" (__marker_sequencer));
> 
> 	asm volatile("second asm" : "+m" (__marker_sequencer));
> 
> This keeps the asms ordered with respect to each other (and prevents to 
> independent markers from being intermingled), but it doesn't prevent 
> them from being re-ordered with respect to other code.
> 
I will declare the pointers around the jmp instruction directly in assembly : I
wouldn't want gcc to put some other code there by mistake.

I will use the "name" variable, as it is already there.

A new version coming soon...

Thank you very much!

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
