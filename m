Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVFGJrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVFGJrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 05:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVFGJrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 05:47:47 -0400
Received: from magic.adaptec.com ([216.52.22.17]:8638 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261727AbVFGJrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 05:47:45 -0400
Date: Tue, 7 Jun 2005 15:29:23 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: Ulrich Drepper <drepper@gmail.com>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       <linux-kernel@vger.kernel.org>,
       <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: Zeroed pages returned for heap
In-Reply-To: <a36005b505060701531a545ba4@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0506071520100.4569-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Jun 2005 09:47:18.0003 (UTC) FILETIME=[E479CC30:01C56B45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2005, Ulrich Drepper wrote:

> On 6/6/05, Nagendra Singh Tomar <nagendra_tomar@adaptec.com> wrote:
> > Is it OK for an application (a C library implementing malloc/calloc is
> > also an application) to assume that the pages returned by the OS for heap
> > allocation (either directly thru brk() or thru mmap(MAP_ANONYMOUS)) will
> > be zero filled.
> 
> The malloc code is glibc is defined with the assumption that brk
> clears memory.  Since this is what the kernel implements it would be a
> horrible waste of time to reinitialize the memory.  This behavior is
> part of the kernel ABI and cannot be changed without breaking existing
> applications without producing new libc DSOs (set MORECORE_CLEARS
> appropriately) and relinking all statically linked apps.


glibc behaviour is completely justified, but when you are dealing with 
Xscale memory access limitations you wish it was not like that and just 
disabling zeroing brk/anonymous pages in kernel could get you a good bump 
in performance.
Anyway, thanx for the insight.



-- You have moved the mouse. Windows must be restarted for the 
   changes to take effect.

