Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWIOTyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWIOTyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWIOTyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:54:51 -0400
Received: from tomts40.bellnexxia.net ([209.226.175.97]:30635 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751626AbWIOTyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:54:50 -0400
Date: Fri, 15 Sep 2006 15:49:37 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: "Jose R. Santos" <jrs@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915194937.GA7133@Krystal>
References: <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com> <1158320406.29932.16.camel@localhost.localdomain> <Pine.LNX.4.64.0609151339190.6761@scrub.home> <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <450AEC92.7090409@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <450AEC92.7090409@us.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 15:39:11 up 23 days, 16:47,  2 users,  load average: 0.45, 1.25, 0.89
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jose R. Santos (jrs@us.ibm.com) wrote:
> Alan Cox wrote:
> 
> With several other trace tools being implemented for the kernel, there 
> is a great problem with consistencies among these tool.  It is my 
> opinion that trace are of very little use to _most_ people with out the 
> availability of post-processing tools to analyses these trace.  While I 
> wont say that we need one all powerful solution, it would be good if all 
> solutions would at least be able to talk to the same post-processing 
> facilities in user-space.  Before LTTng is even considered into the 
> kernel, there need to be discussion to determine if the trace mechanism 
> being propose is suitable for all people interested in doing trace 
> analysis.  The fact the there also exist tool like LKET and LKST seem to 
> suggest that there other things to be considered when it comes to 
> implementing a trace mechanism that everyone would be happy with.
> 
> It would also be useful for all the trace tool to implement the same 
> probe points so that post-processing tools can be interchanged between 
> the various trace implementations.
> 
> 

Hi Jose,

I completely agree that there is a crying need for standardisation there. The
reason why I propose the LTTng infrastructure as a tracing core in the Linux
kernel is this : the fundamental problem I have found with kernel tracers so
far is that they perturb the system too much or do not offer enough fine
grained protection against reentrancy. Ingo's post about tracing statement
breaking the kernel all the time seems to me like a sufficient proof that this
is a real problem.

My goal with LTTng is to provide a reentrant data serialisation mechanism that
can be called from anywhere in the kernel (ok, the vmalloc path of the page
fault handler is _the_ exception) that does not use any lock and can therefore
trace code paths like NMI handlers.

I also implemented code that would serialize any type of data structure I could
think of. If it is too much, well, we can use part of it.

LTTng trace format is explained there. Your comments on it are very welcome.

http://ltt.polymtl.ca/ > LTTV and LTTng developer documentation > format.html
(http://ltt.polymtl.ca/svn/ltt/branches/poly/doc/developer/format.html)

Regards,

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
