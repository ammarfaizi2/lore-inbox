Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWIVR3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWIVR3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWIVR3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:29:04 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:31903 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S964807AbWIVR3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:29:02 -0400
Date: Fri, 22 Sep 2006 13:28:59 -0400
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
Message-ID: <20060922172859.GA11660@Krystal>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal> <20060922064955.GA4167@elte.hu> <20060922140329.GA20839@Krystal> <20060922165352.GA16476@elte.hu> <20060922171156.GA18363@Krystal> <20060922171224.GA18964@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060922171224.GA18964@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:27:00 up 30 days, 14:35,  4 users,  load average: 0.27, 0.39, 0.26
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> > 
> > Yes, sorry, my mistake. This kind of fault is not as infrequent as you 
> > may think, as every newly allocated vmalloc region will cause vmalloc 
> > faults on every processes on the system that are trying to access 
> > them. I agree that it should not be a standard event people would be 
> > interested in.
> 
> most of the vmalloc area that is allocated on a typical system are 
> modules - and they get loaded on bootup and rarely unloaded. Even for 
> other vmalloc-ed areas like netfilter, the activation of them is during 
> bootup. So from that point on the number of vmalloc faults is quite low. 
> (zero on most systems) If you still want to trace it i'd suggest a 
> separate type of event for it.

Yes, with this typical vmalloc usage pattern in perspective, we completely
agree. We also agree on having a separate kind of event for this, as it requires
the tracer code to be vmalloc-fault-reentrant (very tricky).

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
