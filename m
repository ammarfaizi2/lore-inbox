Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVCIXQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVCIXQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVCIXPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:15:18 -0500
Received: from one.firstfloor.org ([213.235.205.2]:41639 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262516AbVCIXB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:01:27 -0500
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Page Fault Scalability patch V19 [1/4]: pte_cmpxchg and
 CONFIG_ATOMIC_TABLE_OPS
References: <20050309201324.29721.28956.sendpatchset@schroedinger.engr.sgi.com>
	<20050309201329.29721.1860.sendpatchset@schroedinger.engr.sgi.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 10 Mar 2005 00:01:22 +0100
In-Reply-To: <20050309201329.29721.1860.sendpatchset@schroedinger.engr.sgi.com> (Christoph
 Lameter's message of "Wed, 9 Mar 2005 12:13:29 -0800 (PST)")
Message-ID: <m1y8cwv2yl.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> writes:
>
> Atomic operations may be enabled in the kernel configuration on
> i386, ia64 and x86_64 if a suitable CPU is configured in SMP mode.
> Generic atomic definitions for ptep_xchg and ptep_cmpxchg
> have been provided based on the existing xchg() and cmpxchg() functions
> that already work atomically on many platforms. It is very

I'm curious - do you have any micro benchmarks on i386 or x86-64 systems
about the difference between spin_lock(ptl) access; spin_unlock(ptl);
and cmpxchg ? 

cmpxchg can be quite slow, with bad luck it could be slower than 
the spinlocks.

A P4 would be good to benchmark this because it seems to be the worst
case.

-Andi
