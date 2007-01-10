Return-Path: <linux-kernel-owner+w=401wt.eu-S932612AbXAJBGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbXAJBGs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 20:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbXAJBGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 20:06:48 -0500
Received: from tomts10-srv.bellnexxia.net ([209.226.175.54]:44598 "EHLO
	tomts10-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932612AbXAJBGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 20:06:47 -0500
Date: Tue, 9 Jan 2007 20:06:44 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Christoph Hellwig <hch@infradead.org>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Ingo Molnar <mingo@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Ltt-dev] [PATCH] local_t : Documentation - update
Message-ID: <20070110010644.GA8558@Krystal>
References: <20061221001545.GP28643@Krystal> <20061223093358.GF3960@ucw.cz> <20070109031446.GA29426@Krystal> <20070109224100.GB6555@elf.ucw.cz> <20070109232155.GA25387@Krystal> <20070109234511.GB7798@elf.ucw.cz> <20070110003926.GA27830@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20070110003926.GA27830@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 20:02:36 up 139 days, 22:10,  5 users,  load average: 1.00, 0.99, 1.37
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca) wrote:
> > So it is "one cpu may write, other cpus may read", and as big as
> > long. Are you sure obscure architectures (sparc?) can implement this
> > in useful way? ... maybe yes, unless obscure architecture exists where
> > second other cpu can see garbage data when first cpu writes into long
> > ...?
> > 
> > 
> 
> Sparc64 uses a memory barrier around the atomic operations in the SMP case
> (see arch/sparc64/lib/atomic.S). The same is true for sparc. As I am not a sparc
> expert, I left the asm-generic default behavior, but I think it should be safe
> to implement local.S code derived from atomic.S to optimize the speed of the
> local_t operations on sparc and sparc64. Can anyone confirm this ?
> 

Sorry for the self reply.. looking at arch/sparc/lib/atomic32.c tells me that
local.h could use its own version that would only disable interrupts without
taking any hashed spinlock.

sparc64 seems to be a saner architecture providing atomic operations wrt the
local CPU. A barrier-free version of arch/sparc64/lib/atomic.S would improve
performance.

Mathieu

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
