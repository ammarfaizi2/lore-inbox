Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTJON2G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTJON2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:28:06 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:57299 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S263178AbTJON2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:28:01 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Helge Hafting <helgehaf@aitel.hist.no>, Greg Stark <gsstark@mit.edu>
Subject: Re: statfs() / statvfs() syscall ballsup...
Date: Wed, 15 Oct 2003 15:25:40 +0200
User-Agent: KMail/1.5.4
Cc: Joel Becker <Joel.Becker@oracle.com>, Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310120909050.12190-100000@home.osdl.org> <878ynq3y7n.fsf@stark.dyndns.tv> <3F8A661B.80909@aitel.hist.no>
In-Reply-To: <3F8A661B.80909@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310151525.40470.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 October 2003 10:45, Helge Hafting wrote:
> Greg Stark wrote:
> [...]
> > In reality there is no time pressure on the vacuum at all. As long as it
> > completes faster than dead records can pile up it's fast enough. The
> > transactions on the other hand must complete as fast as possible.
>
> This seems almost trivial.  If the vacuum job runs too much,
> overusing disk bandwith - throttle it!

If you are using regular read/write syscalls and not too big chunks --> trivial.
If you mmap you database --> harder.

If you would like to tell the kernel, that this should not be treated
like a sequential read --> fadvise/madvise.

> This is easier than trying to tell the kernel that the job is
> less important, that goes wrong wether the job runs too much
> or too little.  Let that job  sleep a little when its services
> aren't needed, or when you need the disk bandwith elsewhere.


Here I agree as this seems like a solution. 

The problem is, that you sometimes need low latency for your
transactions and then you cannot start throttling a heavy IO process,
whose IO is already issued and who is basically just waiting for disk
eating its bandwidth.


The questions are: How IO-intensive vacuum? How fast can a throttling
free disk bandwidth (and memory)?


Regards

Ingo Oeser



