Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWIVQTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWIVQTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWIVQTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:19:08 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:49655 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932173AbWIVQTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:19:06 -0400
Date: Fri, 22 Sep 2006 12:13:53 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Martin Bligh <mbligh@google.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
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
Message-ID: <20060922161353.GA1569@Krystal>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal> <20060922070714.GB4167@elte.hu> <20060922150810.GB20839@Krystal> <45140E33.9030509@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45140E33.9030509@opersys.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:05:31 up 30 days, 13:14,  4 users,  load average: 0.60, 0.44, 0.27
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Karim Yaghmour (karim@opersys.com) wrote:
> So if your proposal is to amend the markup to use the short-jmp+nops
> at every marker site instead of my earlier suggestion for the bprobes
> thing, I'm all with you.
> 

First of all, I think that specific architecture-specific optimisations can and
should be integrated in a more generic portable framework.

Hrm, your comment makes me think of an interesting idea :

.align
jump_address:
  near jump to end
setup_stack_address:
  setup stack
  call empty function
end:

So, instead of putting nops in the target area, we fill it with a useful
function call. Near jump being 2 bytes, it might be much easier to modify.
If necessary, making sure the instruction is aligned would help to change it
atomically. If we mark the jump address, the setup stack address and the end
tag address with symbols, we can easily calculate (portably) the offset of the
near jump to activate either the setup_stack_address or end tags.

Mathieu



OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
