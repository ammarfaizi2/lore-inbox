Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278239AbRJWUr1>; Tue, 23 Oct 2001 16:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278244AbRJWUrR>; Tue, 23 Oct 2001 16:47:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7665 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278239AbRJWUrD>; Tue, 23 Oct 2001 16:47:03 -0400
Date: Tue, 23 Oct 2001 15:46:19 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Issue with max_threads (and other resources) and highmem
Message-ID: <85870000.1003869979@baldur>
In-Reply-To: <k28ze2drfg.fsf@zero.aec.at>
In-Reply-To: <72940000.1003868385@baldur> <k28ze2drfg.fsf@zero.aec.at>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, October 23, 2001 22:36:51 +0200 Andi Kleen <ak@muc.de> wrote:

> I would just limit it to a reasonable max value; e.g. 10000
> if someone needs more than 10000 threads/processes he/she can set sysctls
> manually. The current scheduler would choke anyways if only a small
> fraction of 10000 threads are runnable.

Yes, that would solve the max_threads problem.  It should be fairly simple
to pick a reasonable number.

But my question is also about the other subsystems called from
start_kernel() that take memory size as an argument.  This includes
vfs_caches_init() which in turn calls dcache_init(), and buffer_init() and
page_cache_init().  I haven't dug down to the bottom of all these
functions, but I'm guessing they really want to base their calculations on
available normal memory and not high memory.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

