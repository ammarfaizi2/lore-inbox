Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946974AbWKKFN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946974AbWKKFN1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 00:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947091AbWKKFN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 00:13:27 -0500
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:36843 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1946974AbWKKFN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 00:13:26 -0500
Date: Sat, 11 Nov 2006 00:13:24 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, ltt-dev@shafik.org
Subject: Re: MIPS atomic operations, "sync"
Message-ID: <20061111051324.GA23930@Krystal>
References: <20061110184049.GA24977@Krystal> <20061110223303.GA17712@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061110223303.GA17712@linux-mips.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 00:11:20 up 80 days,  2:19,  2 users,  load average: 0.54, 0.41, 0.24
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Baechle (ralf@linux-mips.org) wrote:
> On Fri, Nov 10, 2006 at 01:40:49PM -0500, Mathieu Desnoyers wrote:
> 
> > I am currently creating a "LOCK" prefix free and memory barrier free version
> > of atomic.h to fulfill my tracer (LTTng) needs, which is to atomically update
> > per-cpu data and have a minimal performance loss.
> > 
> > I just came across the MIPS atomic.h and system.h implementations in 2.6.18
> > which brings a question :
> > 
> > Why are the primitives in include/asm-mips/atomic.h using the "sync"
> > instruction even in the UP case ? system.h cmpxchg only uses the sync in the
> > SMP case.
> 
> Why are the standard atomic operations insufficient for your needs?
> 
> There is an enormous amout of subtilities in those atomic ops for some
> architectures you probably do yourself a big favor by avoiding new
> variants.
> 

Performance cost.

I add a memory barrier where needed when the data needs to appear to be written
sequentially from the other CPUs perspective.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
