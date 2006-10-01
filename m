Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWJADmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWJADmT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 23:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbWJADmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 23:42:19 -0400
Received: from tomts40-srv.bellnexxia.net ([209.226.175.97]:18650 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751818AbWJADmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 23:42:18 -0400
Date: Sat, 30 Sep 2006 23:42:12 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Nicholas Miell <nmiell@comcast.net>
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Karim Yaghmour <karim@opersys.com>, Pavel Machek <pavel@suse.cz>,
       Joe Perches <joe@perches.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: Performance analysis of Linux Kernel Markers 0.20 for 2.6.17
Message-ID: <20061001034212.GB13527@Krystal>
References: <20060930180157.GA25761@Krystal> <1159642933.2355.1.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1159642933.2355.1.camel@entropy>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 23:31:55 up 39 days, 40 min,  1 user,  load average: 0.24, 0.21, 0.20
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nicholas Miell (nmiell@comcast.net) wrote:
> On Sat, 2006-09-30 at 14:01 -0400, Mathieu Desnoyers wrote:
> > Hi,
> > 
> > Following the huge discussion thread about tracing/static vs dynamic
> > instrumentation/markers, a consensus seems to emerge about the need for a
> > marker system in the Linux kernel. The main issues this mechanism addresses are:
> > 
> > - Identify code important to runtime data collection/analysis tools in tree so
> >   that it follows the code changes naturally.
> > - Be visually appealing to kernel developers.
> > - Have a very low impact on the system performance.
> > - Integrate in the standard kernel infrastructure : use C and loadable modules.
> > 
> > The time has come for some performance measurements of the Linux Kernel Markers,
> > which follows. I attach a PDF with tables and charts which condense these
> > results.
> 
> Has anyone done any performance measurements with the "regular function
> call replaced by a NOP" type of marker?
> 

Here it is (on the same setup as the other tests : Pentium 4, 3 GHz) :

* Execute an empty loop

- Without marker
NR_LOOPS : 10000000
time delta (cycles): 15026497
cycles per loop : 1.50

- With 5 NOPs
NR_LOOPS : 100000
time delta (cycles): 300157
cycles per loop : 3.00
added cycles per loop for nops : 3.00-1.50 = 1.50


* Execute a loop of memcpy 4096 bytes

- Without marker
NR_LOOPS : 10000
time delta (cycles): 12981555
cycles per loop : 1298.16

- With 5 NOPs
NR_LOOPS : 10000
time delta (cycles): 12983925
cycles per loop : 1298.39
added cycles per loop for nops : 0.23


If we compare this approach to the jump-over-call markers (in cycles per loop) :

              NOPs    Jump over call generic    Jump over call optimized
empty loop    1.50    1.17                      2.50 
memcpy        0.23    2.12                      0.07



Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
