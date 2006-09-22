Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWIVRRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWIVRRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWIVRRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:17:07 -0400
Received: from tomts40-srv.bellnexxia.net ([209.226.175.97]:48352 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S964791AbWIVRRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:17:04 -0400
Date: Fri, 22 Sep 2006 13:11:56 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe management)
Message-ID: <20060922171156.GA18363@Krystal>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal> <20060922064955.GA4167@elte.hu> <20060922140329.GA20839@Krystal> <20060922165352.GA16476@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060922165352.GA16476@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:09:28 up 30 days, 14:18,  4 users,  load average: 0.01, 0.10, 0.13
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:
> 
> > > > Then you lose the ability to trace in-kernel minor page faults.
> > > 
> > > that's wrong, minor pagefaults go through __handle_mm_fault() just as 
> > > much.
> > > 
> > 
> > Hi Ingo,
> > 
> > On a 2.6.17 kernel tree :
> 
> > It seems like a shortcut path that will never call __handle_mm_fault. 
> > This path is precisely used to handle vmalloc faults.
> 
> yes, but you said "minor fault", not "vmalloc fault".
> 
> minor faults are the things that happen when a task does read-after-COW 
> or read-mmap-ed-pagecache-page, and they very much go through 
> __handle_mm_fault().
> 
> vmalloc faults are extremely rare, x86-specific and they are a pure 
> kernel-internal matter. (I'd never want to trace them, especially if it 
> pushes tracepoints into every architecture's page fault handler. I 
> implemented the initial version of them IIRC, but my memory fails 
> precisely why. I think it was 4:4 related, but i'm unsure.)
> 
> (i now realize that above you said "in-kernel minor faults" - under that 
> you meant vmalloc faults?)
> 

Yes, sorry, my mistake. This kind of fault is not as infrequent as you may
think, as every newly allocated vmalloc region will cause vmalloc faults on
every processes on the system that are trying to access them. I agree that
it should not be a standard event people would be interested in.

Regards,

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
