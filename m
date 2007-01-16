Return-Path: <linux-kernel-owner+w=401wt.eu-S1750886AbXAPSqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbXAPSqj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbXAPSqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:46:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59606 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbXAPSqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:46:38 -0500
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Richard J Moore <richardj_moore@uk.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Christoph Hellwig <hch@infradead.org>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Ingo Molnar <mingo@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4 update] Linux Kernel Markers - i386 : pIII erratum 49 : XMC
References: <20070113054534.GA27017@Krystal> <20070116174158.GA16084@Krystal>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 16 Jan 2007 13:35:21 -0500
In-Reply-To: <20070116174158.GA16084@Krystal>
Message-ID: <y0mzm8izuom.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <compudj@krystal.dyndns.org> writes:

> [...]
> It would be nice to push the study of the kprobes debug trap handler so it can
> become possible to use it to put breakpoints in trap handlers. For now, kprobes
> refuses to insert breakpoints in __kprobes marked functions. However, as we
> instrument specific spots of the functions (not necessarily the function entry),
> it is sometimes correct to use kprobes on a marker within the function even if 
> it is not correct to use it in the prologue. [...]

It may help to note that the issue with __kprobes attributes is
separate from putting probes in the prologue vs. elsewhere.  The
__kprobes functions are so marked because they can cause infinite
regress if probed.  Examples are fault handlers that would service
vmalloc-related faults, and some other functions unavoidably callable
from early probe handling context.  Over time, the list has shrunk.

Indeed, __kprobes marking is a conservative measure, in that there may
be spots in such functions that are immune from recursion hazards.
But so far, we haven't encountered enough examples of this to warrant
refining this blacklist somehow.

- FChE
