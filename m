Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266770AbUGLKGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266770AbUGLKGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 06:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266773AbUGLKGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 06:06:16 -0400
Received: from gate.in-addr.de ([212.8.193.158]:45748 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S266770AbUGLKGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 06:06:14 -0400
Date: Mon, 12 Jul 2004 12:05:47 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Daniel Phillips <phillips@istop.com>, sdake@mvista.com,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040712100547.GF3933@marowsky-bree.de>
References: <200407050209.29268.phillips@redhat.com> <200407101657.06314.phillips@redhat.com> <1089501890.19787.33.camel@persist.az.mvista.com> <200407111544.25590.phillips@istop.com> <20040711210624.GC3933@marowsky-bree.de> <1089615523.2806.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1089615523.2806.5.camel@laptop.fenrus.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-07-12T08:58:46,
   Arjan van de Ven <arjanv@redhat.com> said:

> Running realtime and mlocked (prealloced) is most certainly not
> sufficient for causes like this; any system call that internally
> allocates memory (even if it's just for allocating the kernel side of
> the filename you handle to open) can lead to this RT, mlocked process to
> cause VM writeout elsewhere. 

Of course; appropriate safety measures - like not doing any syscall
which could potentially block, or isolating them from the main task via
double-buffering childs - need to be done. (heartbeat does this in
fact.)

Again, if we have "many" in kernel users requiring high performance &
low-latency, running in the kernel may not be as bad, but I still don't
entirely like it.

But user-space can also manage just fine, and instead continuing the "we
need highperf, low-latency and non-blocking so it must be in the
kernel", we may want to consider how to have high-perf low-latency
kernel/user-space communication so that we can NOT move this into the
kernel.

Suffice to say that many user-space implementations exist which satisfy
these needs quite sufficiently; in the case of a CFS, this argument may
be different, but I'd like to see some hard data to back it up.

(On a practical note, a system which drops out of membership because
allocating a 256 byte buffer for a filename takes longer than the node
deadtime (due to high load) is reasonably unlikely to be a healthy
cluster member anyway and is on its road to eviction already.)

The main reason why I'd like to see cluster infrastructure in the kernel
is not technical, but because it increases the pressure on unification
so much that people might actually get their act together this time ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

