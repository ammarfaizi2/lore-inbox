Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758405AbWK0Q4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405AbWK0Q4q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758404AbWK0Q4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:56:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15589 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1758403AbWK0Q4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:56:45 -0500
Date: Mon, 27 Nov 2006 16:56:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 4/16] LTTng 0.6.36 for 2.6.18 : atomic UP operations on SMP
Message-ID: <20061127165643.GD5348@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <zanussi@us.ibm.com>,
	Karim Yaghmour <karim@opersys.com>,
	Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
	Richard J Moore <richardj_moore@uk.ibm.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
	systemtap@sources.redhat.com
References: <20061124215518.GE25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124215518.GE25048@Krystal>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 04:55:18PM -0500, Mathieu Desnoyers wrote:
> This patch adds a UP flavor of SMP operations which is intended to provide
> atomic modification of per-cpu data without suffering from the LOCK of memory
> barrier performance cost. Note that extreme care must be taken when accessing
> this data from different CPUs : smp_wmb() and smp_rmb() must be used
> explicitely. As this last scenario happens very rarely in LTTng, it provides a

We already have local_t in asm/local.h for this purposed.  Unfortunately
several architecture implementations are rather suboptimal, but I'm sure
the architecture maintainers would be interested in patches to optimize
the various implementations.

