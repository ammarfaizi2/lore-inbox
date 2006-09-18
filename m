Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965389AbWIRFDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965389AbWIRFDN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 01:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965387AbWIRFDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 01:03:13 -0400
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:60577 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S965388AbWIRFDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 01:03:12 -0400
Date: Mon, 18 Sep 2006 01:03:10 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Karim Yaghmour <karim@opersys.com>, Theodore Tso <tytso@mit.edu>,
       Nicholas Miell <nmiell@comcast.net>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: LTTng and SystemTAP (Everyone who is scared to read this huge thread, skip to here)
Message-ID: <20060918050310.GC15930@Krystal>
References: <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com> <20060918005624.GA30835@elte.hu> <450DFFC8.5080005@opersys.com> <20060918033027.GB11894@elte.hu> <20060918035216.GF9049@thunk.org> <450E1F6F.7040401@opersys.com> <20060918043248.GB19843@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060918043248.GB19843@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 00:50:18 up 26 days,  1:59,  2 users,  load average: 0.45, 0.36, 0.29
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> so regarding the big picture we are largely on the same page in essence 
> i think - sub-issues non-withstanding :-) As long as LTT comes with a 
> facility that allows the painless moving of a static LTT markup to a 
> SystemTap script, that would come quite a bit closer to being acceptable 
> for upstream acceptance in my opinion.
> 
> The curious bit is: why doesnt LTT integrate SystemTap yet? Is it the 
> performance aspect?

Yes, for our needs, the performance impact of SystemTAP is too high. We are
totally open to integrate data coming from SystemTAP to our traces. Correct me
if I am wrong, but I think their project does an extensive use of strings in the
buffers. This is one, non compact, sub-optimal type, but it can do the job for
low rate events. I also makes classification and identification of the
information rather less straightforward. Plus, running a string format code in a
critical code path does not give the kind of performance I am looking for.

> Some of the extensive hooking you do in LTT could be 
> aleviated to a great degree if you used dynamic probes. For example the 
> syscall entry hackery in LTT looks truly scary.

Yes, agreed. The last time I checked, I thought about moving this tracing code
to the syscall_trace_entry/exit (used for security hooks and ptrace if I
remember well). I just didn't have the time to do it yet.

> I cannot understand that 
> someone who does tracing doesnt see the fundamental strength of 
> SystemTap - i think that in part must have lead to my mistake of 
> assuming that you opposed SystemTap.
> 

Can you find a way to instrument it dynamically without the breakpoint cost ?
System calls are a highly critical path both in a system and for tracing.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
