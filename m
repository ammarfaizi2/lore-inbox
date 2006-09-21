Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWIUGyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWIUGyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 02:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWIUGyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 02:54:40 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:15577 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750734AbWIUGyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 02:54:39 -0400
In-Reply-To: <20060920234517.GA29171@Krystal>
Subject: Re: [PATCH] Linux Markers 0.4 (+dynamic probe loader) for 2.6.17
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, Jes Sorensen <jes@sgi.com>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ltt-dev@shafik.org,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Martin Bligh <mbligh@google.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Ingo Molnar <mingo@elte.hu>, prasanna@in.ibm.com,
       systemtap@sources.redhat.com, systemtap-owner@sourceware.org,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       Tom Zanussi <zanussi@us.ibm.com>
X-Mailer: Lotus Notes Release 7.0.1 July 07, 2006
Message-ID: <OF276694B4.83880CF1-ON802571F0.0024CDAB-802571F0.0025F34C@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Thu, 21 Sep 2006 07:54:31 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 21/09/2006 07:56:50
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthieu, are you aware of the work done on generalized RAS hooks for
linux? It was used in dprpbes, LTT and LKST at one time. That in its own
way dealt with some of the issues  you're trying to solve. I'm not saying
it's the correct solution, but it shares a lot of common ground. Check out
"kernel hooks" aka ghki. We used it to dynamically remove dprobes from the
pagefault code path when no user probes were active. It was also used to
instrument tracepoints for different facilities that needed to share
instrumentation point. There was also a /proc interface that showed which
hooks were installed and their status. We have generic mechanisms that
would work across most architectures and optimized ones for specific
architectures.  One thing we tried to do was to make sure that affect on
data cache was minimized or eliminated. We achieved that on IA32 by making
the hook mechanism a test following a load of a literal into a register.
The hook was activated and deactivated by moving 1 or 0 into a register -
i.e. by editing the literal in the instruction. (changing mov eax,0 to mov
eax,1)

You might as well see whether there are any bone on that carcass worth
picking.

Richard

