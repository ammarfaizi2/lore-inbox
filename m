Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWIUVsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWIUVsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWIUVsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:48:05 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:61630 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750938AbWIUVsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:48:02 -0400
Date: Thu, 21 Sep 2006 17:42:48 -0400
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
Message-ID: <20060921214248.GA10097@Krystal>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060921160656.GA24774@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 17:19:13 up 29 days, 18:27,  2 users,  load average: 1.04, 0.41, 0.25
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
 
>   "As an example, LTTng traces the page fault handler, when kprobes just
>    can't instrument it."
> 
> but tracing a raw pagefault at the arch level is a bad idea anyway, we 
> want to trace __handle_mm_fault(). That way you can avoid having to 
> modify every architecture's pagefault handler ...
> 

Then you lose the ability to trace in-kernel minor page faults.

> but the other points remained unanswered as far as i can see.
>

Hi Ingo,

I clearly expressed my position in the previous emails, so did you. You argued
about a use of tracing that is not relevant to my vision of reality, which is :

- Embedded systems developers won't want a breakpoint-based probe
- High performance computing users won't want a breakpoint-based probe
- djprobe is far away from being in an acceptable state on architectures with
  very inconvenient erratas (x86).
- kprobe and djprobe cannot access local variables in every cases

For those reasons, I prefer a jump-over-call approach which lets gcc give us the
local variables. No need of DWARF or SystemTAP macro Kung Fu. Just C and a
loadable module.

By no means is it a replacement for a completely dynamic breakpoint-based
instrumentation mechanism. I really think that both mechanism should coexist.

This is my position : I let the distribution/user decide what is appropriate for
their use. My goal is to provide them a flexible mechanism that takes the
multiple variety of uses in account without performance impact if they are not
willing to pay it to benefit from tracing.

With all due respect, yes, there are Linux users different from the typical
Redhat client. If your vision is still limited to this scope after a 500
emails debate, I am afraid that there is very little I can do about it in
one more.


Mathieu

 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
