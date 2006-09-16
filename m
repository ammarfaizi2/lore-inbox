Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWIPRfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWIPRfv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 13:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWIPRfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 13:35:51 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:34251 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S964852AbWIPRfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 13:35:50 -0400
Date: Sat, 16 Sep 2006 13:30:35 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Jes Sorensen <jes@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060916173035.GA705@Krystal>
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <450BCAF1.2030205@sgi.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:28:05 up 24 days, 14:36,  2 users,  load average: 0.23, 0.21, 0.24
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jes Sorensen (jes@sgi.com) wrote:

> If you want to prove people wrong, I suggest you do some real life
> implementation and measure some real workloads with a predefined set of
> tracepoints implemented using kprobes and LTT and show us that the
> benchmark of the user application suffers in a way that can actually be
> measured. Argueing that a syscall takes an extra 50 instructions
> because it's traced using kprobes rather than LTT doesn't mean it
> actually has any real impact.
>

And about those extra cycles.. according to :
Documentation/kprobes.txt
"6. Probe Overhead

On a typical CPU in use in 2005, a kprobe hit takes 0.5 to 1.0
microseconds to process.  Specifically, a benchmark that hits the same
probepoint repeatedly, firing a simple handler each time, reports 1-2
million hits per second, depending on the architecture.  A jprobe or
return-probe hit typically takes 50-75% longer than a kprobe hit.
When you have a return probe set on a function, adding a kprobe at
the entry to that function adds essentially no overhead.

i386: Intel Pentium M, 1495 MHz, 2957.31 bogomips
k = 0.57 usec; j = 1.00; r = 0.92; kr = 0.99; jr = 1.40

x86_64: AMD Opteron 246, 1994 MHz, 3971.48 bogomips
k = 0.49 usec; j = 0.76; r = 0.80; kr = 0.82; jr = 1.07

ppc64: POWER5 (gr), 1656 MHz (SMT disabled, 1 virtual CPU per physical CPU)
k = 0.77 usec; j = 1.31; r = 1.26; kr = 1.45; jr = 1.99


So, 1 microsecond seems more like 1500-2000 cycles to me, not 50.

Mathieu




OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
