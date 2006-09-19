Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWISQpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWISQpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWISQpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:45:30 -0400
Received: from opersys.com ([64.40.108.71]:15121 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1750880AbWISQpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:45:30 -0400
Message-ID: <45102108.1050702@opersys.com>
Date: Tue, 19 Sep 2006 12:55:36 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <45101965.3050509@opersys.com> <45101809.5030906@google.com>
In-Reply-To: <45101809.5030906@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Bligh wrote:
> That was always the intent, or codebase + flat patch if really 
> necessary. Sorry if that wasn't clear.

Actually rereading through your posts with this correction in mind
I find this to actually be one of the most interesting ideas I've
seen of late. There's probably not a 1-to-1 correlation here, but
some of the problems mentioned seem similar to RCU stuff (modify
pointer, make sure nobody's got copy to it, etc.), tough I could
be wrong.

Random thoughts -- no guarantees:

Instead of freezing everything and making sure all text refs to
function are modified, you might just be able to use kprobes (on
the architectures that have it) as a trampoline for on-the-fly
address call modifications. And on the archs that don't have
kprobes, you could at build time degrade this by replacing direct
calls to instrumented functions by function pointers or localized
ifs.

Not sure.

Karim

