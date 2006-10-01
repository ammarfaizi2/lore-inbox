Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752009AbWJAETs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbWJAETs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 00:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbWJAETr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 00:19:47 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:58504 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1752009AbWJAETr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 00:19:47 -0400
Subject: Re: Performance analysis of Linux Kernel Markers 0.20 for 2.6.17
From: Nicholas Miell <nmiell@comcast.net>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
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
In-Reply-To: <20061001034212.GB13527@Krystal>
References: <20060930180157.GA25761@Krystal>
	 <1159642933.2355.1.camel@entropy>  <20061001034212.GB13527@Krystal>
Content-Type: text/plain
Date: Sat, 30 Sep 2006 21:19:42 -0700
Message-Id: <1159676382.2355.13.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-30 at 23:42 -0400, Mathieu Desnoyers wrote:
> * Nicholas Miell (nmiell@comcast.net) wrote:
> > 
> > Has anyone done any performance measurements with the "regular function
> > call replaced by a NOP" type of marker?
> > 
> 
> Here it is (on the same setup as the other tests : Pentium 4, 3 GHz) :
> 
> * Execute an empty loop
> 
> - Without marker
> NR_LOOPS : 10000000
> time delta (cycles): 15026497
> cycles per loop : 1.50
> 
> - With 5 NOPs
> NR_LOOPS : 100000
> time delta (cycles): 300157
> cycles per loop : 3.00
> added cycles per loop for nops : 3.00-1.50 = 1.50
> 
> 
> * Execute a loop of memcpy 4096 bytes
> 
> - Without marker
> NR_LOOPS : 10000
> time delta (cycles): 12981555
> cycles per loop : 1298.16
> 
> - With 5 NOPs
> NR_LOOPS : 10000
> time delta (cycles): 12983925
> cycles per loop : 1298.39
> added cycles per loop for nops : 0.23
> 
> 
> If we compare this approach to the jump-over-call markers (in cycles per loop) :
> 
>               NOPs    Jump over call generic    Jump over call optimized
> empty loop    1.50    1.17                      2.50 
> memcpy        0.23    2.12                      0.07
> 
> 
> 
> Mathieu

What about with two NOPs (".byte 0x66, 0x66, 0x90, 0x66, 0x90" - this
should work with everything) or one (".byte 0x0f, 0x1f, 0x44, 0x00,
0x00" - AFAIK, this should work with P6 or newer).

(Sorry, I should have mentioned this the first time.)

-- 
Nicholas Miell <nmiell@comcast.net>

