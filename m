Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269581AbUJLJqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269581AbUJLJqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269593AbUJLJqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:46:45 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:30734 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S269591AbUJLJom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:44:42 -0400
Date: Tue, 12 Oct 2004 11:44:39 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3
Message-ID: <20041012094439.GA3223@pclin040.win.tue.nl>
References: <41672D4A.4090200@nortelnetworks.com> <1097503078.31290.23.camel@localhost.localdomain> <416B6594.5080002@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416B6594.5080002@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 11:03:16PM -0600, Chris Friesen wrote:

> Alan Cox wrote:
> >The OOM killer is a heuristic. 
> 
> Sure, but presumably it's a bad thing for a user with no priorities to be 
> able to lock up a machine by running two tasks?  I'm not complaining that 
> its killing the wrong thing, I'm complaining that the machine locked up.
> 
> > Switch the machine to strict accounting
> >and it'll kill or block memory access correctly.
> 
> I must be able to run an app that uses over 90% of system memory, and calls 
> fork().  I was under the impression this made strict accounting unfeasable?
> 
> Chris

No.

The default allows a job to take ten times what is available,
and bad things happen later.
With overcommit mode 2 there is an upper bound, but you can
twiddle the bound as desired. From proc(5):

    /proc/sys/vm/overcommit_memory
              This   file  contains  the  kernel  virtual  memory
              accounting mode. Values are:
              0: heuristic overcommit (this is the default)
              1: always overcommit, never check
              2: always check, never overcommit
              In mode 0, calls of mmap(2) with MAP_NORESERVE  set
              are  not  checked,  and  the  default check is very
              weak, leading to the  risk  of  getting  a  process
              "OOM-killed".   Under  Linux  2.4 any nonzero value
              implies mode 1.  In mode 2 (available  since  Linux
              2.6), the total virtual address space on the system
              is limited to (SS + RAM*(r/100)), where SS  is  the
              size  of the swap space, and RAM is the size of the
              physical memory, and r is the contents of the  file
              /proc/sys/vm/overcommit_ratio.

       /proc/sys/vm/overcommit_ratio
              See the description of /proc/sys/vm/overcommit_mem

So, what you have is a bound on virtual memory, and that bound
can very easily be larger than twice physical memory.

Andries
