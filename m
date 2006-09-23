Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWIWPuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWIWPuM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWIWPuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:50:12 -0400
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:27272 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751225AbWIWPuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:50:10 -0400
Date: Sat, 23 Sep 2006 11:50:06 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Theodore Tso <tytso@mit.edu>, Nicholas Miell <nmiell@comcast.net>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: LTTng and SystemTAP (Everyone who is scared to read this huge thread, skip to here)
Message-ID: <20060923155006.GA27012@Krystal>
References: <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com> <20060918005624.GA30835@elte.hu> <450DFFC8.5080005@opersys.com> <20060918033027.GB11894@elte.hu> <20060918035216.GF9049@thunk.org> <450E1F6F.7040401@opersys.com> <20060918043248.GB19843@elte.hu> <20060918050310.GC15930@Krystal> <20060918151059.GA10106@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060918151059.GA10106@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:47:30 up 31 days, 12:56,  3 users,  load average: 0.89, 0.51, 0.29
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > > Some of the extensive hooking you do in LTT could be aleviated to a 
> > > great degree if you used dynamic probes. For example the syscall 
> > > entry hackery in LTT looks truly scary.
> > 
> > Yes, agreed. The last time I checked, I thought about moving this 
> > tracing code to the syscall_trace_entry/exit (used for security hooks 
> > and ptrace if I remember well). I just didn't have the time to do it 
> > yet.
> 
> correct, that's where all such things (auditing, seccomp, ptrace, 
> sigstop, freezing, etc.) hook into. Much (all?) of the current entry.S 
> hacks can go away in favor of a much easier .c patch to 
> do_syscall_trace() and this would reduce a significantion portion of the 
> present intrusiveness of LTTng.
> 

Hi Ingo,

The only problem with do_syscall_trace is that it is only called at the
beginning of the system call. LTT also needs a marker at the end of the system
call to know when the control went back to user space.

Any idea of a nice location (in C code preferably) for such a marker ?

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
